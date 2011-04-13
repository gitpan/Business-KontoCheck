# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl lut_info.t'

use Test::More tests => 3;

BEGIN { use_ok('Business::KontoCheck', 'lut_info', 'lut_init', '%kto_retval') };

$ok_cnt=$nok_cnt=0;
$retval=lut_init("blz.lut");
if($retval>0){$ok_cnt++;}else{$nok_cnt++;}
ok($retval gt 0,"init: $retval => $kto_retval{$retval} (ok: $ok_cnt, nok: $nok_cnt)");

if($retval>0){
	@tmp= lut_info('blz.lut');
   ok($#tmp>0,"LUT_info: Es wurden " . scalar(@tmp) . " Variablen durch lut_info() geladen");
   printf "lut_dir:\n%s\n",$tmp[5];
}
