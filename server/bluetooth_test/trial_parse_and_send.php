<?php
require __DIR__ . '/../vendor/autoload.php';
$sampleFile = __DIR__ . '/sample_gateway4_data.txt';
use AprBrother\PacketParser4;
$flag=mysql_connector('localhost','root','root');
$f=mysql_query('use caritas_main')
$parser = new AprBrother\PacketParser4();
$cont = file_get_contents($sampleFile);
$data = msgpack_unpack($cont);
$devices = $data['devices'];
unset($data['devices']);
echo "===== device data ====\n";
print_r($data);
foreach($devices as $v) {
    $adv = $parser->parse($v);
    echo $parser->hexString($adv->rawData);
    echo "\n";

/*TODO: exact mac and rssi from $devices by looking at parser, given byte 2 - 7 is mac address for BLE device and byte 8 is RSSI, minus 256 for real value*/

$conn="insert into bluetooth_test values(generate_unique_id(),$mac,$rssi)";
mysql_query($conn);
}