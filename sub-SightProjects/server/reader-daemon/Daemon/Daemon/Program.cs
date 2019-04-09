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
            "server=localhost;port=3306;user=root;password=root; database=caritas_db;";
        public static String sqlstr = "call tagScanned(@para1,@para2);";
        public static IPPORT[] iparr=new IPPORT[50];
        public static TAGS[] TagsNear = new TAGS[50];
        public static int numOfReader = 0;
        public static Timer[] reg;
        public static MySqlConnection conn;
        public static void RegularScan()
        {
            reg = new Timer[numOfReader];
            for(int i = 0; i < numOfReader; i++)
            {
                reg[i] = new System.Threading.Timer(new System.Threading.TimerCallback(state =>
                {
                byte[] epclenandepc = new byte[80000];
                byte[] data = new byte[80000];
                int datalen = 0;
                int EPCLEN = 12;
                int errorcode = 0;
                //EPC  len  == 12
                int cardnum = 0;
                int k = (int)state;
                StaticClassReaderB.Inventory_G2(
                    ref Program.iparr[(int)state].ComAddr, 0, 1, 0
                    , epclenandepc, ref Program.iparr[k].numOfTags, ref cardnum,
                    Program.iparr[(int)state].PortHandle);
                //Console.WriteLine("Inventory flashed");
                    for (int j = 0; j < cardnum; j++)
                    {

                        Program.TagsNear[j].EPC = new byte[EPCLEN];
                        for (int a = 0; a < EPCLEN; a++)
                            Program.TagsNear[j].EPC[a] = epclenandepc[(j + 1) + j * EPCLEN + a];

                        Program.TagsNear[j].USER = new byte[16];
                        //Console.WriteLine("TAG EPC SCANNED:" + BitConverter.ToString(Program.TagsNear[j].EPC));
                        StaticClassReaderB.ReadCard_G2(ref Program.iparr[k].ComAddr, Program.TagsNear[j].EPC, 3, 0, 4,
                            new byte[4] { 0, 0, 0, 0 }, 0, 0, 0, Program.TagsNear[j].USER, 12, ref errorcode, Program.iparr[k].PortHandle);
                        
                        if (!Program.TagsNear[j].USER.SequenceEqual(new byte[16] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }))
                        {
                            try
                            {
                                MySqlCommand cmd = new MySqlCommand(sqlstr, conn);
                                cmd.Parameters.Add("@para1", MySqlDbType.String);
                                cmd.Parameters.Add("@para2", MySqlDbType.String);
                                cmd.Parameters["@para1"].Value = BitConverter.ToString(Program.TagsNear[j].USER);
                                cmd.Parameters["@para2"].Value = Program.iparr[k].Location;
                                Console.WriteLine("DataScanned USER: " + BitConverter.ToString(Program.TagsNear[j].USER));

                                MySqlDataReader reader = cmd.ExecuteReader();
                                reader.Close();
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.ToString());
                            }
                        }

                    }
                }),i,0,2000);
            }
      
        }

        
        static void Main(string[] args)
        {
            String tmpstr;int i = 0;
            StreamReader F = null;
            /*
            try
            {
                F = File.OpenText("C://Users/ccyuenae/source/repos/Daemon/Daemon/bin/Debug/readerlist.txt");
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message+" READERLIST.TXT NOT FOUND");
                Console.ReadKey();
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
            }*/
            numOfReader = ++i;
            Program.iparr[0].ip = "192.168.16.254";
            Program.iparr[0].port = "6000";
            Program.iparr[0].Location = "0";
            Program.iparr[0].portNum = 6000;
            Program.iparr[0].PortHandle = 0xFF;
            Console.WriteLine("Connecting to the database");
            conn = new MySqlConnection(connectstr);
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
                //conn.Close();
            }


            for (int j = 0; j < numOfReader; j++)
            {
                i=StaticClassReaderB.OpenNetPort(Program.iparr[j].portNum,
                    Program.iparr[j].ip, ref Program.iparr[j].ComAddr,
                    ref Program.iparr[j].PortHandle);
                if (i == 0)
                    System.Console.WriteLine("Reader at " + Program.iparr[j].ip + " connected");

            }

            
            Console.ReadKey();
            RegularScan();
            Console.ReadKey();
        }
    }
}
