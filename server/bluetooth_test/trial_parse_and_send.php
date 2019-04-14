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

/*exact mac and rssi from $devices by looking at parser, given that in function phase() in PacketParser4.php:
$data->rssi = ord($v[self::OFFSET_RSSI]) - 255;
$data->macAddress = strtoupper(bin2hex(substr($v, self::OFFSET_MAC_ADDRESS, BLEAdvData::MAC_ADDRESS_LEN))); */

$mac=$adv->macAddress
$rssi=$adv->rssi

$conn="insert into bluetooth_test values(generate_unique_id(),$mac,$rssi)";
mysql_query($conn);
}