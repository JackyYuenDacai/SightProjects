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
        public static String connectstr = "";
        public static String sqlstr = "call tagScanned(@para1,@para2);";
        public const int CountTH = 3;
        public static IPPORT[] iparr = new IPPORT[50];
        public static TAGS[] TagsNear = new TAGS[50];
        public static int numOfReader = 0;
        public static Timer[] reg;
        public static Timer counterThread;
        public static MySqlConnection[] conn = new MySqlConnection[50];
        public static Dictionary<String, int>[] counter = new Dictionary<string, int>[50];
        public static void ClearCounter()
        {
            //AUTO CLEAR OF COUNTER OF EACH READER AFTER 5 SECS
            counterThread = new System.Threading.Timer(new System.Threading.TimerCallback(state =>
            {
                for(int i = 0; i < numOfReader; i++)
                {
                    counter[i].Clear();
                }
            }), 0, 0, 5000);
        }
        public static void RegularScan()
        {
            reg = new Timer[numOfReader];
            for (int i = 0; i < numOfReader; i++)
            {
                //CREATE THREAD FOR EACH READER
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
                MySqlCommand cmd = null;
                MySqlDataReader reader = null;
                System.Data.ConnectionState connectionstate = System.Data.ConnectionState.Open;
                //Console.WriteLine("THREAD NO:" + state);
                StaticClassReaderB.Inventory_G2(
                    ref Program.iparr[(int)state].ComAddr, 0, 1, 0
                    , epclenandepc, ref Program.iparr[k].numOfTags, ref cardnum,
                    Program.iparr[(int)state].PortHandle);
                Console.ForegroundColor = ConsoleColor.Yellow;
                if(cardnum>0)
                Console.WriteLine("READER#"+k+" NO OF CARD SCANNED:"+cardnum);
                Console.ForegroundColor = ConsoleColor.White;
                //PROCESS DATA FETCHED FROM READER
                for (int j = 0; j < cardnum; j++)
                {
                    Program.TagsNear[j].EPC = new byte[EPCLEN];
                    for (int a = 0; a < EPCLEN; a++)
                        Program.TagsNear[j].EPC[a] = epclenandepc[(j + 1) + j * EPCLEN + a];

                    Program.TagsNear[j].USER = new byte[16];
                    Console.WriteLine("\tTAG EPC SCANNED:" + BitConverter.ToString(Program.TagsNear[j].EPC));
                    if (counter[k].ContainsKey(BitConverter.ToString(Program.TagsNear[j].EPC)))
                    {
                        counter[k][BitConverter.ToString(Program.TagsNear[j].EPC)] += 1;
                    }
                    else
                    {
                        counter[k].Add(BitConverter.ToString(Program.TagsNear[j].EPC), 1);
                    }
                }
                //SEND DATA IF COUNTER >= 5
                for (int j = 0; j < cardnum; j++)
                {

                    if(counter[k].ContainsKey(BitConverter.ToString(Program.TagsNear[j].EPC)))
                    if (counter[k][BitConverter.ToString(Program.TagsNear[j].EPC)] >= CountTH)
                    {
                        counter[k][BitConverter.ToString(Program.TagsNear[j].EPC)] = 0;
                        Console.BackgroundColor = ConsoleColor.Red;Console.ForegroundColor = ConsoleColor.Blue;
                        Console.WriteLine("TAG RECORDED:" + BitConverter.ToString(Program.TagsNear[j].EPC));
                        Console.BackgroundColor = ConsoleColor.Black; Console.ForegroundColor = ConsoleColor.White;
                        connectionstate = conn[k].State;
                        if (connectionstate == System.Data.ConnectionState.Broken || connectionstate == System.Data.ConnectionState.Closed)
                        {
                            //conn[k].Dispose();
                            conn[k] = new MySqlConnection(connectstr);
                            try
                            {
                                conn[k].Open();
                                Console.WriteLine("Connected to the database");
                            }
                            catch (MySqlException ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                        //SENDING DATA TO DATABASE
                        try
                        {
                            while (!(conn[k].State.ToString() == "Open" && conn[k].State == System.Data.ConnectionState.Open))
                            {

                                Thread.Sleep(500);
                            }
                            cmd = new MySqlCommand(sqlstr, conn[k]);
                            cmd.Parameters.Add("@para1", MySqlDbType.String);
                            cmd.Parameters.Add("@para2", MySqlDbType.String);
                            cmd.Parameters["@para1"].Value = BitConverter.ToString(Program.TagsNear[j].EPC);//BitConverter.ToString(Program.TagsNear[j].USER);
                            cmd.Parameters["@para2"].Value = Program.iparr[k].Location;
                                
                            connectionstate = conn[k].State;
                            //CHECK IF PREVIOUS COMMAND COMPLETED
                            while (!(conn[k].State.ToString() == "Open" && conn[k].State == System.Data.ConnectionState.Open))
                            {

                                Thread.Sleep(500);
                            }
                            //MAKE SURE DATAREADER IS CLOSED
                            reader = cmd.ExecuteReader();
                                
                            //FETCH QUERY RESULT
                            while (reader.Read())
                            {
                                Console.WriteLine("RESULT:" + reader[0].ToString());
                            }

                            //MAKE SURE DATAREADER IS CLOSED
                            if (reader != null)
                                if (reader.IsClosed == false)
                                    reader.Close();
                            }
                            catch(Exception ex)
                            {
                                Console.WriteLine(ex.ToString());
                            }

                            }

                    }
                }), i, 0,50);
            }

        }


        static void Main(string[] args)
        {
            String tmpstr; int i = 0;
            StreamReader F = null;
            //TRY TO FETCH READER INFO FROM readerlist.txt
            try{
                F = File.OpenText("readerlist.txt");
            }
            //RETURN IF FAIL TO READ FROM readerlist.txt
            catch(Exception ex){
                Console.WriteLine(ex.Message+" READERLIST.TXT NOT FOUND");
                Console.ReadKey();
                return;
            }
            connectstr = F.ReadLine();
            while ((tmpstr = F.ReadLine())!=null)
            {
                Program.iparr[i].ip = tmpstr;
                Program.iparr[i].port = F.ReadLine();
                Program.iparr[i].Location = F.ReadLine();
                Program.iparr[i].portNum = int.Parse(Program.iparr[i].port);
                //NET CONNECT ASSIGN 0xFF TO PORTHANDLE TO GET THE ACTUAL HANDLE
                Program.iparr[i].PortHandle = 0xFF;
                i++;
            }
            numOfReader = i;
            Console.WriteLine("CONNECTING TO THE  DATABASE...");
            for (int l = 0; l < numOfReader; l++)
            {
                conn[l] = new MySqlConnection(connectstr);
                try
                {
                    conn[l].Open();
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("DATABASE CONNECTED.");
                    Console.ForegroundColor = ConsoleColor.White;

                }
                catch (MySqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                finally
                {
                    //conn.Close();
                }
                counter[l] = new Dictionary<string, int>();
            }



            for (int j = 0; j < numOfReader; j++)
            {
                i = StaticClassReaderB.OpenNetPort(Program.iparr[j].portNum,
                    Program.iparr[j].ip, ref Program.iparr[j].ComAddr,
                    ref Program.iparr[j].PortHandle);
                if (i == 0)
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    System.Console.WriteLine("READER AT LOCATION: \'" + Program.iparr[j].Location + "\'\tIP ADDRESS:" + Program.iparr[j].ip + "\tCONNECTED.");
                }
                else
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("READER AT LOCATION: \'" + Program.iparr[j].Location + "\'\tIP ADDRESS:" + Program.iparr[j].ip + "\tFAILED TO CONNECT.");
                }
                Console.ForegroundColor = ConsoleColor.White;

            }

            Console.WriteLine("PRESS ENTER TO START EVERYTHING");
            Console.WriteLine("PRESS Q TO QUIT");
            Console.ReadKey();
            RegularScan();
            ClearCounter();
            while (Console.ReadKey().Key != ConsoleKey.Q) ;

            for(int j = 0; j < numOfReader; j++)
            {
                reg[j].Dispose();
                StaticClassReaderB.CloseNetPort(Program.iparr[j].PortHandle);
                conn[j].Dispose();  
            }
        }
    }
}
