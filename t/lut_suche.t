# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl lut_suche.t'

use Test::More tests => 13;

BEGIN{use_ok('Business::KontoCheck','lut_init','lut_name1','lut_pz1','lut_plz1','lut_ort1',
      'lut_suche_ort','lut_suche_blz','pz2str','lut_suche_pz','lut_suche_plz','lut_suche_bic',
      'lut_suche_namen','lut_suche_namen_kurz','retval2txt_short','%kto_retval')};

sub chk_int
{
   my($fkt,$fkt_name,$arg1,$arg2,@blz,@idx,@val,$c11,$c21,$c22,$c31,$c32,$c33,$r1,$r2,$r3,$i,$cnt);
   $fkt=$_[0];
   $fkt_name=$_[1];
   $arg1=$_[2];
   $arg2=$_[3];

      # Aufruf in skalarem Kontext
   $p_blz=$fkt->($arg1,$arg2,$r1);
   @blz=@$p_blz;
   $c11=scalar(@blz);

      # Aufruf in Array-Kontext, eine Referenz ignoriert
   ($p_blz,$p_idx)=$fkt->($arg1,$arg2,$r2);
   @blz=@$p_blz;
   @idx=@$p_idx;
   $c21=scalar(@blz);
   $c22=scalar(@idx);

      # Aufruf in Array-Kontext
   ($p_blz,$p_idx,$p_val)=$fkt->($arg1,$arg2,$r3);
   @blz=@$p_blz;
   @idx=@$p_idx;
   @val=@$p_val;
   $c31=scalar(@blz);
   $c32=scalar(@idx);
   $c33=scalar(@val);
   $ok_msg="$fkt_name($arg1,$arg2): $c11 Banken gefunden, R�ckgabewerte: $r1 / $r2 / $r3  -> ".retval2txt_short($r1);
   ok(($c11>0 && $c11==$c21 && $c11==$c22 && $c11==$c31 && $c11==$c32 && $c11==$c33),$ok_msg);
   print "Hier die ersten Werte:\n";
   $cnt=($c11<10)?$c11:10;
   for($i=0;$i<$cnt;$i++){
      $b=$blz[$i];
      printf("%2d %s %2d [%d] %s, %s\n",$i+1,$b,$idx[$i],$val[$i],lut_name1($b),lut_ort1($b));
   }
   print "\n";
   return $c11;
}

sub chk_str
{
   my($fkt,$fkt_name,$arg,@blz,@idx,@val,$c11,$c21,$c22,$c31,$c32,$c33,$r1,$r2,$r3,$i,$cnt);
   $fkt=$_[0];
   $fkt_name=$_[1];
   $arg=$_[2];

      # Aufruf in skalarem Kontext
   $p_blz=$fkt->($arg,$r1);
   @blz=@$p_blz;
   $c11=scalar(@blz);

      # Aufruf in Array-Kontext, eine Referenz ignoriert
   ($p_blz,$p_idx)=$fkt->($arg,$r2);
   @blz=@$p_blz;
   @idx=@$p_idx;
   $c21=scalar(@blz);
   $c22=scalar(@idx);

      # Aufruf in Array-Kontext
   ($p_blz,$p_idx,$p_val)=$fkt->($arg,$r3);
   @blz=@$p_blz;
   @idx=@$p_idx;
   @val=@$p_val;
   $c31=scalar(@blz);
   $c32=scalar(@idx);
   $c33=scalar(@val);
   $ok_msg="$fkt_name('$arg'): $c11 Banken gefunden, R�ckgabewerte: $r1 / $r2 / $r3 -> ".retval2txt_short($r1);
   ok(($c11>0 && $c11==$c21 && $c11==$c22 && $c11==$c31 && $c11==$c32 && $c11==$c33),$ok_msg);
   print "Hier die ersten Werte:\n";
   $cnt=($c11<10)?$c11:10;
   for($i=0;$i<$cnt;$i++){
      $b=$blz[$i];
      printf("%2d %s %2d [%s] %s, %s\n",$i+1,$b,$idx[$i],$val[$i],lut_name1($b),lut_ort1($b));
   }
   print "\n";
   return $c11;
}

$retval=lut_init("blz.lut");
ok(($retval gt 0 || $retval==-38),"init: $retval => $kto_retval{$retval}");

chk_int(\&lut_suche_blz,"lut_suche_blz",10000000,10100000);
chk_int(\&lut_suche_plz,"lut_suche_plz",67000,67200);
chk_int(\&lut_suche_pz,"lut_suche_pz",98,102);
chk_str(\&lut_suche_ort,"lut_suche_ort","aa");
chk_str(\&lut_suche_namen,"lut_suche_namen","volksbank hei");
chk_str(\&lut_suche_namen_kurz,"lut_suche_namen_kurz","aachener");
chk_str(\&lut_suche_ort,"lut_suche_ort","mannheim");
chk_str(\&lut_suche_bic,"lut_suche_bic","genodef1a");

$retval=lut_init("blz.lut",9);
ok(($retval gt 0 || $retval==-38),"init: $retval => $kto_retval{$retval}");

chk_str(\&lut_suche_ort,"lut_suche_ort","aa");
chk_str(\&lut_suche_namen,"lut_suche_namen","volksbank hei");