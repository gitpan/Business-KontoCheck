#vim:tw=70:ft=perl:si

package Business::KontoCheck;

use 5.006000;
use strict;
use warnings;
use encoding 'ISO8859-1';

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw( kto_check kto_check_str kto_check_blz
   kto_check_pz generate_lut generate_lut2 lut_cleanup lut_valid
   lut_init kto_check_init copy_lutfile lut_multiple lut_filialen
   lut_blz lut_name lut_name_kurz lut_plz lut_ort lut_pan lut_bic
   lut_pz lut_aenderung lut_loeschung lut_nachfolge_blz lut_blz1
   lut_name1 lut_name_kurz1 lut_plz1 lut_ort1 lut_pan1 lut_bic1
   lut_pz1 lut_aenderung1 lut_loeschung1 lut_nachfolge_blz1 iban_gen
   check_iban ipi_check ipi_gen set_verbose_debug lut_info
   set_default_compression iban2bic pz2str kto_check_encoding
   kto_check_encoding_str keep_raw_data retval2txt retval2txt_short
   retval2iso retval2utf8 retval2html retval2dos kto_check_retval2txt
   kto_check_retval2txt_short kto_check_retval2utf8
   kto_check_retval2html dump_lutfile kto_check_retval2dos
   lut_suche_blz lut_suche_pz lut_suche_plz lut_suche_bic
   lut_suche_volltext lut_suche_namen lut_suche_namen_kurz
   lut_suche_ort lut_suche_multiple konto_check_at kto_check_at_str
   generate_lut_at %kto_retval %kto_retval_kurz lut_keine_iban_berechnung);

our @EXPORT = qw( lut_init kto_check kto_check_blz kto_check_at %kto_retval );

our $VERSION = '4.3';

require XSLoader;
XSLoader::load('Business::KontoCheck', $VERSION);

# Preloaded methods go here.

sub lut_info
{
   my $lut_name;
   my $ret=1;
   my $info1;
   my $info2;
   my $valid1;
   my $valid2;
   my $lut_dir;
   my $args;

   if(scalar(@_)==1){
      $lut_name=$_[0];
      $args=0;
   }
   else{
      $lut_name="";
      $args=-2;
   }
   if(wantarray()){
      $ret=lut_info_i($lut_name,1+$args,$info1,$valid1,$info2,$valid2,$lut_dir);
      return ($ret,$info1,$valid1,$info2,$valid2,$lut_dir);
   }
   else{
      $ret=lut_info_i($lut_name,$args,$info1,$valid1,$info2,$valid2,$lut_dir);
      return $ret;
   }
}

sub current_lutfile_name
{
   my $lut_name;
   my $set;
   my $level;
   my $retval;

   if(wantarray()){
      $lut_name=current_lutfile_name_i(1,$set,$level,$retval);
      return ($lut_name,$set,$level,$retval);
   }
   else{
      $lut_name=current_lutfile_name_i(0,$set,$level,$retval);
      return $lut_name;
   }
}

sub lut_multiple
{
   my $blz;
   my $filiale;
   my $cnt;
   my $name;
   my $name_kurz;
   my $plz;
   my $ort;
   my $pan;
   my $bic;
   my $pz;
   my $nr;
   my $aenderung;
   my $loeschung;
   my $nachfolge_blz;
   my $id;
   my $ret;

   if(scalar(@_)<1){ #keine BLZ angegeben, leere Liste zur�ck
      return ();
   }
   if(scalar(@_)<2){ #keine Filiale angegeben, Hauptstelle nehmen
      $filiale=0;
   }
   else{
      $filiale=$_[1];
   }
   $blz=$_[0];
   $cnt=$name=$name_kurz=$plz=$ort=$pan=$bic=$pz=$nr=$aenderung=$loeschung=$nachfolge_blz=0;
   $ret=lut_multiple_i($blz,$filiale,$cnt,$name,$name_kurz,$plz,$ort,$pan,$bic,$pz,$nr,$aenderung,$loeschung,$nachfolge_blz);
   if(wantarray()){
      return ($ret,$cnt,$name,$name_kurz,$plz,$ort,$pan,$bic,$pz,$nr,$aenderung,$loeschung,$nachfolge_blz);
   }
   else{
      return $ret;
   }
}

sub ipi_gen
{
   my $r;
   my $zweck;
   my $retval;
   my $papier;

   if(scalar(@_)==0){
      return "";
   }
   else{
      $zweck=$_[0];
   }
   $r=ipi_gen_i($zweck,$retval,$papier);
   if(wantarray()){
      return ($retval,$papier,$r);
   }
   else{
      return $retval;
   }
}

