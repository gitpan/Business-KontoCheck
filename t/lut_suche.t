# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl lut_suche.t'

use Test::More tests => 7;

BEGIN{use_ok('Business::KontoCheck','lut_init','lut_name1','lut_pz1','lut_plz1',
      'lut_suche_ort','lut_suche_blz','pz2str','lut_suche_pz','lut_suche_plz','%kto_retval')};

$retval=lut_init("blz.lut");
ok($retval gt 0,"init: $retval => $kto_retval{$retval}");

if($retval>0){
   printf("\nArray-Kontext:\n");
   ($p_blz,$p_idx,$p_ort)=lut_suche_ort("aa");
   @blz=@$p_blz;
   @idx=@$p_idx;
   @ort=@$p_ort;
   ok($#blz>0,"LUT_suche_plz: Es wurden " . scalar(@blz) . " Banken mit dem Anfangsbuchstaben aa im Ort gefunden");
   $i=0;
   foreach $b (@blz){printf( "BLZ %d, idx: %2d, Ort: %s => %s\n",$b,$idx[$i], $ort[$i],lut_name1($b,$idx[$i]));$i++; }

   printf("\nArray-Kontext, eine Variable ignoriert:\n");
   ($p_blz2,$p_idx2)=lut_suche_plz(68000,68200);
   @blz2=@$p_blz2;
   @idx2=@$p_idx2;
   ok($#blz2>0,"LUT_suche_plz: Es wurden " . scalar(@blz2) . " Banken mit PLZ zwischen 68000 und 68200 gefunden");
   $i=0;
   foreach $b (@blz2){
      $idx=$idx2[$i];
      printf( "BLZ %d, idx: %2d => (PLZ %d) %s\n",$b,$idx,lut_plz1($b,$idx),lut_name1($b));
      $i++;
   }

   printf("\nSkalarer Kontext:\n");
   $p_blz1=lut_suche_blz(10000000,10050000);
   @blz1=@$p_blz1;
   ok($#blz1>0,"LUT_suche_blz: Es wurden " . scalar(@blz1) . " Banken mit BLZs zwischen 10000000 und 10050000 gefunden");
   foreach $b (@blz1){printf( "BLZ %d => %s\n",$b,lut_name1($b));}

   printf("\nBanken mit Prüfzifferverfahren 98 bis A3:\n");
   $p_blz1=lut_suche_pz(98,103);
   @blz1=@$p_blz1;
   ok($#blz1>0,"LUT_suche_pz: Es wurden " . scalar(@blz1) . " Banken mit den Verfahren 98 bis A3 gefunden");
   foreach $b (@blz1){printf("BLZ %d (Pz %s) => %s\n",$b,pz2str(lut_pz1($b)),lut_name1($b));}

   printf("\nBanken ohne Prüfzifferverfahren:\n");
   $p_blz1=lut_suche_pz(9);
   @blz1=@$p_blz1;
   ok($#blz1>0,"LUT_suche_pz: Es wurden " . scalar(@blz1) . " Banken ohne Kontoprüfung (Verfahren 09) gefunden");
}
