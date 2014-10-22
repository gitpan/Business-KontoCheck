#vim:tw=70:ft=perl:si

package Business::KontoCheck;

use 5.006000;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw( kto_check kto_check_str kto_check_blz
   kto_check_pz generate_lut generate_lut2 lut_cleanup lut_valid
   lut_init kto_check_init copy_lutfile lut_multiple lut_filialen
   lut_name lut_name_kurz lut_plz lut_ort lut_pan lut_bic lut_pz
   lut_aenderung lut_loeschung lut_nachfolge_blz lut_info iban2bic
   iban_gen check_iban ipi_check ipi_gen set_verbose_debug
   kto_check_retval2txt kto_check_retval2txt_short kto_check_retval2utf8
   kto_check_retval2html dump_lutfile kto_check_retval2dos
   lut_suche_blz lut_suche_pz lut_suche_plz lut_suche_bic
   lut_suche_namen lut_suche_namen_kurz lut_suche_ort
   lut_suche_blz_idx lut_suche_pz_idx lut_suche_plz_idx
   lut_suche_bic_idx lut_suche_namen_idx lut_suche_namen_kurz_idx
   lut_suche_ort_idx lut_suche_blz_blz lut_suche_pz_blz
   lut_suche_plz_blz lut_suche_bic_blz lut_suche_namen_blz
   lut_suche_namen_kurz_blz lut_suche_ort_blz
   konto_check_at kto_check_at_str generate_lut_at %kto_retval
   %kto_retval_kurz  lut_suche_namen_idx lut_suche_namen_blz );

our @EXPORT = qw( kto_check lut_init kto_check_blz kto_check_at %kto_retval );

