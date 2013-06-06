# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl base.t'

use Test::More tests => 17;

BEGIN { use_ok('Business::KontoCheck') };

$ok_cnt=1;
$nok_cnt=0;

# generate a basic lutfile with only a few blocks
$retval=Business::KontoCheck::generate_lut2("blz.txt","blz_pl.lut","User-Info Zeile","20101201-20101202",3,0);
$ret_txt=$kto_retval{$retval};
if($retval gt 0){$ok_cnt++;} else{$nok_cnt++;}
ok($retval gt 0,"generate_lut(): $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");
($ret,$info1,$valid1)=Business::KontoCheck::lut_info('blz_pl.lut');
($i1,$i2,$i3,$i4,$i5,$i6,$i7)=split /\n/,$info1;
print "ret: $ret, valid1: $valid1\ni1: >>$i1<<\ni2: >>$i2<<\ni3: >>$i3<<\ni4: >>$i4<<\ni5: >>$i5<<\ni6: >>$i6<<\ni7: >>$i7<<\n";

$i1_soll="Gueltigkeit der Daten: 20101201-20101202 (Erster Datensatz)";
$i2_soll="Enthaltene Felder: BLZ, PZ+, NAME+, PLZ+, ORT+";
$i3_soll="";
$i4_soll="BLZ Lookup Table/Format 2.0";
$i5_soll="LUT-Datei generiert am 27.7.2012, 12:11 aus blz.txt\\";
$i6_soll="User-Info Zeile";
$i7_soll="Anzahl Banken: 104, davon Hauptstellen: 62 (inkl. 4 Testbanken)";

if($i1 eq $i1_soll){$i1_ok=1; $ok_cnt++;} else{$i1_ok=0; $nok_cnt++;}
ok($i1_ok eq 1,"lut_info() Zeile 1/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");
if($i2 eq $i2_soll){$i2_ok=1; $ok_cnt++;} else{$i2_ok=0; $nok_cnt++;}
ok($i2_ok eq 1,"lut_info() Zeile 2/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");
if($i3 eq $i3_soll){$i3_ok=1; $ok_cnt++;} else{$i3_ok=0; $nok_cnt++;}
ok($i3_ok eq 1,"lut_info() Zeile 3/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");
if($i4 eq $i4_soll){$i4_ok=1; $ok_cnt++;} else{$i4_ok=0; $nok_cnt++;}
ok($i4_ok eq 1,"lut_info() Zeile 4/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");
# line 5 changes at each invocation; don't test
if($i6 eq $i6_soll){$i6_ok=1; $ok_cnt++;} else{$i6_ok=0; $nok_cnt++;}
ok($i6_ok eq 1,"lut_info() Zeile 6/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");
if($i7 eq $i7_soll){$i7_ok=1; $ok_cnt++;} else{$i7_ok=0; $nok_cnt++;}
ok($i7_ok eq 1,"lut_info() Zeile 7/Satz 1 (ok: $ok_cnt, nok: $nok_cnt)");

### #generate a basic lutfile (only 100 banks, just for test purposes)
### $retval=lut_init("blz_pl.lut",9);
### $iban=Business::KontoCheck::iban_gen("10077777","1234566",$retval);
### $ret_txt=$kto_retval{$retval};
### if($retval eq -110){$ok_cnt++;} else{$nok_cnt++;}
### ok($retval eq -110,"iban_gen Test 1: $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

# append the IBAN blacklist to the lutfile
$retval=Business::KontoCheck::lut_keine_iban_berechnung("CONFIG.INI","blz_pl.lut");
$ret_txt=$kto_retval{$retval};
if($retval gt 0){$ok_cnt++;} else{$nok_cnt++;}
ok($retval gt 0,"lut_keine_iban_berechnung: $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

### # check for iban-block using call to iban_gen (this call should generate error -113 instead of -110)
### Business::KontoCheck::lut_cleanup();   # first release all blocks
### $retval=lut_init("blz_pl.lut");
### $iban=Business::KontoCheck::iban_gen("21500000","1234567",$retval);
### $ret_txt=$kto_retval{$retval};
### if($retval eq -113){$ok_cnt++;} else{$nok_cnt++;}
### ok($retval eq -113,"iban_gen Test 2: $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

$retval=Business::KontoCheck::generate_lut2("blz.txt","blz_pl.lut","User-Info Zeile","20101204-20101205",9,1,0,0,2);
$ret_txt=$kto_retval{$retval};
if($retval gt 0){$ok_cnt++;} else{$nok_cnt++;}
ok($retval gt 0,"generate_lut(): $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

($ret,$info1,$valid1,$info2,$valid2)=Business::KontoCheck::lut_info('blz_pl.lut');
($i1,$i2,$i3,$i4,$i5,$i6,$i7)=split /\n/,$info2;
print "ret: $ret, valid2: $valid2\ni1: >>$i1<<\ni2: >>$i2<<\ni3: >>$i3<<\ni4: >>$i4<<\ni5: >>$i5<<\ni6: >>$i6<<\ni7: >>$i7<<\n";
ok($retval gt 0,"lut_keine_iban_berechnung(): $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

$i1_soll="Gueltigkeit der Daten: 20101204-20101205 (Zweiter Datensatz)";
$i2_soll="Enthaltene Felder: BLZ, PZ+, FILIALEN, VOLLTEXT_TXT, NAME_NAME_KURZ+, PLZ+, ORT+, BIC+, NACHFOLGE_BLZ, AENDERUNG, LOESCHUNG, PAN, NR";
$i3_soll="";
$i4_soll="BLZ Lookup Table/Format 2.0";
$i5_soll="LUT-Datei generiert am 27.7.2012, 12:11 aus blz.txt\\";
$i6_soll="User-Info Zeile";
$i7_soll="Anzahl Banken: 104, davon Hauptstellen: 62 (inkl. 4 Testbanken)";

if($i1 eq $i1_soll){$i1_ok=1; $ok_cnt++;} else{$i1_ok=0; $nok_cnt++;}
ok($i1_ok eq 1,"lut_info() Zeile 1/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");
if($i2 eq $i2_soll){$i2_ok=1; $ok_cnt++;} else{$i2_ok=0; $nok_cnt++;}
ok($i2_ok eq 1,"lut_info() Zeile 2/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");
if($i3 eq $i3_soll){$i3_ok=1; $ok_cnt++;} else{$i3_ok=0; $nok_cnt++;}
ok($i3_ok eq 1,"lut_info() Zeile 3/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");
if($i4 eq $i4_soll){$i4_ok=1; $ok_cnt++;} else{$i4_ok=0; $nok_cnt++;}
ok($i4_ok eq 1,"lut_info() Zeile 4/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");
# line 5 changes at each invocation; don't test
if($i6 eq $i6_soll){$i6_ok=1; $ok_cnt++;} else{$i6_ok=0; $nok_cnt++;}
ok($i6_ok eq 1,"lut_info() Zeile 6/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");
if($i7 eq $i7_soll){$i7_ok=1; $ok_cnt++;} else{$i7_ok=0; $nok_cnt++;}
ok($i7_ok eq 1,"lut_info() Zeile 7/Satz 2 (ok: $ok_cnt, nok: $nok_cnt)");

