# This is a small example for Business::KontoCheck. The program reads
# bank code numbers and account numbers from a file (delimited by at least one
# non-alphanumeric character), optionally followed by user comment. Then the
# account number is tested for validity and the line is written to the output.
# The test result is appended to the line. Empty lines or lines without bank
# code numbers or account number are copied to the output whithout
# modificaation.

# Dies ist eine kleine Beispielsanwendung f�r Business::KontoCheck. Das
# Programm list eine Reihe Bankleitzahlen und Kontonummern (durch mindestens
# ein nicht-alphanumerisches Zeichen getrennt) sowie noch evl. nachfolgenden
# Kommentar ein, testet das Konto auf G�ltigkeit und gibt die Zeile (erg�nzt
# durch den R�ckgabewert) wieder aus. Leerzeilen sowie Zeilen ohne Bankleitzahl
# oder Kontonummer werden unver�ndert ausgegeben.
#
# Geschrieben 9.6.07, Michael Plugge
# 8.2.08 erweitert f�r konto_check 3.0

use Business::KontoCheck qw(kto_check_init kto_check_blz lut_valid lut_name
     lut_plz lut_ort kto_check_pz lut_cleanup %kto_retval);

($ret=kto_check_init("../blz.lut"))>0 or die "Fehler bei der Initialisierung: $kto_retval{$ret}\n";
$ret=lut_valid();
print  "lut_valid: $ret => $kto_retval{$ret}\n";

open(IN,@ARGV[0]) or die "Kann ".@ARGV[0]." nicht �ffenen: $!\n";
open(OUT,"> testkonten.out") or die "Kann testkonten.out nicht �ffenen: $!\n";

while(<IN>){
   chomp;
      # eine Zeile aufdr�seln und den Variablen zuweisen
   ($valid,$blz,$separator,$kto,$rest)=/(([0-9a-zA-Z\-]+)([^0-9a-zA-Z]+)([0-9]+))?(.*)/;
   if($valid){
      if(length($blz)==8){ # BLZ angegeben
         $retval=kto_check_blz($blz,$kto);
         if($retval>0){   # OK -> Banknamen und Adresse ausgeben
            $name=": ".lut_name($blz).", ".lut_plz($blz)." ".lut_ort($blz);
         }
         else{ # Fehler, leer lassen
            $name="";
         }
      }
      else{    # Pr�fziffermethode angegeben
         $retval=kto_check_pz($blz,$kto);
         $name="";
      }
      print OUT "$blz$separator$kto$rest: $kto_retval{$retval}$name\n";
   }
   else{
      print OUT "$rest\n";
   }
}
lut_cleanup(); # Speicher freigeben