our $VERSION = '3.1';

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
      $ret=lut_info_i($lut_name,1+$args,$info1,$valid1,$info2,$valid2);
      return ($ret,$info1,$valid1,$info2,$valid2);
   }
   else{
      $ret=lut_info_i($lut_name,$args,$info1,$valid1,$info2,$valid2);
      return $ret;
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

sub lut_suche_bic_blz
{
   if(wantarray()){
      return lut_suche_c(3,1,@_);
   }
   else{
      return lut_suche_c(2,1,@_);
   }
}

sub lut_suche_bic_idx
{
   if(wantarray()){
      return lut_suche_c(5,1,@_);
   }
   else{
      return lut_suche_c(4,1,@_);
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

sub lut_suche_namen_blz
{
   if(wantarray()){
      return lut_suche_c(3,2,@_);
   }
   else{
      return lut_suche_c(2,2,@_);
   }
}

sub lut_suche_namen_idx
{
   if(wantarray()){
      return lut_suche_c(5,2,@_);
   }
   else{
      return lut_suche_c(4,2,@_);
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

sub lut_suche_namen_kurz_blz
{
   if(wantarray()){
      return lut_suche_c(3,3,@_);
   }
   else{
      return lut_suche_c(2,3,@_);
   }
}

sub lut_suche_namen_kurz_idx
{
   if(wantarray()){
      return lut_suche_c(5,3,@_);
   }
   else{
      return lut_suche_c(4,3,@_);
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

sub lut_suche_ort_blz
{
   if(wantarray()){
      return lut_suche_c(3,4,@_);
   }
   else{
      return lut_suche_c(2,4,@_);
   }
}

sub lut_suche_ort_idx
{
   if(wantarray()){
      return lut_suche_c(5,4,@_);
   }
   else{
      return lut_suche_c(4,4,@_);
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

sub lut_suche_blz_blz
{
   if(wantarray()){
      return lut_suche_i(3,1,@_);
   }
   else{
      return lut_suche_i(2,1,@_);
   }
}

sub lut_suche_blz_idx
{
   if(wantarray()){
      return lut_suche_i(5,1,@_);
   }
   else{
      return lut_suche_i(4,1,@_);
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

sub lut_suche_pz_blz
{
   if(wantarray()){
      return lut_suche_i(3,2,@_);
   }
   else{
      return lut_suche_i(2,2,@_);
   }
}

sub lut_suche_pz_idx
{
   if(wantarray()){
      return lut_suche_i(5,2,@_);
   }
   else{
      return lut_suche_i(4,2,@_);
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

sub lut_suche_plz_blz
{
   if(wantarray()){
      return lut_suche_i(3,3,@_);
   }
   else{
      return lut_suche_i(2,3,@_);
   }
}

sub lut_suche_plz_idx
{
   if(wantarray()){
      return lut_suche_i(5,3,@_);
   }
   else{
      return lut_suche_i(4,3,@_);
   }
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


%Business::KontoCheck::kto_retval = (
-110 => 'wahrscheinlich OK; es wurde allerdings ein (weggelassenes) Unterkonto angef�gt',
-109 => 'Ung�ltige Signatur im Default-Block',
-108 => 'Die maximale Anzahl Eintr�ge f�r den Default-Block wurde erreicht',
-107 => 'Es wurde noch kein Default-Block angelegt',
-106 => 'Der angegebene Schl�ssel wurde im Default-Block nicht gefunden',
-105 => 'Der Datensatz ist nicht mehr g�ltig, aber j�nger als der andere',
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

'OK_UNTERKONTO_ATTACHED'                 => 'wahrscheinlich OK; es wurde allerdings ein (weggelassenes) Unterkonto angef�gt',
'KTO_CHECK_DEFAULT_BLOCK_INVALID'        => 'Ung�ltige Signatur im Default-Block',
'KTO_CHECK_DEFAULT_BLOCK_FULL'           => 'Die maximale Anzahl Eintr�ge f�r den Default-Block wurde erreicht',
'KTO_CHECK_NO_DEFAULT_BLOCK'             => 'Es wurde noch kein Default-Block angelegt',
'KTO_CHECK_KEY_NOT_FOUND'                => 'Der angegebene Schl�ssel wurde im Default-Block nicht gefunden',
'LUT2_NO_LONGER_VALID_BETTER'            => 'Der Datensatz ist nicht mehr g�ltig, aber j�nger als der andere',
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
);

%Business::KontoCheck::kto_retval_kurz = (
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
);

END{ lut_cleanup(); }

1;
__END__

=head1 NAME

Business::KontoCheck - Perl extension for checking German and Austrian Bank Account Numbers

=head1 NOTE

Because the module is for use mainly in Germany, the following documentation
language is german too.

=head1 SYNOPSIS

   use Business::KontoCheck;
   use Business::KontoCheck qw( kto_check lut_name lut_blz lut_ort %kto_retval [...] );

   $retval=lut_init([$lut_name[,$required[,$set]]);
   $retval=kto_check_init($lut_name[,$required[,$set[,$incremental]]]);
   $retval=kto_check($blz,$kto,$lut_name);
   $retval=kto_check_str($blz,$kto,$lut_name);
   $retval=kto_check_blz($blz,$kto)
   $retval=kto_check_pz($pz,$blz,$kto)

   $retval=generate_lut($inputname,$outputname,$user_info,$lut_version);
   $retval=generate_lut2($inputname,$outputname[,$user_info[,$gueltigkeit[,$felder[,$filialen[,$slots[,$lut_version[,$set]]]]]]]);

   $retval=lut_valid()
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

   [$@]bic=lut_suche_bic($bic[,$retval[,$zweigstelle[,$blz]]])
   [$@]namen=lut_suche_namen($namen[,$retval[,$zweigstelle[,$blz]]])
   [$@]namen_kurz=lut_suche_namen_kurz($namen_kurz[,$retval[,$zweigstelle[,$blz]]])
   [$@]ort=lut_suche_ort($ort[,$retval[,$zweigstelle[,$blz]]])
   [$@]blz=lut_suche_blz($blz1[,$blz2[,$retval[,$zweigstelle[,$blz]]]])
   [$@]pz=lut_suche_pz($pz1[,$pz2[,$retval[,$zweigstelle[,$blz]]]])
   [$@]plz=lut_suche_plz($plz1[,$plz2[,$retval[,$zweigstelle[,$blz]]]])

   $retval=copy_lutfile($old_name,$new_name,$new_slots)
   $retval=dump_lutfile($outputname,$felder)
   $retval=lut_cleanup()

   $retval=iban_check(iban)
   $retval=iban2bic(iban)
   $retval=iban_gen(blz,kto)

   $retval=retval2txt($retval)
   $retval=retval2txt_short($retval)
   $retval=retval2html($retval)
   $retval=retval2utf8($retval)
   $retval=retval2dos($retval)
   $retval_txt=$kto_retval{$retval};

   $retval=kto_check_at($blz,$kto,$lut_name);
   $retval=kto_check_at_str($blz,$kto,$lut_name);
   $retval=generate_lut_at($inputname,$outputname,$plain_name,$plain_format);

=head1 DESCRIPTION

Dies ist Business::KontoCheck, ein Programm zum Testen der
Pr�fziffern von deutschen und �sterreichischen Bankkonten. Es war
urspr�nglich f�r die Benutzung mit dem dtaus-Paket von Martin
Schulze <joey@infodrom.org> und dem lx2l Pr�prozessor gedacht;
es l��t sich jedoch auch mit beliebigen anderen Programmen
verwenden. Dies ist die Perl-Version der C-Library (als XSUB
Modul).

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
     Die Funktion kto_check gibt einen numerischen Wert zur�ck, w�hrend die
     Funktion kto_check_str einen kurzen String zur�ckgibt.
     Werte sind definiert3

     Mittels des assoziativen Arrays %kto_retval lassen sich die numerischen
     und kurzen R�ckgabewerte in einen etwas ausf�hrlicheren R�ckgabetext
     umwandeln:

     $retval_txt=$kto_retval{$retval};

-------------------------------------------------------------------------

  Funktion:  generate_lut()      (LUT-Version 1.0 oder 1.1)
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
                  3: (nur f�r generate_lut2()) neues Format (2.0)

   Die folgenden Parameter gelten nur f�r generate_lut2():

     gueltigkeit: G�ltigkeitsbereich der LUT-Datei, im Format
                  JJJJMMTT-JJJJMMTT, z.B. 20071203-20080302

     felder:      (Integer, 0-9) Felder, die in die LUT-Datei
                  aufgenommen werden sollen.

     filialen:    Flag (0 oder 1), ob die Filialdaten ebenfalls
                  aufgenommen werden sollen.

     slots:       Anzahl Slots (m�gliche Verzeichniseintr�ge) der LUT-Datei

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

  Funktion:  lut_filialen()
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

  Aufruf:    [$@]ret=lut_name($blz[,$filiale])
             [$@]ret=lut_name_kurz($blz[,$filiale])
             [$@]ret=lut_plz($blz[,$filiale])
             [$@]ret=lut_ort($blz[,$filiale])
             [$@]ret=lut_pan($blz[,$filiale])
             [$@]ret=lut_bic($blz[,$filiale])
             [$@]ret=lut_pz($blz[,$filiale])
             [$@]ret=lut_aenderung($blz[,$filiale])
             [$@]ret=lut_loeschung($blz[,$filiale])
             [$@]ret=lut_nachfolge_blz($blz[,$filiale])

   Die Funktionen bestimmen die diversen Felder der BLZ-Datei zu einer
   gegebenen BLZ. Falls der optionale Parameter $filiale angegeben
   wird, wird der Wert f�r eine Filiale bestimmt, ansonsten (und bei
   $filiale==0) der Wert der Hauptstelle. Die Anzahl der Filialen zu
   einer BLZ l��t sich mittels der Funktion $cnt=lut_filialen($blz)
   bestimmen.

   Alle Funktionen lassen sich sowohl im skalaren als auch im Array-
   Kontext aufrufen. Bei Aufruf in skalarem Kontext wird der jeweilige
   Wert zur�ckgegeben; bei Aufruf im Array-Kontext wird au�erdem noch
   der R�ckgabestatus der Funktion als Zahl, String (lang) und String
   (kurz) zur�ckgegeben. Beispiel:

   $ret=lut_name("66090800") liefert f�r $ret den Wert "BBBank",
   @ret=lut_name("66090800") liefert ein Array mit den Werten
   @ret=("BBBank",1,"ok","OK")

   der Aufruf
   @ret=lut_name("660908") liefert ein Array mit den Werten
   @ret=("",-5,"die Bankleitzahl ist nicht achtstellig","INVALID_BLZ_LENGTH")


-------------------------------------------------------------------------

  Funktion:  lut_suche_bic()
             lut_suche_namen()
             lut_suche_namen_kurz()
             lut_suche_ort()
             lut_suche_blz()
             lut_suche_pz()
             lut_suche_plz()

  Aufgabe:  Suche von Banken (nach Feldern der BLZ-Datei)

  Aufruf:    [$@]ret=lut_suche_bic($bic[,$retval[,$zweigstelle[,$blz]]])
             [$@]ret=lut_suche_namen($namen[,$retval[,$zweigstelle[,$blz]]])
             [$@]ret=lut_suche_namen_kurz($namen_kurz[,$retval[,$zweigstelle[,$blz]]])
             [$@]ret=lut_suche_ort($ort[,$retval[,$zweigstelle[,$blz]]])
             [$@]ret=lut_suche_blz($blz1[,$blz2[,$retval[,$zweigstelle[,$blz]]]])
             [$@]ret=lut_suche_pz($pz1[,$pz2[,$retval[,$zweigstelle[,$blz]]]])
             [$@]ret=lut_suche_plz($plz1[,$plz2[,$retval[,$zweigstelle[,$blz]]]])

   Mit diesen Funktionen lassen sich Banken suchen, die bestimmte Kriterien
   erf�llen. Bei alphanumerischer Suche (BIC, Name, Kurzname, Ort) kann ein
   vollst�ndiger Name oder Namensanfang angegeben werden. So findet z.B. eine
   Suche lut_suche_ort("aa") die Banken in in Aach, Aachen, Aalen und Aarbergen,
   w�hrend eine Suche wie lut_suche_ort("aac") nur die Banken in Aach und Aachen
   findet.

   Bei numerischer Suche (BLZ, Pr�fziffer oder PLZ) kann ein Bereich
   spezifiziert werden. Falls der zweite Suchparameter nicht angegeben wird
   (oder 0 ist), werden Banken gesucht, die genau auf den Parameter passen.

   Diese Funktionen k�nnen sowohl in skalarem als auch im Listenkontext
   aufgerufen werden. Bei Aufruf in skalarem Kontext geben sie die Anzahl Banken
   zur�ck, die die spezifizierte Bedingung erf�llen; bei Aufruf in Listenkontext
   wird ein Array zur�ckgegeben, das die jeweils gesuchten Felder enth�lt.

   Die Funktionen haben eine Reihe optionaler Parameter:

      $retval:       numerischer R�ckgabewert der Funktion (1 bei Erfolg, oder
                     negative Statusmeldung). Mittels des assoziativen Arrays
                     %kto_retval{$retval} k�nnen diese R�ckgabewerte in Klartext
                     konvertiert werden.

      $zweigstelle:  Referenz auf ein Array, in dem zu jeder Bank der Index der
                     jeweiligen Zweigstelle enthalten ist; die Hauptstelle wird
                     mit 0 gekennzeichnet.

      $blz:          Referenz auf ein Array, das die Bankleitzahen der
                     gefundenen Banken enth�lt.

-------------------------------------------------------------------------

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


=head1 BUGS der Version 2.x:

Die alten Problemf�lle aus Version 2.x sind ab Version 3.0 behoben:

 - Die Funktion generate_lut() benutzt einen eigenen Variablensatz, so
   da� keine Interferenzen mit den Testroutinen auftreten (das git noch
   nicht f�r generate_lut_at()!).

 - Die Bibliothek ist jetzt threadfest

 - Es ist m�glich, die Initialisierung mehrfach aufzurufen; der vorher
    allokierte Speicher wird dabei automatisch freigegeben. Auch eine
    inkrementelle Initialisierung (bei der nur einige Blocks der
    LUT-Datei nachgeladen werden) ist m�glich. Falls in der LUT-Datei
    zwei Datens�tze enthalten sind (und nicht ein bestimmter
    ausgew�hlt wird), erfolgt die (Neu-)Initialisierung in
    Abh�ngigkeit vom aktuellen Datum.


=head1 SEE ALSO

Eine ausf�hrliche Beschreibung der Pr�fziffermethoden und das Format der
LUT-Datei findet sich im C-Quellcode.

Eine Mailingliste zu konto_check findet sich auf SourceForge.net unter
http://sourceforge.net/mail/?group_id=199719

Die aktuelle Version findet sich unter http://www.informatik.hs-mannheim.de/konto_check

=head1 AUTHOR

Michael Plugge, E<lt>m.plugge@hs-mannheim.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007-2008 by Michael Plugge

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

=cut
