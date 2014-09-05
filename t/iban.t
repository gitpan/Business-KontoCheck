# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl iban.t'

use Test::More tests => 118;

BEGIN { use_ok('Business::KontoCheck') };

# Initialisierung f�r deutsche Konten notwendig
$ok_cnt=$nok_cnt=0;
$retval=lut_init("blz.lut");
$ret_txt=$kto_retval{$retval};
if($retval gt 0){$ok_cnt++;}else{$nok_cnt++;}
ok($retval gt 0,"lut_init(): $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

if($retval gt 0){
   while(<DATA>){
      chomp;
      ($ret,$iban)=split(/ /);
      $retval=Business::KontoCheck::iban_check($iban,$r1);
      $ret_txt=$kto_retval{$retval};
      $kc_retval=$kto_retval{$r1};
      if($ret eq $retval){$ok_cnt++;}else{$nok_cnt++;}
      ok($ret eq $retval,"check_iban von $iban: $retval/$r1 (Soll: $ret) (ok: $ok_cnt, nok: $nok_cnt)\n        IBAN-Retval: $ret_txt\n        KC-Retval:   $kc_retval");
   }
}

# Der erste Teil der Daten stammt aus http://www.vr-bank-fn.de/etc/medialib/i500m0192/downloads.Par.0005.File.tmp/IBANLIST.pdf
# Einige sind allerdings falsch; sie wurden mit einem unabh�ngigen Programm �berpr�ft.
# Die zweite Gruppe stammt von http://www.iban-rechner.eu/ibancalculator/iban.de.html; sie sind alle korrekt.
# Eine dritte Gruppe findet sich unter http://www.toms-cafe.de/iban/iban.de.html (ebenfalls komplett ok).
# Die Dubletten (etwa die H�lfte) wurden entfernt.
# Als letztes sind noch die IBAN-Fallen von www.ckonto.de enthalten; hier wurde allerdings ein R�ckgabewert korrigiert.
# Die IBAN DE73101206001234567897 ist korrekt; sie stammt zwar von der Santander Bank, diese hat f�r die BLZ jedoch die
# Regel 0 spezifiziert, nicht 46; somit mu� die BLZ nicht ersetzt werden. Die IBAN wird auch von ckonto selbst als korrekt
# akzeptiert :-) (Aufruf 7.3.14)

__DATA__
0 MT87MALT011000012345MTLCAST001S
0 SE1212312345678901234561
0 TN5912345678901234567890
1 AD1200012030200359100100
1 AT611904300234573201
1 BA391290079401028494
1 BE68539007547034
1 BG80BNBG96611020345678
1 CH9300762011623852957
1 CY17002001280000001200527600
1 CZ6508000000192000145399
1 DE89370400440532013000
1 DE92600501017486501274
1 DK5000400440116243
1 EE382200221020145685
1 ES9121000418450200051332
1 FI2112345600000785
1 FO2000400440116243
1 FR1420041010050500013M02606
1 GB29NWBK60161331926819
1 GI75NWBK000000007099453
1 GI75NWBK000000007099453	
1 GL2000400440116243
1 GR1601101250000000012300695
1 GR4101402940294002320000587
1 GR7303801150000000001208017
1 HR1210010051863000160
1 HU42117730161111101800000000
1 IE29AIBK93115212345678
1 IS140159260076545510730339
1 IT60X0542811101000000123456
1 LI0900762011623852957
1 LI21088100002324013AA
1 LT121000011101001000
-121 LU2800194000644750000
1 LU280019400644750000
1 LV80BANK0000435195001
1 MC9320041010050500013M02606
1 ME25505000012345678951
1 MK07300000000042425
1 MT84MALT011000012345MTLCAST001S
1 MU17BOMM0101101030300200000MUR
1 NL91ABNA0417164300
1 NO9386011117947
1 PL27114020040000300201355387
1 PL61109010140000071219812874
1 PT50000201231234567890154
1 RO49AAAA1B31007593840000
1 RS35260005601001611379
1 SE3550000000054910000003
1 SI56191000000123438
1 SK3112000000198742637541
1 SM88X0542811101000000123456
1 TN5914207207100707129648
1 TR330006100519786457841326
1 DE43100500000920018963
1 DE30701500001000506517
1 DE98370501980015002223
1 DE03683515573047232594
1 DE89500502010000180802
1 DE36320500000000047803
1 DE95500500005000002096
1 DE15300500000000060624
1 DE09300606010012345671
1 DE92370601930002130041
1 DE68371600870018128012
1 DE95380601865000500013
1 DE61390601801221864014
1 DE82501203830020475000
1 DE03360200300000900826
1 DE22430609672222200000
1 DE76265900251000700800
1 DE81600501010002777939
21 DE21350601900000055111
21 DE23320603620000004444
1 DE69250501800000017095
1 DE02512108000260123456
21 DE07130910549370620080
1 DE77545201946790149813
1 DE32210500000101105000
1 DE41300107000000123456
1 DE46280200501234567490
1 DE17680523280006015002
1 DE96500604000000011404
1 DE49666500850000000868
1 DE51680501010002282022
1 DE67310108331234567897
1 DE63201333001234567800
-130 DE33100500000000484848
-130 DE47701500000034343434
-130 DE37370501980015000023
-130 DE56683519761116232594
-130 DE81500502010000800000
-130 DE20320500000000047800
-143 DE44508500495000002096
-143 DE56400500000000060624
-143 DE71330606160012345671
-130 DE44370601930002120041
-130 DE03371600870000300000
-130 DE63380601860050005000
-130 DE03390601800000202050
-143 DE95501301000020475000
-143 DE95362200300000900826
-130 DE36430609670001111111
-130 DE43265900250000000700
-143 DE49641501820002777939
-143 DE63250502990000017095
-130 DE81512108002600123456
-130 DE80200500000000101105
-143 DE46201107000000123456
-143 DE84256213271234567490
-130 DE27622200001234567890
-143 DE45606510700000000868
-130 DE29680501010000000202
1 DE73101206001234567897
-130 DE31201333000012345678
