# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Business-KontoCheck.t'

use Test::More tests => 22;

BEGIN { use_ok('Business::KontoCheck') };

$ok_cnt=$nok_cnt=0;
$retval=lut_init("blz.lut");
$ret_txt=$kto_retval{$retval};
if($retval>0){$ok_cnt++;}else{$nok_cnt++;}
ok($retval gt 0,"init: $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

if($retval>0){
   while(<DATA>){
      chomp;
      ($blz,$soll)=split(/:/);
      ($retval,$cnt,$name,$name_kurz,$plz,$ort)=Business::KontoCheck::lut_multiple($blz);
      $ergebnis="$name_kurz, $plz $ort";
      $cnt=$name=0; # nur wegen Warnung wegen dummy-Variablen
      if($ergebnis eq $soll){$ok_cnt++;}else{$nok_cnt++;}
      ok($ergebnis eq $soll,"LUT2: $ergebnis (Soll: $soll) (ok: $ok_cnt, nok: $nok_cnt)");
   }
}

__DATA__
10010010:Postbank Berlin, 10916 Berlin
14051462:Sparkasse Schwerin -alt-, 19053 Schwerin, Meckl
15051732:Spk Mecklenburg-Strelitz, 17235 Neustrelitz
16050000:Mittelbrandenbg Sparkasse, 14459 Potsdam
17052302:St Spk Schwedt, 16303 Schwedt /Oder
18062678:VR Bank Lausitz, 3044 Cottbus
20040000:Commerzbank Hamburg, 20454 Hamburg
20050550:Haspa Hamburg, 20454 Hamburg
20080000:Dresdner Bank Hamburg, 20349 Hamburg
21050170:Förde Sparkasse, 24103 Kiel
21566356:Volks- u Raiffeisenbank, 24389 Süderbrarup
25010030:Postbank Hannover, 30139 Hannover
25020600:GE Money Bank, 30154 Hannover
25020700:Hanseatic Bank Hannover, 30159 Hannover
25050180:Sparkasse Hannover, 30001 Hannover
30050000:WestLB Düsseldorf, 40002 Düsseldorf
30070010:Deutsche Bank Düsseldorf, 40189 Düsseldorf
50951469:Sparkasse Starkenburg, 64646 Heppenheim (Bergstraße)
54510067:Postbank Ludwigshafen, 67057 Ludwigshafen am Rhein
54651240:Spk Rhein-Haardt, 67087 Bad Dürkheim
