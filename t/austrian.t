# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl austrian.t'

use Test::More tests => 41;

BEGIN { use_ok('Business::KontoCheck') };

$ok_cnt=$nok_cnt=0;
while(<DATA>){
   chomp;
   ($ret,$blz,$kto)=split(/ /);
   $retval=kto_check_at($blz,$kto,"");
   $ret_txt=$kto_retval{$retval};
   if($retval==$ret){$ok_cnt++;}else{$nok_cnt++;}
   ok(kto_check_at($blz,$kto,"") eq $ret,"AT BLZ/KTO $blz $kto: $retval (Soll: $ret) => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");
}

__DATA__
1 14000 00115303384
1 14000 00159001040
1 31000 00000975409
1 40000 59990080003
1 40000 68136400006
1 12000 04975889900
1 -60000 1740400
1 -60000 7622670
1 12000 04975889900
1 15000 611803412
1 12000 04975889900
-4 20851 2100251301
1 31000 109313032
1 p001b1100039310003934800191e8bb45410 243551900
1 p001b1100039310003934800191e8bb45410 10511872300
1 p001b1100039310003934800191e8bb45410 60420313607
1 p001b1100039310003934800191e8bb45410 870149200
1 p001b1100039310003934800191e8bb45410 10412006400
1 p001b123 184800071
1 p001a1100019310 700320401
1 p001b121 115130889
1 p0019121 98000821896
1 pb439341b548421b239341001b131 18600
1 pb439341b548421b239341001b131 16500
1 pb439341b548421b239341001b131 16640
1 pb439341b548421b239341001b131 31994814
1 p001b1100039310003934800191e8bb45410 00405623703
1 p001b1100039310003934800191e8bb45410 00000200800
1 p001b1100039310003934800191e8bb45410 60013017000
1 p001b1100039310003934800191e8bb45410 66013446400
1 p001b1100039310003934800191e8bb45410 76413138500
1 p0018110 975409
1 pb957510bc57510001b110 59990080003
1 pb957510bc57510001b110 94111900000
1 pb957510bc57510001b110 68136400006
1 p0039348001b110 90027204700
1 pb957510001b121 155023007
1 pb957510001b121 95172101000
1 p001b166 7598656
1 p001b166 7000058