sub lut_filialen
{
   my $r=1;
   my $v;

   $v=lut_filialen_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_suche_bic
{
   if(wantarray()){
      return lut_suche_c(1,1,@_);
   }
   else{
      return lut_suche_c(0,1,@_);
   }
}


sub lut_suche_namen
{
   if(wantarray()){
      return lut_suche_c(1,2,@_);
   }
   else{
      return lut_suche_c(0,2,@_);
   }
}


sub lut_suche_namen_kurz
{
   if(wantarray()){
      return lut_suche_c(1,3,@_);
   }
   else{
      return lut_suche_c(0,3,@_);
   }
}


sub lut_suche_ort
{
   if(wantarray()){
      return lut_suche_c(1,4,@_);
   }
   else{
      return lut_suche_c(0,4,@_);
   }
}


sub lut_suche_blz
{
   if(wantarray()){
      return lut_suche_i(1,1,@_);
   }
   else{
      return lut_suche_i(0,1,@_);
   }
}


sub lut_suche_pz
{
   if(wantarray()){
      return lut_suche_i(1,2,@_);
   }
   else{
      return lut_suche_i(0,2,@_);
   }
}


sub lut_suche_plz
{
   if(wantarray()){
      return lut_suche_i(1,3,@_);
   }
   else{
      return lut_suche_i(0,3,@_);
   }
}



sub lut_suche_volltext
{
   if(wantarray()){
      return lut_suche_volltext_i(1,@_);
   }
   else{
      return lut_suche_volltext_i(0,@_);
   }
}

sub lut_suche_multiple
{
   if(wantarray()){
      return lut_suche_multiple_i(1,@_);
   }
   else{
      return lut_suche_multiple_i(0,@_);
   }
}

sub lut_blz
{
   my $r;

   $r=lut_blz_i(@_);
   if(wantarray()){
      return ($r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $r;
   }
}

sub lut_blz1
{
   return lut_blz_i(@_);
}

sub lut_name
{
   my $r=1;
   my $v;

   $v=lut_name_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_name1
{
   my $r=1;

   return lut_name_i($r,@_);
}

sub lut_name_kurz
{
   my $r=1;
   my $v;

   $v=lut_name_kurz_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_name_kurz1
{
   my $r=1;

   return lut_name_kurz_i($r,@_);
}

sub lut_plz
{
   my $r=1;
   my $v;

   $v=lut_plz_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_plz1
{
   my $r=1;

   return lut_plz_i($r,@_);
}

sub lut_ort
{
   my $r=1;
   my $v;

   $v=lut_ort_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_ort1
{
   my $r=1;

   return lut_ort_i($r,@_);
}

sub lut_pan
{
   my $r=1;
   my $v;

   $v=lut_pan_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_pan1
{
   my $r=1;

   return lut_pan_i($r,@_);
}

sub lut_bic
{
   my $r=1;
   my $v;

   $v=lut_bic_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_bic1
{
   my $r=1;

   return lut_bic_i($r,@_);
}

sub lut_pz
{
   my $r=1;
   my $v;

   $v=lut_pz_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_pz1
{
   my $r=1;

   return lut_pz_i($r,@_);
}

sub lut_aenderung
{
   my $r=1;
   my $v;

   $v=lut_aenderung_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_aenderung1
{
   my $r=1;

   return lut_aenderung_i($r,@_);
}

sub lut_loeschung
{
   my $r=1;
   my $v;

   $v=lut_loeschung_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_loeschung1
{
   my $r=1;

   return lut_loeschung_i($r,@_);
}

sub lut_nachfolge_blz
{
   my $r=1;
   my $v;

   $v=lut_nachfolge_blz_i($r,@_);
   if(wantarray()){
      return ($v,$r,$Business::KontoCheck::kto_retval{$r},$Business::KontoCheck::kto_retval_kurz{$r});
   }
   else{
      return $v;
   }
}

sub lut_nachfolge_blz1
{
   my $r=1;

   return lut_nachfolge_blz_i($r,@_);
}


%Business::KontoCheck::kto_retval = (
-121 => 'Die L�nge der IBAN f�r das angegebene L�nderk�rzel ist falsch',
-120 => 'Keine Bankverbindung/IBAN angegeben',
-119 => 'Ung�ltiges Zeichen ( ()+-/&.,\' ) f�r die Volltextsuche gefunden',
-118 => 'Die Volltextsuche sucht jeweils nur ein einzelnes Wort; benutzen SIe lut_suche_multiple() zur Suche nach mehreren Worten',
-117 => 'die angegebene Suchresource ist ung�ltig',
-116 => 'Suche: im Verkn�pfungsstring sind nur die Zeichen a-z sowie + und - erlaubt',
-115 => 'Suche: es m�ssen zwischen 1 und 26 Suchmuster angegeben werden',
-114 => 'Das Feld Volltext wurde nicht initialisiert',
-113 => 'das Institut erlaubt keine eigene IBAN-Berechnung',
-112 => 'die notwendige Kompressions-Bibliothek wurden beim Kompilieren nicht eingebunden',
-111 => 'der angegebene Wert f�r die Default-Kompression ist ung�ltig',
-110 => 'wahrscheinlich OK; es wurde allerdings ein (weggelassenes) Unterkonto angef�gt',
-109 => 'Ung�ltige Signatur im Default-Block',
-108 => 'Die maximale Anzahl Eintr�ge f�r den Default-Block wurde erreicht',
-107 => 'Es wurde noch kein Default-Block angelegt',
-106 => 'Der angegebene Schl�ssel wurde im Default-Block nicht gefunden',
-105 => 'Beide Datens�tze sind nicht mehr g�ltig; dieser ist  aber j�nger als der andere',
-104 => 'Die Auftraggeber-Kontonummer des C-Datensatzes unterscheidet sich von der des A-Satzes',
-103 => 'Die Auftraggeber-Bankleitzahl des C-Datensatzes unterscheidet sich von der des A-Satzes',
-102 => 'Die DTA-Datei enth�lt (unzul�ssige) Zeilenvorsch�be',
-101 => 'ung�ltiger Typ bei einem Erweiterungsblock eines C-Datensatzes',
-100 => 'Es wurde ein C-Datensatz erwartet, jedoch ein E-Satz gefunden',
 -99 => 'Es wurde ein C-Datensatz erwartet, jedoch ein E-Satz gefunden',
 -98 => 'Es wurde ein C-Datensatzerweiterung erwartet, jedoch ein C-Satz gefunden',
 -97 => 'Es wurde ein C-Datensatzerweiterung erwartet, jedoch ein E-Satz gefunden',
 -96 => 'Die Anzahl Erweiterungen pa�t nicht zur Blockl�nge',
 -95 => 'Ung�ltige Zeichen in numerischem Feld',
 -94 => 'Ung�ltige Zeichen im Textfeld',
 -93 => 'Die W�hrung des DTA-Datensatzes ist nicht Euro',
 -92 => 'In einem DTA-Datensatz wurde kein Betrag angegeben',
 -91 => 'Ung�ltiger Textschl�ssel in der DTA-Datei',
 -90 => 'F�r ein (alphanumerisches) Feld wurde kein Wert angegeben',
 -89 => 'Die Startmarkierung des A-Datensatzes wurde nicht gefunden',
 -88 => 'Die Startmarkierung des C-Datensatzes wurde nicht gefunden',
 -87 => 'Die Startmarkierung des E-Datensatzes wurde nicht gefunden',
 -86 => 'Die Satzl�nge eines C-Datensatzes mu� zwischen 187 und 622 Byte betragen',
 -85 => 'Die Satzl�nge eines A- bzw. E-Satzes mu� 128 Byte betragen',
 -84 => 'als W�hrung in der DTA-Datei ist nicht Euro eingetragen',
 -83 => 'das Ausf�hrungsdatum ist zu fr�h oder zu sp�t (max. 15 Tage nach Dateierstellung)',
 -82 => 'das Datum ist ung�ltig',
 -81 => 'Formatfehler in der DTA-Datei',
 -80 => 'die DTA-Datei enth�lt Fehler',
 -79 => 'ung�ltiger Suchbereich angegeben (unten>oben)',
 -78 => 'Die Suche lieferte kein Ergebnis',
 -77 => 'BAV denkt, das Konto ist falsch (konto_check h�lt es f�r richtig)',
 -76 => 'User-Blocks m�ssen einen Typ > 500 haben',
 -75 => 'f�r ein LUT-Set sind nur die Werte 0, 1 oder 2 m�glich',
 -74 => 'Ein Konto kann kann nur f�r deutsche Banken gepr�ft werden',
 -73 => 'Der zu validierende strukturierete Verwendungszweck mu� genau 20 Zeichen enthalten',
 -72 => 'Im strukturierten Verwendungszweck d�rfen nur alphanumerische Zeichen vorkommen',
 -71 => 'Die L�nge des IPI-Verwendungszwecks darf maximal 18 Byte sein',
 -70 => 'Es wurde eine LUT-Datei im Format 1.0/1.1 geladen',
 -69 => 'Bei der Kontopr�fung fehlt ein notwendiger Parameter (BLZ oder Konto)',
 -68 => 'Die Funktion iban2bic() arbeitet nur mit deutschen Bankleitzahlen',
 -67 => 'Die Pr�fziffer der IBAN stimmt, die der Kontonummer nicht',
 -66 => 'Die Pr�fziffer der Kontonummer stimmt, die der IBAN nicht',
 -65 => 'Es sind nur maximal 500 Slots pro LUT-Datei m�glich (Neukompilieren erforderlich)',
 -64 => 'Initialisierung fehlgeschlagen (init_wait geblockt)',
 -63 => 'Ein inkrementelles Initialisieren ben�tigt einen Info-Block in der LUT-Datei',
 -62 => 'Ein inkrementelles Initialisieren mit einer anderen LUT-Datei ist nicht m�glich',
 -61 => 'Die Funktion ist nur in der Debug-Version vorhanden',
 -60 => 'Kein Datensatz der LUT-Datei ist aktuell g�ltig',
 -59 => 'Der Datensatz ist noch nicht g�ltig',
 -58 => 'Der Datensatz ist nicht mehr g�ltig',
 -57 => 'Im G�ltigkeitsdatum sind Anfangs- und Enddatum vertauscht',
 -56 => 'Das angegebene G�ltigkeitsdatum ist ung�ltig (Soll: JJJJMMTT-JJJJMMTT)',
 -55 => 'Der Index f�r die Filiale ist ung�ltig',
 -54 => 'Die Bibliothek wird gerade neu initialisiert',
 -53 => 'Das Feld BLZ wurde nicht initialisiert',
 -52 => 'Das Feld Filialen wurde nicht initialisiert',
 -51 => 'Das Feld Bankname wurde nicht initialisiert',
 -50 => 'Das Feld PLZ wurde nicht initialisiert',
 -49 => 'Das Feld Ort wurde nicht initialisiert',
 -48 => 'Das Feld Kurzname wurde nicht initialisiert',
 -47 => 'Das Feld PAN wurde nicht initialisiert',
 -46 => 'Das Feld BIC wurde nicht initialisiert',
 -45 => 'Das Feld Pr�fziffer wurde nicht initialisiert',
 -44 => 'Das Feld NR wurde nicht initialisiert',
 -43 => 'Das Feld �nderung wurde nicht initialisiert',
 -42 => 'Das Feld L�schung wurde nicht initialisiert',
 -41 => 'Das Feld Nachfolge-BLZ wurde nicht initialisiert',
 -40 => 'die Programmbibliothek wurde noch nicht initialisiert',
 -39 => 'der Block mit der Filialenanzahl fehlt in der LUT-Datei',
 -38 => 'es wurden nicht alle Blocks geladen',
 -37 => 'Buffer error in den ZLIB Routinen',
 -36 => 'Memory error in den ZLIB-Routinen',
 -35 => 'Datenfehler im komprimierten LUT-Block',
 -34 => 'Der Block ist nicht in der LUT-Datei enthalten',
 -33 => 'Fehler beim Dekomprimieren eines LUT-Blocks',
 -32 => 'Fehler beim Komprimieren eines LUT-Blocks',
 -31 => 'Die LUT-Datei ist korrumpiert',
 -30 => 'Im Inhaltsverzeichnis der LUT-Datei ist kein Slot mehr frei',
 -29 => 'Die (Unter)Methode ist nicht definiert',
 -28 => 'Der ben�tigte Programmteil wurde beim Kompilieren deaktiviert',
 -27 => 'Die Versionsnummer f�r die LUT-Datei ist ung�ltig',
 -26 => 'ung�ltiger Pr�fparameter (erste zu pr�fende Stelle)',
 -25 => 'ung�ltiger Pr�fparameter (Anzahl zu pr�fender Stellen)',
 -24 => 'ung�ltiger Pr�fparameter (Position der Pr�fziffer)',
 -23 => 'ung�ltiger Pr�fparameter (Wichtung)',
 -22 => 'ung�ltiger Pr�fparameter (Rechenmethode)',
 -21 => 'Problem beim Initialisieren der globalen Variablen',
 -20 => 'Pr�fsummenfehler in der blz.lut Datei',
 -19 => 'falsch (die BLZ wurde au�erdem gel�scht)',
 -18 => 'ok, ohne Pr�fung (die BLZ wurde allerdings gel�scht)',
 -17 => 'ok (die BLZ wurde allerdings gel�scht)',
 -16 => 'die Bankleitzahl wurde gel�scht',
 -15 => 'Fehler in der blz.txt Datei (falsche Zeilenl�nge)',
 -14 => 'undefinierte Funktion; die library wurde mit THREAD_SAFE=0 kompiliert',
 -13 => 'schwerer Fehler im Konto_check-Modul',
 -12 => 'ein Konto mu� zwischen 1 und 10 Stellen haben',
 -11 => 'kann Datei nicht schreiben',
 -10 => 'kann Datei nicht lesen',
  -9 => 'kann keinen Speicher allokieren',
  -8 => 'die blz.txt Datei wurde nicht gefunden',
  -7 => 'die blz.lut Datei ist inkosistent/ung�ltig',
  -6 => 'die blz.lut Datei wurde nicht gefunden',
  -5 => 'die Bankleitzahl ist nicht achtstellig',
  -4 => 'die Bankleitzahl ist ung�ltig',
  -3 => 'das Konto ist ung�ltig',
  -2 => 'die Methode wurde noch nicht implementiert',
  -1 => 'die Methode ist nicht definiert',
   0 => 'falsch',
   1 => 'ok',
   2 => 'ok, ohne Pr�fung',
   3 => 'ok; f�r den Test wurde eine Test-BLZ verwendet',
   4 => 'Der Datensatz ist aktuell g�ltig',
   5 => 'Der Datensatz enth�lt kein G�ltigkeitsdatum',
   6 => 'Die Datei ist im alten LUT-Format (1.0/1.1)',
   7 => 'ok; es wurde allerdings eine LUT-Datei im alten Format (1.0/1.1) generiert',
   8 => 'In der DTAUS-Datei wurden kleinere Fehler gefunden',
   9 => 'ok; es wurde allerdings eine LUT-Datei im Format 2.0 generiert (Compilerswitch)',
  10 => 'ok; der Wert f�r den Schl�ssel wurde �berschrieben',
  11 => 'wahrscheinlich ok; die Kontonummer kann allerdings (nicht angegebene) Unterkonten enthalten',
  12 => 'wahrscheinlich ok; die Kontonummer enth�lt eine Unterkontonummer',
  13 => 'ok; die Anzahl Slots wurde auf SLOT_CNT_MIN (40) hochgesetzt',
  14 => 'ok; ein(ige) Schl�ssel wurden nicht gefunden',
  15 => 'Die Bankverbindung wurde nicht getestet',

'INVALID_IBAN_LENGTH'                    => 'Die L�nge der IBAN f�r das angegebene L�nderk�rzel ist falsch',
'LUT2_NO_ACCOUNT_GIVEN'                  => 'Keine Bankverbindung/IBAN angegeben',
'LUT2_VOLLTEXT_INVALID_CHAR'             => 'Ung�ltiges Zeichen ( ()+-/&.,\' ) f�r die Volltextsuche gefunden',
'LUT2_VOLLTEXT_SINGLE_WORD_ONLY'         => 'Die Volltextsuche sucht jeweils nur ein einzelnes Wort; benutzen SIe lut_suche_multiple() zur Suche nach mehreren Worten',
'LUT_SUCHE_INVALID_RSC'                  => 'die angegebene Suchresource ist ung�ltig',
'LUT_SUCHE_INVALID_CMD'                  => 'Suche: im Verkn�pfungsstring sind nur die Zeichen a-z sowie + und - erlaubt',
'LUT_SUCHE_INVALID_CNT'                  => 'Suche: es m�ssen zwischen 1 und 26 Suchmuster angegeben werden',
'LUT2_VOLLTEXT_NOT_INITIALIZED'          => 'Das Feld Volltext wurde nicht initialisiert',
'NO_OWN_IBAN_CALCULATION'                => 'das Institut erlaubt keine eigene IBAN-Berechnung',
'KTO_CHECK_UNSUPPORTED_COMPRESSION'      => 'die notwendige Kompressions-Bibliothek wurden beim Kompilieren nicht eingebunden',
'KTO_CHECK_INVALID_COMPRESSION_LIB'      => 'der angegebene Wert f�r die Default-Kompression ist ung�ltig',
'OK_UNTERKONTO_ATTACHED'                 => 'wahrscheinlich OK; es wurde allerdings ein (weggelassenes) Unterkonto angef�gt',
'KTO_CHECK_DEFAULT_BLOCK_INVALID'        => 'Ung�ltige Signatur im Default-Block',
'KTO_CHECK_DEFAULT_BLOCK_FULL'           => 'Die maximale Anzahl Eintr�ge f�r den Default-Block wurde erreicht',
'KTO_CHECK_NO_DEFAULT_BLOCK'             => 'Es wurde noch kein Default-Block angelegt',
'KTO_CHECK_KEY_NOT_FOUND'                => 'Der angegebene Schl�ssel wurde im Default-Block nicht gefunden',
'LUT2_NO_LONGER_VALID_BETTER'            => 'Beide Datens�tze sind nicht mehr g�ltig; dieser ist  aber j�nger als der andere',
'DTA_SRC_KTO_DIFFERENT'                  => 'Die Auftraggeber-Kontonummer des C-Datensatzes unterscheidet sich von der des A-Satzes',
'DTA_SRC_BLZ_DIFFERENT'                  => 'Die Auftraggeber-Bankleitzahl des C-Datensatzes unterscheidet sich von der des A-Satzes',
'DTA_CR_LF_IN_FILE'                      => 'Die DTA-Datei enth�lt (unzul�ssige) Zeilenvorsch�be',
'DTA_INVALID_C_EXTENSION'                => 'ung�ltiger Typ bei einem Erweiterungsblock eines C-Datensatzes',
'DTA_FOUND_SET_A_NOT_C'                  => 'Es wurde ein C-Datensatz erwartet, jedoch ein E-Satz gefunden',
'DTA_FOUND_SET_E_NOT_C'                  => 'Es wurde ein C-Datensatz erwartet, jedoch ein E-Satz gefunden',
'DTA_FOUND_SET_C_NOT_EXTENSION'          => 'Es wurde ein C-Datensatzerweiterung erwartet, jedoch ein C-Satz gefunden',
'DTA_FOUND_SET_E_NOT_EXTENSION'          => 'Es wurde ein C-Datensatzerweiterung erwartet, jedoch ein E-Satz gefunden',
'DTA_INVALID_EXTENSION_COUNT'            => 'Die Anzahl Erweiterungen pa�t nicht zur Blockl�nge',
'DTA_INVALID_NUM'                        => 'Ung�ltige Zeichen in numerischem Feld',
'DTA_INVALID_CHARS'                      => 'Ung�ltige Zeichen im Textfeld',
'DTA_CURRENCY_NOT_EURO'                  => 'Die W�hrung des DTA-Datensatzes ist nicht Euro',
'DTA_EMPTY_AMOUNT'                       => 'In einem DTA-Datensatz wurde kein Betrag angegeben',
'DTA_INVALID_TEXT_KEY'                   => 'Ung�ltiger Textschl�ssel in der DTA-Datei',
'DTA_EMPTY_STRING'                       => 'F�r ein (alphanumerisches) Feld wurde kein Wert angegeben',
'DTA_MARKER_A_NOT_FOUND'                 => 'Die Startmarkierung des A-Datensatzes wurde nicht gefunden',
'DTA_MARKER_C_NOT_FOUND'                 => 'Die Startmarkierung des C-Datensatzes wurde nicht gefunden',
'DTA_MARKER_E_NOT_FOUND'                 => 'Die Startmarkierung des E-Datensatzes wurde nicht gefunden',
'DTA_INVALID_SET_C_LEN'                  => 'Die Satzl�nge eines C-Datensatzes mu� zwischen 187 und 622 Byte betragen',
'DTA_INVALID_SET_LEN'                    => 'Die Satzl�nge eines A- bzw. E-Satzes mu� 128 Byte betragen',
'DTA_WAERUNG_NOT_EURO'                   => 'als W�hrung in der DTA-Datei ist nicht Euro eingetragen',
'DTA_INVALID_ISSUE_DATE'                 => 'das Ausf�hrungsdatum ist zu fr�h oder zu sp�t (max. 15 Tage nach Dateierstellung)',
'DTA_INVALID_DATE'                       => 'das Datum ist ung�ltig',
'DTA_FORMAT_ERROR'                       => 'Formatfehler in der DTA-Datei',
'DTA_FILE_WITH_ERRORS'                   => 'die DTA-Datei enth�lt Fehler',
'INVALID_SEARCH_RANGE'                   => 'ung�ltiger Suchbereich angegeben (unten>oben)',
'KEY_NOT_FOUND'                          => 'Die Suche lieferte kein Ergebnis',
'BAV_FALSE'                              => 'BAV denkt, das Konto ist falsch (konto_check h�lt es f�r richtig)',
'LUT2_NO_USER_BLOCK'                     => 'User-Blocks m�ssen einen Typ > 500 haben',
'INVALID_SET'                            => 'f�r ein LUT-Set sind nur die Werte 0, 1 oder 2 m�glich',
'NO_GERMAN_BIC'                          => 'Ein Konto kann kann nur f�r deutsche Banken gepr�ft werden',
'IPI_CHECK_INVALID_LENGTH'               => 'Der zu validierende strukturierete Verwendungszweck mu� genau 20 Zeichen enthalten',
'IPI_INVALID_CHARACTER'                  => 'Im strukturierten Verwendungszweck d�rfen nur alphanumerische Zeichen vorkommen',
'IPI_INVALID_LENGTH'                     => 'Die L�nge des IPI-Verwendungszwecks darf maximal 18 Byte sein',
'LUT1_FILE_USED'                         => 'Es wurde eine LUT-Datei im Format 1.0/1.1 geladen',
'MISSING_PARAMETER'                      => 'Bei der Kontopr�fung fehlt ein notwendiger Parameter (BLZ oder Konto)',
'IBAN2BIC_ONLY_GERMAN'                   => 'Die Funktion iban2bic() arbeitet nur mit deutschen Bankleitzahlen',
'IBAN_OK_KTO_NOT'                        => 'Die Pr�fziffer der IBAN stimmt, die der Kontonummer nicht',
'KTO_OK_IBAN_NOT'                        => 'Die Pr�fziffer der Kontonummer stimmt, die der IBAN nicht',
'TOO_MANY_SLOTS'                         => 'Es sind nur maximal 500 Slots pro LUT-Datei m�glich (Neukompilieren erforderlich)',
'INIT_FATAL_ERROR'                       => 'Initialisierung fehlgeschlagen (init_wait geblockt)',
'INCREMENTAL_INIT_NEEDS_INFO'            => 'Ein inkrementelles Initialisieren ben�tigt einen Info-Block in der LUT-Datei',
'INCREMENTAL_INIT_FROM_DIFFERENT_FILE'   => 'Ein inkrementelles Initialisieren mit einer anderen LUT-Datei ist nicht m�glich',
'DEBUG_ONLY_FUNCTION'                    => 'Die Funktion ist nur in der Debug-Version vorhanden',
'LUT2_INVALID'                           => 'Kein Datensatz der LUT-Datei ist aktuell g�ltig',
'LUT2_NOT_YET_VALID'                     => 'Der Datensatz ist noch nicht g�ltig',
'LUT2_NO_LONGER_VALID'                   => 'Der Datensatz ist nicht mehr g�ltig',
'LUT2_GUELTIGKEIT_SWAPPED'               => 'Im G�ltigkeitsdatum sind Anfangs- und Enddatum vertauscht',
'LUT2_INVALID_GUELTIGKEIT'               => 'Das angegebene G�ltigkeitsdatum ist ung�ltig (Soll: JJJJMMTT-JJJJMMTT)',
'LUT2_INDEX_OUT_OF_RANGE'                => 'Der Index f�r die Filiale ist ung�ltig',
'LUT2_INIT_IN_PROGRESS'                  => 'Die Bibliothek wird gerade neu initialisiert',
'LUT2_BLZ_NOT_INITIALIZED'               => 'Das Feld BLZ wurde nicht initialisiert',
'LUT2_FILIALEN_NOT_INITIALIZED'          => 'Das Feld Filialen wurde nicht initialisiert',
'LUT2_NAME_NOT_INITIALIZED'              => 'Das Feld Bankname wurde nicht initialisiert',
'LUT2_PLZ_NOT_INITIALIZED'               => 'Das Feld PLZ wurde nicht initialisiert',
'LUT2_ORT_NOT_INITIALIZED'               => 'Das Feld Ort wurde nicht initialisiert',
'LUT2_NAME_KURZ_NOT_INITIALIZED'         => 'Das Feld Kurzname wurde nicht initialisiert',
'LUT2_PAN_NOT_INITIALIZED'               => 'Das Feld PAN wurde nicht initialisiert',
'LUT2_BIC_NOT_INITIALIZED'               => 'Das Feld BIC wurde nicht initialisiert',
'LUT2_PZ_NOT_INITIALIZED'                => 'Das Feld Pr�fziffer wurde nicht initialisiert',
'LUT2_NR_NOT_INITIALIZED'                => 'Das Feld NR wurde nicht initialisiert',
'LUT2_AENDERUNG_NOT_INITIALIZED'         => 'Das Feld �nderung wurde nicht initialisiert',
'LUT2_LOESCHUNG_NOT_INITIALIZED'         => 'Das Feld L�schung wurde nicht initialisiert',
'LUT2_NACHFOLGE_BLZ_NOT_INITIALIZED'     => 'Das Feld Nachfolge-BLZ wurde nicht initialisiert',
'LUT2_NOT_INITIALIZED'                   => 'die Programmbibliothek wurde noch nicht initialisiert',
'LUT2_FILIALEN_MISSING'                  => 'der Block mit der Filialenanzahl fehlt in der LUT-Datei',
'LUT2_PARTIAL_OK'                        => 'es wurden nicht alle Blocks geladen',
'LUT2_Z_BUF_ERROR'                       => 'Buffer error in den ZLIB Routinen',
'LUT2_Z_MEM_ERROR'                       => 'Memory error in den ZLIB-Routinen',
'LUT2_Z_DATA_ERROR'                      => 'Datenfehler im komprimierten LUT-Block',
'LUT2_BLOCK_NOT_IN_FILE'                 => 'Der Block ist nicht in der LUT-Datei enthalten',
'LUT2_DECOMPRESS_ERROR'                  => 'Fehler beim Dekomprimieren eines LUT-Blocks',
'LUT2_COMPRESS_ERROR'                    => 'Fehler beim Komprimieren eines LUT-Blocks',
'LUT2_FILE_CORRUPTED'                    => 'Die LUT-Datei ist korrumpiert',
'LUT2_NO_SLOT_FREE'                      => 'Im Inhaltsverzeichnis der LUT-Datei ist kein Slot mehr frei',
'UNDEFINED_SUBMETHOD'                    => 'Die (Unter)Methode ist nicht definiert',
'EXCLUDED_AT_COMPILETIME'                => 'Der ben�tigte Programmteil wurde beim Kompilieren deaktiviert',
'INVALID_LUT_VERSION'                    => 'Die Versionsnummer f�r die LUT-Datei ist ung�ltig',
'INVALID_PARAMETER_STELLE1'              => 'ung�ltiger Pr�fparameter (erste zu pr�fende Stelle)',
'INVALID_PARAMETER_COUNT'                => 'ung�ltiger Pr�fparameter (Anzahl zu pr�fender Stellen)',
'INVALID_PARAMETER_PRUEFZIFFER'          => 'ung�ltiger Pr�fparameter (Position der Pr�fziffer)',
'INVALID_PARAMETER_WICHTUNG'             => 'ung�ltiger Pr�fparameter (Wichtung)',
'INVALID_PARAMETER_METHODE'              => 'ung�ltiger Pr�fparameter (Rechenmethode)',
'LIBRARY_INIT_ERROR'                     => 'Problem beim Initialisieren der globalen Variablen',
'LUT_CRC_ERROR'                          => 'Pr�fsummenfehler in der blz.lut Datei',
'FALSE_GELOESCHT'                        => 'falsch (die BLZ wurde au�erdem gel�scht)',
'OK_NO_CHK_GELOESCHT'                    => 'ok, ohne Pr�fung (die BLZ wurde allerdings gel�scht)',
'OK_GELOESCHT'                           => 'ok (die BLZ wurde allerdings gel�scht)',
'BLZ_GELOESCHT'                          => 'die Bankleitzahl wurde gel�scht',
'INVALID_BLZ_FILE'                       => 'Fehler in der blz.txt Datei (falsche Zeilenl�nge)',
'LIBRARY_IS_NOT_THREAD_SAFE'             => 'undefinierte Funktion; die library wurde mit THREAD_SAFE=0 kompiliert',
'FATAL_ERROR'                            => 'schwerer Fehler im Konto_check-Modul',
'INVALID_KTO_LENGTH'                     => 'ein Konto mu� zwischen 1 und 10 Stellen haben',
'FILE_WRITE_ERROR'                       => 'kann Datei nicht schreiben',
'FILE_READ_ERROR'                        => 'kann Datei nicht lesen',
'ERROR_MALLOC'                           => 'kann keinen Speicher allokieren',
'NO_BLZ_FILE'                            => 'die blz.txt Datei wurde nicht gefunden',
'INVALID_LUT_FILE'                       => 'die blz.lut Datei ist inkosistent/ung�ltig',
'NO_LUT_FILE'                            => 'die blz.lut Datei wurde nicht gefunden',
'INVALID_BLZ_LENGTH'                     => 'die Bankleitzahl ist nicht achtstellig',
'INVALID_BLZ'                            => 'die Bankleitzahl ist ung�ltig',
'INVALID_KTO'                            => 'das Konto ist ung�ltig',
'NOT_IMPLEMENTED'                        => 'die Methode wurde noch nicht implementiert',
'NOT_DEFINED'                            => 'die Methode ist nicht definiert',
'FALSE'                                  => 'falsch',
'OK'                                     => 'ok',
'OK_NO_CHK'                              => 'ok, ohne Pr�fung',
'OK_TEST_BLZ_USED'                       => 'ok; f�r den Test wurde eine Test-BLZ verwendet',
'LUT2_VALID'                             => 'Der Datensatz ist aktuell g�ltig',
'LUT2_NO_VALID_DATE'                     => 'Der Datensatz enth�lt kein G�ltigkeitsdatum',
'LUT1_SET_LOADED'                        => 'Die Datei ist im alten LUT-Format (1.0/1.1)',
'LUT1_FILE_GENERATED'                    => 'ok; es wurde allerdings eine LUT-Datei im alten Format (1.0/1.1) generiert',
'DTA_FILE_WITH_WARNINGS'                 => 'In der DTAUS-Datei wurden kleinere Fehler gefunden',
'LUT_V2_FILE_GENERATED'                  => 'ok; es wurde allerdings eine LUT-Datei im Format 2.0 generiert (Compilerswitch)',
'KTO_CHECK_VALUE_REPLACED'               => 'ok; der Wert f�r den Schl�ssel wurde �berschrieben',
'OK_UNTERKONTO_POSSIBLE'                 => 'wahrscheinlich ok; die Kontonummer kann allerdings (nicht angegebene) Unterkonten enthalten',
'OK_UNTERKONTO_GIVEN'                    => 'wahrscheinlich ok; die Kontonummer enth�lt eine Unterkontonummer',
'OK_SLOT_CNT_MIN_USED'                   => 'ok; die Anzahl Slots wurde auf SLOT_CNT_MIN (40) hochgesetzt',
'SOME_KEYS_NOT_FOUND'                    => 'ok; ein(ige) Schl�ssel wurden nicht gefunden',
'LUT2_KTO_NOT_CHECKED'                   => 'Die Bankverbindung wurde nicht getestet',
);

%Business::KontoCheck::kto_retval_kurz = (
-121 => 'INVALID_IBAN_LENGTH',
-120 => 'LUT2_NO_ACCOUNT_GIVEN',
-119 => 'LUT2_VOLLTEXT_INVALID_CHAR',
-118 => 'LUT2_VOLLTEXT_SINGLE_WORD_ONLY',
-117 => 'LUT_SUCHE_INVALID_RSC',
-116 => 'LUT_SUCHE_INVALID_CMD',
-115 => 'LUT_SUCHE_INVALID_CNT',
-114 => 'LUT2_VOLLTEXT_NOT_INITIALIZED',
-113 => 'NO_OWN_IBAN_CALCULATION',
-112 => 'KTO_CHECK_UNSUPPORTED_COMPRESSION',
-111 => 'KTO_CHECK_INVALID_COMPRESSION_LIB',
-110 => 'OK_UNTERKONTO_ATTACHED',
-109 => 'KTO_CHECK_DEFAULT_BLOCK_INVALID',
-108 => 'KTO_CHECK_DEFAULT_BLOCK_FULL',
-107 => 'KTO_CHECK_NO_DEFAULT_BLOCK',
-106 => 'KTO_CHECK_KEY_NOT_FOUND',
-105 => 'LUT2_NO_LONGER_VALID_BETTER',
-104 => 'DTA_SRC_KTO_DIFFERENT',
-103 => 'DTA_SRC_BLZ_DIFFERENT',
-102 => 'DTA_CR_LF_IN_FILE',
-101 => 'DTA_INVALID_C_EXTENSION',
-100 => 'DTA_FOUND_SET_A_NOT_C',
 -99 => 'DTA_FOUND_SET_E_NOT_C',
 -98 => 'DTA_FOUND_SET_C_NOT_EXTENSION',
 -97 => 'DTA_FOUND_SET_E_NOT_EXTENSION',
 -96 => 'DTA_INVALID_EXTENSION_COUNT',
 -95 => 'DTA_INVALID_NUM',
 -94 => 'DTA_INVALID_CHARS',
 -93 => 'DTA_CURRENCY_NOT_EURO',
 -92 => 'DTA_EMPTY_AMOUNT',
 -91 => 'DTA_INVALID_TEXT_KEY',
 -90 => 'DTA_EMPTY_STRING',
 -89 => 'DTA_MARKER_A_NOT_FOUND',
 -88 => 'DTA_MARKER_C_NOT_FOUND',
 -87 => 'DTA_MARKER_E_NOT_FOUND',
 -86 => 'DTA_INVALID_SET_C_LEN',
 -85 => 'DTA_INVALID_SET_LEN',
 -84 => 'DTA_WAERUNG_NOT_EURO',
 -83 => 'DTA_INVALID_ISSUE_DATE',
 -82 => 'DTA_INVALID_DATE',
 -81 => 'DTA_FORMAT_ERROR',
 -80 => 'DTA_FILE_WITH_ERRORS',
 -79 => 'INVALID_SEARCH_RANGE',
 -78 => 'KEY_NOT_FOUND',
 -77 => 'BAV_FALSE',
 -76 => 'LUT2_NO_USER_BLOCK',
 -75 => 'INVALID_SET',
 -74 => 'NO_GERMAN_BIC',
 -73 => 'IPI_CHECK_INVALID_LENGTH',
 -72 => 'IPI_INVALID_CHARACTER',
 -71 => 'IPI_INVALID_LENGTH',
 -70 => 'LUT1_FILE_USED',
 -69 => 'MISSING_PARAMETER',
 -68 => 'IBAN2BIC_ONLY_GERMAN',
 -67 => 'IBAN_OK_KTO_NOT',
 -66 => 'KTO_OK_IBAN_NOT',
 -65 => 'TOO_MANY_SLOTS',
 -64 => 'INIT_FATAL_ERROR',
 -63 => 'INCREMENTAL_INIT_NEEDS_INFO',
 -62 => 'INCREMENTAL_INIT_FROM_DIFFERENT_FILE',
 -61 => 'DEBUG_ONLY_FUNCTION',
 -60 => 'LUT2_INVALID',
 -59 => 'LUT2_NOT_YET_VALID',
 -58 => 'LUT2_NO_LONGER_VALID',
 -57 => 'LUT2_GUELTIGKEIT_SWAPPED',
 -56 => 'LUT2_INVALID_GUELTIGKEIT',
 -55 => 'LUT2_INDEX_OUT_OF_RANGE',
 -54 => 'LUT2_INIT_IN_PROGRESS',
 -53 => 'LUT2_BLZ_NOT_INITIALIZED',
 -52 => 'LUT2_FILIALEN_NOT_INITIALIZED',
 -51 => 'LUT2_NAME_NOT_INITIALIZED',
 -50 => 'LUT2_PLZ_NOT_INITIALIZED',
 -49 => 'LUT2_ORT_NOT_INITIALIZED',
 -48 => 'LUT2_NAME_KURZ_NOT_INITIALIZED',
 -47 => 'LUT2_PAN_NOT_INITIALIZED',
 -46 => 'LUT2_BIC_NOT_INITIALIZED',
 -45 => 'LUT2_PZ_NOT_INITIALIZED',
 -44 => 'LUT2_NR_NOT_INITIALIZED',
 -43 => 'LUT2_AENDERUNG_NOT_INITIALIZED',
 -42 => 'LUT2_LOESCHUNG_NOT_INITIALIZED',
 -41 => 'LUT2_NACHFOLGE_BLZ_NOT_INITIALIZED',
 -40 => 'LUT2_NOT_INITIALIZED',
 -39 => 'LUT2_FILIALEN_MISSING',
 -38 => 'LUT2_PARTIAL_OK',
 -37 => 'LUT2_Z_BUF_ERROR',
 -36 => 'LUT2_Z_MEM_ERROR',
 -35 => 'LUT2_Z_DATA_ERROR',
 -34 => 'LUT2_BLOCK_NOT_IN_FILE',
 -33 => 'LUT2_DECOMPRESS_ERROR',
 -32 => 'LUT2_COMPRESS_ERROR',
 -31 => 'LUT2_FILE_CORRUPTED',
 -30 => 'LUT2_NO_SLOT_FREE',
 -29 => 'UNDEFINED_SUBMETHOD',
 -28 => 'EXCLUDED_AT_COMPILETIME',
 -27 => 'INVALID_LUT_VERSION',
 -26 => 'INVALID_PARAMETER_STELLE1',
 -25 => 'INVALID_PARAMETER_COUNT',
 -24 => 'INVALID_PARAMETER_PRUEFZIFFER',
 -23 => 'INVALID_PARAMETER_WICHTUNG',
 -22 => 'INVALID_PARAMETER_METHODE',
 -21 => 'LIBRARY_INIT_ERROR',
 -20 => 'LUT_CRC_ERROR',
 -19 => 'FALSE_GELOESCHT',
 -18 => 'OK_NO_CHK_GELOESCHT',
 -17 => 'OK_GELOESCHT',
 -16 => 'BLZ_GELOESCHT',
 -15 => 'INVALID_BLZ_FILE',
 -14 => 'LIBRARY_IS_NOT_THREAD_SAFE',
 -13 => 'FATAL_ERROR',
 -12 => 'INVALID_KTO_LENGTH',
 -11 => 'FILE_WRITE_ERROR',
 -10 => 'FILE_READ_ERROR',
  -9 => 'ERROR_MALLOC',
  -8 => 'NO_BLZ_FILE',
  -7 => 'INVALID_LUT_FILE',
  -6 => 'NO_LUT_FILE',
  -5 => 'INVALID_BLZ_LENGTH',
  -4 => 'INVALID_BLZ',
  -3 => 'INVALID_KTO',
  -2 => 'NOT_IMPLEMENTED',
  -1 => 'NOT_DEFINED',
   0 => 'FALSE',
   1 => 'OK',
   2 => 'OK_NO_CHK',
   3 => 'OK_TEST_BLZ_USED',
   4 => 'LUT2_VALID',
   5 => 'LUT2_NO_VALID_DATE',
   6 => 'LUT1_SET_LOADED',
   7 => 'LUT1_FILE_GENERATED',
   8 => 'DTA_FILE_WITH_WARNINGS',
   9 => 'LUT_V2_FILE_GENERATED',
  10 => 'KTO_CHECK_VALUE_REPLACED',
  11 => 'OK_UNTERKONTO_POSSIBLE',
  12 => 'OK_UNTERKONTO_GIVEN',
  13 => 'OK_SLOT_CNT_MIN_USED',
  14 => 'SOME_KEYS_NOT_FOUND',
  15 => 'LUT2_KTO_NOT_CHECKED',
);

END{ lut_cleanup(); }

1;
__END__

=encoding ISO8859-1

=head1 NAME

Business::KontoCheck - Perl extension for checking German and Austrian Bank Account Numbers

=head1 NOTE

Because the module is for use mainly in Germany, the following documentation
language is german too.

=head1 SYNOPSIS

   use Business::KontoCheck;
   use Business::KontoCheck qw( kto_check lut_name lut_blz lut_ort %kto_retval [...] );

   $retval=lut_init([$lut_name[,$required[,$set]]]);
   $retval=kto_check_init($lut_name[,$required[,$set[,$incremental]]]);
   $retval=kto_check($blz,$kto,$lut_name);
   $retval=kto_check_str($blz,$kto,$lut_name);
   $retval=kto_check_blz($blz,$kto)
   $retval=kto_check_pz($pz,$blz,$kto)

   $retval=generate_lut($inputname,$outputname,$user_info,$lut_version);
   $retval=generate_lut2($inputname,$outputname[,$user_info[,$gueltigkeit[,$felder[,$filialen[,$slots[,$lut_version[,$set]]]]]]]);

   [$@]retval=lut_blz($blz[,$offset])
   [$@]retval=lut_info($lut_name)
   [$@]retval=lut_filialen($blz[,$offset])
   [$@]retval=lut_name($blz[,$offset])
   [$@]retval=lut_name_kurz($blz[,$offset])
   [$@]retval=lut_plz($blz[,$offset])
   [$@]retval=lut_ort($blz[,$offset])
   [$@]retval=lut_pan($blz[,$offset])
   [$@]retval=lut_bic($blz[,$offset])
   [$@]retval=lut_pz($blz[,$offset])
   [$@]retval=lut_aenderung($blz[,$offset])
   [$@]retval=lut_loeschung($blz[,$offset])
   [$@]retval=lut_nachfolge_blz($blz[,$offset])

   $retval=lut_valid()
   $ret=pz2str($pz[,$ret])

   [$@]ret=lut_suche_bic($bic[,$retval])
   [$@]ret=lut_suche_namen($namen[,$retval])
   [$@]ret=lut_suche_namen_kurz($namen_kurz])
   [$@]ret=lut_suche_ort($ort[,$retval])
   [$@]ret=lut_suche_blz($blz1[,$blz2[,$retval]])
   [$@]ret=lut_suche_pz($pz1[,$pz2[,$retval]])
   [$@]ret=lut_suche_plz($plz1[,$plz2[,$retval]])
   [$@]ret=lut_suche_volltext($suchworte[,$retval])
   [$@]ret=lut_suche_multiple($suchworte[,$uniq[,$such_cmd[,$retval]]])

   $retval=copy_lutfile($old_name,$new_name,$new_slots)
   $retval=dump_lutfile($outputname,$felder)
   $retval=lut_cleanup()

   $retval=iban_check(iban)
   $retval=iban2bic(iban)
   $retval=iban_gen(blz,kto)

   $enc=kto_check_encoding($encoding)
   $enc_str=kto_check_encoding_str($encoding)
   $keep=keep_raw_data($flag)
   $retval=retval2txt($retval)
   $retval=retval2txt_short($retval)
   $retval=retval2iso($retval)
   $retval=retval2html($retval)
   $retval=retval2utf8($retval)
   $retval=retval2dos($retval)
   $retval=kto_check_retval2txt($retval)
   $retval=kto_check_retval2txt_short($retval)
   $retval=kto_check_retval2html($retval)
   $retval=kto_check_retval2utf8($retval)
   $retval=kto_check_retval2dos($retval)
   $retval_txt=$kto_retval{$retval};

   $retval=kto_check_at($blz,$kto,$lut_name);
   $retval=kto_check_at_str($blz,$kto,$lut_name);
   $retval=generate_lut_at($inputname,$outputname,$plain_name,$plain_format);

=head1 DESCRIPTION

Dies ist Business::KontoCheck, ein Programm zum Testen der Pr�fziffern
von deutschen und �sterreichischen Bankkonten. Dies ist die Perl-
Version der C-Library (als XSUB Modul).

=head1 EXPORT

Es werden defaultm��ig die Funkionen kto_check und kto_check_str,
(aus dem deutschen Modul), kto_check_at, kto_check_at_str (aus
dem �sterreichischen Modul) sowie die Variable %kto_retval (f�r
beide Module) exportiert.

Optional k�nnen auch eine Reihe weiterer Funktionen exportiert werden;
diese m�ssen dann in der use Klausel anzugeben werden.

=head1 DESCRIPTION

  Funktion:  kto_check()
             kto_check_str()

  Aufgabe:   Testen eines Kontos

  Aufruf:    $retval=kto_check($blz,$kto,$lut_name);
             $retval=kto_check_str($blz,$kto,$lut_name);

  Parameter:
     $blz:      falls 2- oder 3-stellig: Pr�fziffermethode
                (evl. mit Untermethode a, b, c... oder 1, 2, 3)
                falls 8-stellig: Bankleitzahl

     $kto:      Kontonummer (wird vor der Berechnung
                linksb�ndig mit Nullen auf 10 Stellen
                aufgef�llt)

     $lut_name: Dateiname der Lookup-Tabelle mit Bankleitzahlen.
                Falls NULL oder ein leerer String �bergeben wird,
                wird der Dateiname blz.lut benutzt.
                Diese Datei enth�lt die Pr�fziffermethoden f�r die
                einzelnen Bankleitzahlen; sie kann mit der Funktion
                generate_lut() aus der Bundesbanktabelle generiert
                werden.

  R�ckgabewerte:
     Die Funktion kto_check gibt einen numerischen Wert zur�ck,
     w�hrend die Funktion kto_check_str einen kurzen String
     zur�ckgibt.

     Mittels des assoziativen Arrays %kto_retval lassen sich die
     numerischen R�ckgabewerte in einen etwas ausf�hrlicheren
     R�ckgabetext umwandeln:

     $retval_txt=$kto_retval{$retval};

-------------------------------------------------------------------------

  Funktion:  generate_lut()      (LUT-Version 1.0 oder 1.1; obsolet)
             generate_lut2()     (LUT-Version 1.0, 1.1 oder 2.0)

  Aufgabe:   LUT-Datei generieren

  Aufruf: $retval=generate_lut($inputname,$outputname,$user_info,$lut_version);

          $retval=generate_lut2($inputname,$outputname[,$user_info[,$gueltigkeit
               [,$felder[,$filialen[,$slots[,$lut_version[,$set]]]]]]]);

  Parameter:
     inputname:   Name der Bankleitzahlendatei der Deutschen
                  Bundesbank (z.B. blz0303pc.txt)

     outputname:  Name der Zieldatei (z.B. blz.lut)

     user_info:   Info-Zeile, die zus�tzlich in die LUT-Datei
                  geschrieben wird. Diese Zeile wird von der
                  Funktion get_lut_info() in zur�ckgegeben,
                  aber ansonsten nicht ausgewertet.

     lut_version: Format der LUT-Datei. M�gliche Werte:
                  1: altes Format (1.0)
                  2: altes Format (1.1) mit Infozeile
                  3: neues Format (2.0).

                  Die Werte 1 und 2 werden defaultm��ig nicht mehr
                  unterst�tzt, da sie komplett obsolet sind; falls
                  jemand eine Datei im alten Format generieren will,
                  mu� in konto_check.h das Makro GENERATE_OLD_LUTFILE
                  auf 1 gesetzt werden. Andernfalls wird immer eine
                  Datei im neuen Format generiert.

   Die folgenden Parameter gelten nur f�r generate_lut2():

     gueltigkeit: G�ltigkeitsbereich der LUT-Datei, im Format
                  JJJJMMTT-JJJJMMTT, z.B. 20120305-20120603

     felder:      (Integer, 0-9) Felder, die in die LUT-Datei
                  aufgenommen werden sollen. Folgende Felder werden
                  in die Datei aufgenommen (nicht aufgef�hrt, aber
                  immer dabei sind Infoblock, BLZ und Pr�fziffer).
                  Name+Kn. steht dabei f�r einen Block, der Name und
                  Kurzname der Bank enth�lt; dieser l��t sich besser
                  komprimieren, als wenn die beiden Blocks getrennt
                  sind. Lfd.Nr. ist die laufende Nr. in der BLZ-Datei;
                  praktisch wird sie wohl nicht ben�tigt, ist aber zur
                  Vollst�ndigkeit mit enthalten.

    0: (nur die drei Defaultblocks) (3 Slots)
    1: Name+Kn. (4 Slots)
    2: Name+Kn.,BIC (5 Slots)
    3: Name,PLZ,Ort (6 Slots)
    4: Name,PLZ,Ort,BIC (7 Slots)
    5: Name+Kn.,PLZ,Ort,BIC (7 Slots)
    6: Name+Kn.,PLZ,Ort,BIC,Nachfolge-BLZ (8 Slots)
    7: Name+Kn.,PLZ,Ort,BIC,Nachfolge-BLZ,�nderung (9 Slots)
    8: Name+Kn.,PLZ,Ort,BIC,Nachfolge-BLZ,�nderung,L�schung (10 Slots)
    9: Name+Kn.,PLZ,Ort,BIC,Nachfolge-BLZ,�nderung,L�schung,PAN,Lfd.Nr. (12 Slots)

     filialen:    Flag (0 oder 1), ob die Filialdaten ebenfalls
                  aufgenommen werden sollen.

     slots:       Anzahl Slots (m�gliche Verzeichniseintr�ge) der
                  LUT-Datei. F�r einen vollen Datensatz (felder=9)
                  werden 12 Slots ben�tigt; falls die Datei zwei
                  Datens�tze enthalten soll, braucht man mindestens
                  24 Slots.

                  In konto_check.h ist das Makro SLOT_CNT_MIN
                  definiert, das die minimale Anzahl Slots angibt.
                  Falls beim Aufruf dieser Funktion weniger Slots
                  angegeben werden, erh�lt man den R�ckgabewert
                  OK_SLOT_CNT_MIN_USED, und die Anzahl der Slots wird
                  auf den Minimalwert gesetzt. Falls nicht gen�gend
                  Slots verf�gbar sind, um die Datei zu generieren,
                  wird der (Fehler-)Wert LUT2_NO_SLOT_FREE zur�ckgegeben.

     set:         (Integer, 0, 1 oder 2) Angabe, ob das prim�re Set (0
                  bzw. 1) oder sekund�re Datensatz (2) geschrieben
                  werden soll. Falls f�r set 0 angegeben wird, wird
                  eine neue Datei angelegt, bei 1 und 2 wird der
                  Datensatz an eine vorhandene LUT-Datei angeh�ngt.
                  Das setzt nat�rlich voraus, da� noch gen�gend
                  Verzeichnisslots vorhanden sind, um alle Blocks
                  schreiben zu k�nnen. Bei Bedarf kann mittels
                  copy_lutfile() die Anzahl der Verzeichnisslots auch
                  erh�ht werden.

-------------------------------------------------------------------------

  Funktion:  lut_blz()
             lut_filialen()
             lut_name()
             lut_name_kurz()
             lut_plz()
             lut_ort()
             lut_pan()
             lut_bic()
             lut_pz()
             lut_aenderung()
             lut_loeschung()
             lut_nachfolge_blz()

  Aufgabe:   Bestimmung von Feldern der BLZ-Datei

  Aufruf:    [$@]ret=lut_blz($blz[,$filiale[,$ret]])
             [$@]ret=lut_name($blz[,$filiale[,$ret]])
             [$@]ret=lut_name_kurz($blz[,$filiale[,$ret]])
             [$@]ret=lut_plz($blz[,$filiale[,$ret]])
             [$@]ret=lut_ort($blz[,$filiale[,$ret]])
             [$@]ret=lut_pan($blz[,$filiale[,$ret]])
             [$@]ret=lut_bic($blz[,$filiale[,$ret]])
             [$@]ret=lut_pz($blz[,$filiale[,$ret]])
             [$@]ret=lut_aenderung($blz[,$filiale[,$ret]])
             [$@]ret=lut_loeschung($blz[,$filiale[,$ret]])
             [$@]ret=lut_nachfolge_blz($blz[,$filiale[,$ret]])
             $ret=pz2str($pz[,$ret])

   Die Funktionen bestimmen die diversen Felder der BLZ-Datei zu einer
   gegebenen BLZ. Falls der optionale Parameter $filiale angegeben
   wird, wird der Wert f�r eine Filiale bestimmt, ansonsten (und bei
   $filiale==0) der Wert der Hauptstelle. Die Anzahl der Filialen zu
   einer BLZ l��t sich mittels der Funktion $cnt=lut_filialen($blz)
   bestimmen.

   Die Funktion pz2str() wandelt eine numerische Pr�fziffermethode
   (wie sie z.B. von lut_pz() zur�ckgegeben wird) in einen
   zweistelligen String um.

   Alle Funktionen (au�er pz2str) lassen sich sowohl im skalaren als
   auch im Array-Kontext aufrufen. Bei Aufruf in skalarem Kontext wird
   der jeweilige Wert zur�ckgegeben; bei Aufruf im Array-Kontext wird
   au�erdem noch der R�ckgabestatus der Funktion als Zahl, String
   (lang) und String (kurz) zur�ckgegeben. Beispiel:

   $ret=lut_name("66090800") liefert f�r $ret den Wert "BBBank",
   @ret=lut_name("66090800") liefert ein Array mit den Werten
   @ret=("BBBank",1,"ok","OK")

   der Aufruf
   @ret=lut_name("660908") liefert ein Array mit den Werten
   @ret=("",-5,"die Bankleitzahl ist nicht achtstellig","INVALID_BLZ_LENGTH")

   Falls der Aufruf im Array-Kontext nicht gew�nscht ist, gibt es noch
   alternative Funktionen, die nur in skalarem Kontext arbeiten: 

   -------------------------------------------------------------------------

  Funktion:  keep_raw_data
             kto_check_encoding
             kto_check_encoding_str

  Aufgabe:   Diese Funktionen setzen die Ausgabekodierung (sowohl f�r
      die Felder der LUT-Datei als auch f�r Statusmeldungen mit der
      Funktion kto_check_retval2txt()) fest.


  Aufruf:    $flag=keep_raw_data($flag)
             $encoding=kto_check_encoding($mode)
             $encoding_str=kto_check_encoding_str($mode)

    Diese Funktion legt den benutzten Zeichensatz f�r Fehlermeldungen
    durch die Funktion retval2txt() und einige Felder der LUT-Datei
    (Name, Kurzname, Ort) fest. Wenn die Funktion nicht aufgerufen
    wird, wird der Wert DEFAULT_ENCODING aus konto_check.h benutzt.

    _Achtung_: Das Verhalten der Funktionen h�ngt von dem Flag
    keep_raw_data_flag der C-Bibliothek ab. Falls das Flag gesetzt
    ist, werden die Rohdaten der Blocks Name, Kurzname und Ort im
    Speicher gehalten; bei einem Wechsel der Kodierung wird auch f�r
    diese Blocks die Kodierung umgesetzt. Falls das Flag nicht gesetzt
    ist, sollte die Funktion *vor* der Initialisierung aufgerufen
    werden, da in dem Fall die Daten der LUT-Datei nur bei der
    Initialisierung konvertiert werden. Mit der Funktion
    keep_raw_data() kann das Flag gesetzt oder gel�scht werden.

    F�r den Parameter mode werden die folgenden Werte akzeptiert:

    1:   ISO-8859-1
    2:   UTF-8
    3:   HTML
    4:   DOS CP 850
    51:  ISO-8859-1, Makro f�r Fehlermeldungen
    52:  UTF-8, Makro f�r Fehlermeldungen
    53:  HTML, Makro f�r Fehlermeldungen
    54:  DOS CP 850, Makro f�r Fehlermeldungen

    R�ckgabewert ist die aktuelle Kodierung als Integer oder (bei
    kto_check_encoding_str()) als String. Falls zwei Kodierungen
    angegeben sind, ist die erste die der Statusmeldungen, die zweite
    die der LUT-Blocks:

     1:  "ISO-8859-1";
     2:  "UTF-8";
     3:  "HTML entities";
     4:  "DOS CP 850";
     12: "ISO-8859-1/UTF-8";
     13: "ISO-8859-1/HTML";
     14: "ISO-8859-1/DOS CP 850";
     21: "UTF-8/ISO-8859-1";
     23: "UTF-8/HTML";
     24: "UTF-8/DOS CP-850";
     31: "HTML entities/ISO-8859-1";
     32: "HTML entities/UTF-8";
     34: "HTML entities/DOS CP-850";
     41: "DOS CP-850/ISO-8859-1";
     42: "DOS CP-850/UTF-8";
     43: "DOS CP-850/HTML";
     51: "Makro/ISO-8859-1";
     52: "Makro/UTF-8";
     53: "Makro/HTML";
     54: "Makro/DOS CP 850";

    Mit der Funktion keep_raw_data() l��t sich einstellen, ob die
    Rohwerte der LUT-Datei gespeichert werden sollen (das erfordert
    etwa 900 KB zus�tzlichen Hauptspeicher, erlaubt aber das
    Umkodieren der LUT-Blocks nach der Initialisierung).

   -------------------------------------------------------------------------

  Funktion:  kto_check_retval2txt
             kto_check_retval2iso
             kto_check_retval2utf8
             kto_check_retval2html
             kto_check_retval2dos
             kto_check_retval2txt_short

  Aufgabe:   Ausgabe numerischer Statusmeldungen als Klartext.

  Aufruf:    $retval_txt=kto_check_retval2txt($retval)
             $retval_txt=kto_check_retval2iso($retval)
             $retval_txt=kto_check_retval2utf8($retval)
             $retval_txt=kto_check_retval2html($retval)
             $retval_txt=kto_check_retval2dos($retval)
             $retval_txt=kto_check_retval2txt_short($retval)

   Diese Funktionen wandeln die numerischen R�ckgabewerte in einen
   Klartext-String der gew�nschten Kodierung um. Die Kodierung der
   Funktion kto_check_retval2txt() wird dabei durch die Funktion
   kto_check_encoding() (s.o.) festgelegt; die anderen Funktionen
   geben jeweils eine feste Kodierung zur�ck.

   -------------------------------------------------------------------------

  Funktion:  lut_blz1()
             lut_filialen1()
             lut_name1()
             lut_name_kurz1()
             lut_plz1()
             lut_ort1()
             lut_pan1()
             lut_bic1()
             lut_pz1()
             lut_aenderung1()
             lut_loeschung1()
             lut_nachfolge_blz1()

  Aufgabe:   Bestimmung von Feldern der BLZ-Datei (skalarer Kontext)

  Aufruf:    $ret=lut_blz1($blz[,$filiale[,$ret]])
             $ret=lut_name1($blz[,$filiale[,$ret]])
             $ret=lut_name_kurz1($blz[,$filiale[,$ret]])
             $ret=lut_plz1($blz[,$filiale[,$ret]])
             $ret=lut_ort1($blz[,$filiale[,$ret]])
             $ret=lut_pan1($blz[,$filiale[,$ret]])
             $ret=lut_bic1($blz[,$filiale[,$ret]])
             $ret=lut_pz1($blz[,$filiale[,$ret]])
             $ret=lut_aenderung1($blz[,$filiale[,$ret]])
             $ret=lut_loeschung1($blz[,$filiale[,$ret]])
             $ret=lut_nachfolge_blz1($blz[,$filiale[,$ret]])
             $ret=pz2str1($pz[,$ret])

   Die Funktionen entsprechen den Funktionen ohne die angeh�ngte "1";
   allerdings arbeiten sie ausschlie�lich im skalaren Kontext. Das ist
   z.B. vorteilhaft, wenn man den R�ckgabewert der Funktion in einem
   anderen Funktionsaufruf benutzen will. Der R�ckgabewert der
   Funktion kann mittels des optionalen Parameters $ret bestimmt
   werden.

-------------------------------------------------------------------------

  Funktion:  lut_suche_blz()
             lut_suche_bic()
             lut_suche_namen()
             lut_suche_namen_kurz()
             lut_suche_ort()
             lut_suche_pz()
             lut_suche_plz()
             lut_suche_volltext()
             lut_suche_multiple()

  Aufgabe:  Suche von Banken (nach Feldern der BLZ-Datei)

  Aufruf:    [$@]ret=lut_suche_bic($bic[,$retval[,$uniq[,$sort]]])
             [$@]ret=lut_suche_namen($namen[,$retval[,$uniq[,$sort]]])
             [$@]ret=lut_suche_namen_kurz($namen_kurz[,$retval[,$uniq[,$sort]]])
             [$@]ret=lut_suche_ort($ort[,$retval[,$uniq[,$sort]]])

             [$@]ret=lut_suche_blz($blz1[,$blz2[,$retval[,$uniq[,$sort]]]])
             [$@]ret=lut_suche_pz($pz1[,$pz2[,$retval[,$uniq[,$sort]]]])
             [$@]ret=lut_suche_plz($plz1[,$plz2[,$retval[,$uniq[,$sort]]]])

             [$@]ret=lut_suche_volltext($suchworte[,$retval[,$uniq[,$sort]]])
             [$@]ret=lut_suche_multiple($suchworte[,$uniq[,$such_cmd[,$retval]]])

   Mit diesen Funktionen lassen sich Banken suchen, die bestimmte
   Kriterien erf�llen. Bei alphanumerischer Suche (BIC, Name,
   Kurzname, Ort, Volltext, multiple) kann ein vollst�ndiger Name
   oder Namensanfang angegeben werden. So findet z.B. eine Suche
   lut_suche_ort("aa") die Banken in in Aach, Aachen, Aalen und
   Aarbergen, w�hrend eine Suche wie lut_suche_ort("aac") nur die
   Banken in Aach und Aachen findet. Soll die Suche exakt sein,
   d.h. das Suchwort nicht als Wortanfang verstanden werden, ist
   diesem ein ! voranzustellen. Eine Suche wie lut_suche_ort("!aach")
   findet dann nur Aach, nicht mehr Aachen. Diese Syntaxt l��t sich
   auch f�r lut_suche_multiple() anwenden.

   Bei numerischer Suche (BLZ, Pr�fziffer oder PLZ) kann ein Bereich
   spezifiziert werden. Falls der zweite Suchparameter nicht angegeben
   wird (oder 0 ist), werden Banken gesucht, die genau auf den
   Parameter passen.

   Diese Funktionen k�nnen sowohl in skalarem als auch im
   Listenkontext aufgerufen werden. Bei Aufruf in skalarem Kontext
   geben sie eine Referenz auf ein Array mit Bankleitzahlen zur�ck,
   die die Kriterien erf�llen; bei Aufruf im Listenkontext werden
   zwei (bei lut_suche_multiple()) bzw. vier (bei allen anderen
   Suchfunktionen) Array-Referenzen sowie der R�ckgabewert der
   Funktion zur�ckgegeben.

   Die erste zeigt auf das Array mit Bankleitzahlen, die zweite auf
   ein Array mit Indizes der jeweiligen Zweigstellen und die dritte
   (nicht lut_suche_multiple()!) auf ein Array mit den jeweiligen Werten
   des gesuchten Feldes. Der n�chste Parameter ist der Statuscode; als
   letzter Parameter kommt bei allen Suchfunktionen (au�er
   lut_suche_multiple()) noch eine Referenz auf ein Array, in dem zu
   jeder gefundenen BLZ die Anzahl der Zweigstellen zur�ckgegeben
   wird, falls der Parameter uniq auf 1 gesetzt war.

   In dem optionalen Parameter $retval wird ebenfalls der numerischer
   R�ckgabewert der Funktion (wie im 4. Parameter bei Array-Kontext; 1
   bei Erfolg, oder negative Statusmeldung) zur�ckgeliefert.. Mittels
   des assoziativen Arrays %kto_retval{$retval} k�nnen diese
   R�ckgabewerte in Klartext konvertiert werden.

   Die Funktion lut_suche_multiple() sucht alle Banken, die mehreren
   Kriterien entsprechen. Dabei k�nnen bis zu 26 Teilsuchen definiert
   werden, die beliebig miteinander verkn�pft werden k�nnen (additiv,
   subtraktiv und multiplikativ).

   Parameter:
   such_string: Dieser Parameter gibt die Felder an, nach denen
   gesucht wird. Er besteht aus einem oder mehreren Suchbefehlen, die
   jeweils folgenden Aufbau haben: [suchindex:]suchwert[@suchfeld]

   Der (optionale) Suchindex ist ein Buchstabe von a-z, mit dem das
   Suchfeld im Suchkommando (zweiter Parameter) referenziert werden
   kann. Falls er nicht angegeben wird, erh�lt der erste Suchstring
   den Index a, der zweite den Index b etc.

   Der Suchwert ist der Wert nach dem gesucht werden soll. F�r die
   Textfelder ist es der Beginn des Wortes (aa passt z.B. auf Aach,
   Aachen, Aalen, Aarbergen), f�r numerische Felder kann es eine
   Zahl oder ein Zahlbereich in der Form 22-33 sein.

   Das Suchfeld gibt an, nach welchem Feld der BLZ-Datei gesucht
   werden soll. Falls das Suchfeld nicht angegeben wird, wird eine
   Volltextsuche (alle Einzelworte in Name, Kurzname und Ort)
   gemacht. Die folgende Werte sind m�glich:

      bl    BLZ
      bi    BIC
      k     Kurzname
      n     Name
      o     Ort
      pl    PLZ
      pr    Pr�fziffer
      pz    Pr�fziffer
      v     Volltext

   In der obigen Tabelle der Suchfelder sind nur die Kurzversionen
   angegeben; eine Angabe wie aa@ort oder 57000-58000@plz ist auch
   problemlos m�glich.

   such_cmd: Dieser Parameter gibt an, wie die Teilsuchen miteinander
   verkn�pft werden sollen. Der Ausdruck abc bedeutet, da� die BLZs in
   den Teilsuchen a, b und c enthalten sein m�ssen; der Ausdruck
   a+b+c, da� sie in mindestens einer Teilsuche enthalten sein mu�;
   der Ausdruck a-b, da� sie in a, aber nicht in b enthalten sein darf
   (Beispiel s.u.). Falls das Suchkommando nicht angegeben wird,
   m�ssen die Ergebnis-BLZs in allen Teilsuchen enthalten sein.

   uniq: Falls dieser Parameter 1 ist, wird f�r jede Bank nur eine
   Zweigstelle ausgegeben; falls er 0 ist, werden alle gefundenen
   Zweigstellen ausgegeben. Falls der Parameter weggelassen wird, wird
   der Standardwert (UNIQ_DEFAULT_PERL aus konto_check.h) benutzt.

   sort: Falls dieser Parameter 1 ist, werden die Banken nach BLZ
   sortiert, nicht in der Reihenfolge der Suchbegriffe (Standard).
   Falls der Parameter uniq 1 ist, wird immer nach BLZ sortiert.

   Beispiele:
   $blz_p=lut_suche_ort("mannheim",$retval);
   @blz=@$blz_p;     # Array mit allen Banken in Mannheim
                     # $retval enth�lt den R�ckgabestatus der Funktion

   ($blz_p,$idx_p)=lut_suche_ort("mannheim");
   @blz=@$blz_p;     # Array mit allen Banken in Mannheim
   @idx=@$idx_p;     # Array der Zweigstellen

   ($blz_p,$idx_p,$ort_p)=lut_suche_ort("aa");
   @blz=@$blz_p;     # Array mit Banken in St�dten, die mit "aa" beginnen
   @idx=@$idx_p;     # Array der Zweigstellen
   @ort=@$ort_p;     # Array der jeweiligen Orte

   ($blz_p,$idx_p,$ort_p,$retval,$cnt_p)=lut_suche_ort("aa",$rv,1);
   @blz=@$blz_p;     # Array mit Banken in St�dten, die mit "aa" beginnen
   @idx=@$idx_p;     # Array der Zweigstellen
   @ort=@$ort_p;     # Array der jeweiligen Orte
   @cnt=@$cpt_p;     # Array mit Anzahl der gefundenen Zweigstellen (bei $uniq=1)
                     # $retval enth�lt den R�ckgabestatus der Funktion

   ($blz_p,$idx_p,$retval)
         =lut_suche_multiple("b:55000000-55100000@blz o:67000-68000@plz sparkasse","bo")
      # Bei diesem Aufruf werden nur die beiden ersten Teilsuchen (nach
      # BLZ und PLZ) benutzt; die Suche findet alle Banken mit einer BLZ
      # zwischen 55000000 und 55100000 im PLZ-Bereich 67000 bis 68000.

   ($blz_p,$idx_p,$retval)
         =lut_suche_multiple("b:55000000-55030000@blz o:67000-68000@plz sparkasse","co")
      # �hnlicher Suche wie oben, allerdings werden nur die beiden
      # letzten Teilsuchen ber�cksichtigt.

   ($blz_p,$idx_p,$retval)=lut_suche_multiple("67000-68000@plz sparda",0)
      # Dieser Aufruf gibt alle Filialen der Sparda-Bank im PLZ-Bereich
      # 67000 bis 68000 zur�ck.

   ($blz_p,$idx_p,$retval)=lut_suche_multiple("skat")
      # Dieser Aufruf ist einfach eine Volltextsuche nach der Skat-Bank.
      # Der direkte Aufruf von bank_suche_volltext() ist intern
      # nat�rlich wesentlich leichtgewichtiger, aber die Suche so auch
      # m�glich.


  Funktion:  kto_check_at()
             kto_check_at_str()

  Aufgabe:   Testen eines �sterreichischen Kontos

  Aufruf:    $retval=kto_check_at($blz,$kto,$lut_name);
             $retval=kto_check_at_str($blz,$kto,$lut_name);

  Parameter:
  $blz:     BLZ (5-stellig) oder Pr�fparameter (mit vorangestelltem p)
            Falls der BLZ ein - vorausgestellt wird, werden auch gel�schte
            Bankleitzahlen gepr�ft.
            Falls der BLZ ein p vorausgestellt wird, wird der folgende
            Teil (bis zum Blank/Tab) als Pr�fparameter angesehen.

  $kto:     Kontonummer

  $lut_name: Name der Lookup-Datei oder Leerstring
            Falls f�r $lut_name ein Leerstring angegeben wird, versucht
            die Funktion, die Datei blz-at.lut zu lesen.

-------------------------------------------------------------------------

  Funktion:  generate_lut_at()

  Aufgabe:   LUT-Datei f�r das �sterreichische Modul generieren

  Aufruf:    $retval=generate_lut_at($inputname,$outputname,$plain_name,$plain_format);

  Parameter:
     $inputname:  Name der INPAR-Datei (nur komplett, nicht inkrementell!)
     $outputname: Name der Zieldatei (z.B. blz-at.lut)
     $plain_name: (optional) Name einer Ausgabedatei f�r die Klartextausgabe.
     $plain_format: Format der Klartextausgabe (s.u.)

  Bugs:
     Diese Funktion sollte nicht von einem Programm aufgerufen werden,
     das zum Testen von Kontoverbindungen benutzt wird, da teilweise
     dieselben Variablen benutzt werden, und so falsche Ergebnisse
     erzeugt werden k�nnen. 

  Die Funktion generate_lut_at() generiert aus der Institutsparameter-
  Datenbankdatei (5,3 MB) eine kleine Datei (8,3 KB), in der nur die
  Bankleitzahlen und Pr�fziffermethoden gespeichert sind. Um die Datei
  klein zu halten, wird der gr��te Teil der Datei bin�r gespeichert.

  Falls der Parameter plain_name angegeben wird, wird zu jeder INPAR-
  Eintrag au�erdem (in einem frei w�hlbaren Format) noch in eine Klartext-
  datei geschrieben. Das Format der Datei wird durch den 4. Parameter
  ($plain_format) bestimmt. Es sind die folgenden Felder und Escape-
  Sequenzen definiert (der Sortierparameter mu� als erstes Zeichen
  kommen!):

     @i   Sortierung nach Identnummern
     @b   Sortierung nach Bankleitzahlen (default)
     %b   Bankleitzahl
     %B   Bankleitzahl (5-stellig, links mit Nullen aufgef�llt)
     %f   Kennzeichen fiktive Bankleitzahl
     %h   Kennzeichen Hauptstelle/Zweigstelle
     %i   Identnummer der �sterreichischen Nationalbank
     %I   Identnummer der �sterreichischen Nationalbank (7-stellig)
     %l   L�schdatum (DD.MM.YYYY falls vorhanden, sonst nichts)
     %L   L�schdatum (DD.MM.YYYY falls vorhanden, sonst 10 Blanks)
     %n1  Erster Teil des Banknamens
     %n2  Zweiter Teil des Banknamens
     %n3  Dritter Teil des Banknamens
     %N   kompletter Bankname (alle drei Teile zusammengesetzt)
     %p   Kontopr�fparameter
     %t   Name der Pr�ftabelle
     %z   zugeordnete BLZ (nur bei fiktiver BLZ, sonst nichts)
     %Z   zugeordnete BLZ (5-stellig bei fiktiver BLZ, sonst 5 Blanks)
     %%   das % Zeichen selbst

     \n   Zeilenvorschub
     \r   CR (f�r M$DOS)
     \t   Tabulatorzeichen
     \\   ein \

  @i (bzw. @b) mu� am Anfang des Formatstrings stehen; falls keine
  Sortierung angegeben wird, wird @b benutzt.

  Nicht definierte Felder und Escape-Sequenzen werden (zumindest momentan
  noch) direkt in die Ausgabedatei �bernommen. D.h., wenn man %x schreibt,
  erscheint in der Ausgabedatei auch ein %x, ohne da� ein Fehler gemeldet
  wird. Ob dies ein Bug oder Feature ist, sei dahingestellt; momentan
  scheint es eher ein Feature zu sein ;-))).

  Falls kein plain_format angegeben wird, wird "@B%I %B %t %N"
  benutzt. Die Datei ist (anders als die INPAR-Datei) nach
  Bankleitzahlen sortiert. N�hres zur Sortierung findet sich in der
  Einleitung zur Funktion cmp_blz().

  Die Funktion ist **nicht** threadfest, da dies aufgrund der gew�hlten
  Implementierung nur schwer zu machen w�re, und auch nicht sehr sinnvoll
  ist (sie wird nur ben�tigt, um die blz-at.lut Datei zu erstellen).

-------------------------------------------------------------------------

=head1 SEE ALSO

Eine ausf�hrliche Beschreibung der Pr�fziffermethoden und das Format
der LUT-Datei findet sich im C-Quellcode. Ein Link zur offiziellen
Beschreibung der Pr�fziffermethoden u.a. (von der Deutschen
Bundesbank) findet sich auf der Webseite zu konto_check unter
http://www.informatik.hs-mannheim.de/konto_check/konto_check.php?ausgabe=3

Auf SourceForge.net gibt es unter http://sourceforge.net/mail/?group_id=199719
auch eine Mailingliste. Der Traffic ist sehr gering, maximal meist ein bis zwei
Emails/Monat.

Die aktuelle Version findet sich auf CPAN unter
http://search.cpan.org/~michel/Business-KontoCheck oder auf
Sourceforge unter http://sourceforge.net/projects/kontocheck/develop
Dort ist auch ein SVN Repository, in dem die neuesten Versionen und
Bugfixes zu finden sind.

=head1 AUTHOR

Michael Plugge, E<lt>m.plugge@hs-mannheim.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007-2012 by Michael Plugge

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available (perl and glue code).

The C library is covered by the GNU Lesser General Public License:

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
details.

You should have received a copy of the GNU Lesser General Public License along
with this library; if not, write to the Free Software Foundation, Inc., 51
Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
or download it from http://www.gnu.org/licenses/lgpl.html

=cut
