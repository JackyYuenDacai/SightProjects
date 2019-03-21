using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.IO;
using ReaderB;
using System.Threading;
using MySql.Data.MySqlClient;

namespace Daemon
{
    struct IPPORT
    {
        public String ip;
        public String port;
        public int portNum;
        public byte ComAddr;
        public int PortHandle;
        public String Location;
        public int numOfTags;
    };
    struct TAGS
    {
        public byte[] EPC;
        public byte[] USER;
        public String TID;
        public String Location;
    };
    class Program
    {
        public static String connectstr =
            "server=127.0.0.1;port=3306;user=root;password=root; database=caritas_db;";
        public static String sqlstr = "call tagScanned('@para1','@para2');";
        public static IPPORT[] iparr=new IPPORT[50];
        public static TAGS[] TagsNear = new TAGS[50];
        public static int numOfReader = 0;
        public static Timer[] reg;
        public static void RegularScan()
        {
            reg = new Timer[numOfReader];
            for(int i = 0; i < numOfReader; i++)
            {
                reg[i] = new System.Threading.Timer(new System.Threading.TimerCallback(state=> 
                {
                    byte[] epclenandepc = new byte[80000];
                    byte[] data = new byte[80000];
                    int datalen = 0;
                    int EPCLEN = 12;
                    int errorcode = 0;
                    //EPC  len  == 12
                    int cardnum=0;
                    int k = (int)state;
                    StaticClassReaderB.Inventory_G2(
                        ref Program.iparr[(int)state].ComAddr,0,1,0
                        ,epclenandepc,ref Program.iparr[k].numOfTags,ref cardnum,
                        Program.iparr[(int)state].PortHandle);
                    for(int j = 0; j < cardnum; j++)
                    {
                      
                        Program.TagsNear[j].EPC = new byte[EPCLEN];
                        for (int a = 0; a < EPCLEN; a++)
                            Program.TagsNear[j].EPC[a] = epclenandepc[j + j * EPCLEN + a];

                        Program.TagsNear[j].USER = new byte[16];
                        StaticClassReaderB.ReadCard_G2(ref Program.iparr[k].ComAddr,Program.TagsNear[j].EPC, 0, 0, 16,
                            new byte[4] { 0, 0, 0, 0 }, 0, 0, 0, Program.TagsNear[j].USER, 8, ref errorcode, Program.iparr[k].PortHandle);

                        MySqlCommand cmd = new MySqlCommand(sqlstr, conn);
                        cmd.Parameters.AddWithValue("para1", Program.TagsNear[j].USER.ToString());
                        cmd.Parameters.AddWithValue("para2", Program.iparr[k].Location);

                        MySqlDataReader reader = cmd.ExecuteReader();
                        if (!reader.Read()){
                            Console.WriteLine("Database insert data error");
                        }
                    }
                }),i,Timeout.Infinite,2000);
            }
      
        }

        public static MySqlConnection conn;
        static void Main(string[] args)
        {
            String tmpstr;int i = 0;
            StreamReader F = null;
            try
            {
                F = File.OpenText("READERLIST.TXT");
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message+" READERLIST.TXT NOT FOUND");
                return;
            }
            //int.Parse(myFile.ReadLine());
            while ((tmpstr = F.ReadLine())!=null)
            {
                Program.iparr[i].ip = tmpstr;
                Program.iparr[i].port = F.ReadLine();
                Program.iparr[i].Location = F.ReadLine();
                Program.iparr[i].portNum = int.Parse(Program.iparr[i].port);
                i++;
            }
            numOfReader = i;

            Console.WriteLine("Connecting to the database");
            MySqlConnection conn = new MySqlConnection(connectstr);
            try
            {
                conn.Open();
                Console.WriteLine("Connected to the database");

            }
            catch (MySqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                conn.Close();
            }


            for (int j = 0; j < numOfReader; j++)
            {
                i=StaticClassReaderB.OpenNetPort(Program.iparr[i].portNum,
                    Program.iparr[i].ip, ref Program.iparr[j].ComAddr,
                    ref Program.iparr[i].PortHandle);
                if (i == 0)
                    System.Console.WriteLine("Reader at " + Program.iparr[j].ip + " connected");

            }

            RegularScan();
        }
    }
}
