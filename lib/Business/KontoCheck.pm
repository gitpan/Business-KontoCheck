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
   konto_check_at kto_check_at_str generate_lut_at %kto_retval
   %kto_retval_kurz );

our @EXPORT = qw( kto_check lut_init kto_check_blz kto_check_at %kto_retval );

our $VERSION = '2.94';

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

   if(scalar(@_)<1){ #keine BLZ angegeben, leere Liste zurück
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
 -75 => 'für ein LUT-Set sind nur die Werte 0, 1 oder 2 möglich',
 -74 => 'Ein Konto kann kann nur für deutsche Banken geprüft werden',
 -73 => 'Der zu validierende strukturierete Verwendungszweck muß genau 20 Zeichen enthalten',
 -72 => 'Im strukturierten Verwendungszweck dürfen nur alphanumerische Zeichen vorkommen',
 -71 => 'Die Länge des IPI-Verwendungszwecks darf maximal 18 Byte sein',
 -70 => 'Es wurde eine LUT-Datei im Format 1.0/1.1 geladen',
 -69 => 'Bei der Kontoprüfung fehlt ein notwendiger Parameter (BLZ oder Konto)',
 -68 => 'Die Funktion iban2bic() arbeitet nur mit deutschen Bankleitzahlen',
 -67 => 'Die Prüfziffer der IBAN stimmt, die der Kontonummer nicht',
 -66 => 'Die Prüfziffer der Kontonummer stimmt, die der IBAN nicht',
 -65 => 'Es sind nur maximal 500 Slots pro LUT-Datei möglich (Neukompilieren erforderlich)',
 -64 => 'Initialisierung fehlgeschlagen (init_wait geblockt)',
 -63 => 'Ein inkrementelles Initialisieren benötigt einen Info-Block in der LUT-Datei',
 -62 => 'Ein inkrementelles Initialisieren mit einer anderen LUT-Datei ist nicht möglich',
 -61 => 'Die Funktion ist nur in der Debug-Version vorhanden',
 -60 => 'Kein Datensatz der LUT-Datei ist aktuell gültig',
 -59 => 'Der Datensatz ist noch nicht gültig',
 -58 => 'Der Datensatz ist nicht mehr gültig',
 -57 => 'Im Gültigkeitsdatum sind Anfangs- und Enddatum vertauscht',
 -56 => 'Das angegebene Gültigkeitsdatum ist ungültig (Soll: JJJJMMTT-JJJJMMTT)',
 -55 => 'Der Index für die Filiale ist ungültig',
 -54 => 'Die Bibliothek wird gerade neu initialisiert',
 -53 => 'Das Feld BLZ wurde nicht initialisiert',
 -52 => 'Das Feld Filialen wurde nicht initialisiert',
 -51 => 'Das Feld Bankname wurde nicht initialisiert',
 -50 => 'Das Feld PLZ wurde nicht initialisiert',
 -49 => 'Das Feld Ort wurde nicht initialisiert',
 -48 => 'Das Feld Kurzname wurde nicht initialisiert',
 -47 => 'Das Feld PAN wurde nicht initialisiert',
 -46 => 'Das Feld BIC wurde nicht initialisiert',
 -45 => 'Das Feld Prüfziffer wurde nicht initialisiert',
 -44 => 'Das Feld NR wurde nicht initialisiert',
 -43 => 'Das Feld Änderung wurde nicht initialisiert',
 -42 => 'Das Feld Löschung wurde nicht initialisiert',
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
 -28 => 'Der benötigte Programmteil wurde beim Kompilieren deaktiviert',
 -27 => 'Die Versionsnummer für die LUT-Datei ist ungültig',
 -26 => 'ungültiger Prüfparameter (erste zu prüfende Stelle)',
 -25 => 'ungültiger Prüfparameter (Anzahl zu prüfender Stellen)',
 -24 => 'ungültiger Prüfparameter (Position der Prüfziffer)',
 -23 => 'ungültiger Prüfparameter (Wichtung)',
 -22 => 'ungültiger Prüfparameter (Rechenmethode)',
 -21 => 'Problem beim Initialisieren der globalen Variablen',
 -20 => 'Prüfsummenfehler in der blz.lut Datei',
 -19 => 'falsch (die BLZ wurde außerdem gelöscht)',
 -18 => 'ok, ohne Prüfung (die BLZ wurde allerdings gelöscht)',
 -17 => 'ok (die BLZ wurde allerdings gelöscht)',
 -16 => 'die Bankleitzahl wurde gelöscht',
 -15 => 'Fehler in der blz.txt Datei (falsche Zeilenlänge)',
 -14 => 'undefinierte Funktion; die library wurde mit THREAD_SAFE=0 kompiliert',
 -13 => 'schwerer Fehler im Konto_check-Modul',
 -12 => 'ein Konto muß zwischen 1 und 10 Stellen haben',
 -11 => 'kann Datei nicht schreiben',
 -10 => 'kann Datei nicht lesen',
  -9 => 'kann keinen Speicher allokieren',
  -8 => 'die blz.txt Datei wurde nicht gefunden',
  -7 => 'die blz.lut Datei ist inkosistent/ungültig',
  -6 => 'die blz.lut Datei wurde nicht gefunden',
  -5 => 'die Bankleitzahl ist nicht achtstellig',
  -4 => 'die Bankleitzahl ist ungültig',
  -3 => 'das Konto ist ungültig',
  -2 => 'die Methode wurde noch nicht implementiert',
  -1 => 'die Methode ist nicht definiert',
   0 => 'falsch',
   1 => 'ok',
   2 => 'ok, ohne Prüfung',
   3 => 'ok; für den Test wurde eine Test-BLZ verwendet',
   4 => 'Der Datensatz ist aktuell gültig',
   5 => 'Der Datensatz enthält kein Gültigkeitsdatum',
   6 => 'Die Datei ist im alten LUT-Format (1.0/1.1)',
   7 => 'OK; es wurde allerdings eine LUT-Datei im alten Format (1.0/1.1) generiert (version<3)',

'INVALID_SET'                            => 'für ein LUT-Set sind nur die Werte 0, 1 oder 2 möglich',
'NO_GERMAN_BIC'                          => 'Ein Konto kann kann nur für deutsche Banken geprüft werden',
'IPI_CHECK_INVALID_LENGTH'               => 'Der zu validierende strukturierete Verwendungszweck muß genau 20 Zeichen enthalten',
'IPI_INVALID_CHARACTER'                  => 'Im strukturierten Verwendungszweck dürfen nur alphanumerische Zeichen vorkommen',
'IPI_INVALID_LENGTH'                     => 'Die Länge des IPI-Verwendungszwecks darf maximal 18 Byte sein',
'LUT1_FILE_USED'                         => 'Es wurde eine LUT-Datei im Format 1.0/1.1 geladen',
'MISSING_PARAMETER'                      => 'Bei der Kontoprüfung fehlt ein notwendiger Parameter (BLZ oder Konto)',
'IBAN2BIC_ONLY_GERMAN'                   => 'Die Funktion iban2bic() arbeitet nur mit deutschen Bankleitzahlen',
'IBAN_OK_KTO_NOT'                        => 'Die Prüfziffer der IBAN stimmt, die der Kontonummer nicht',
'KTO_OK_IBAN_NOT'                        => 'Die Prüfziffer der Kontonummer stimmt, die der IBAN nicht',
'TOO_MANY_SLOTS'                         => 'Es sind nur maximal 500 Slots pro LUT-Datei möglich (Neukompilieren erforderlich)',
'INIT_FATAL_ERROR'                       => 'Initialisierung fehlgeschlagen (init_wait geblockt)',
'INCREMENTAL_INIT_NEEDS_INFO'            => 'Ein inkrementelles Initialisieren benötigt einen Info-Block in der LUT-Datei',
'INCREMENTAL_INIT_FROM_DIFFERENT_FILE'   => 'Ein inkrementelles Initialisieren mit einer anderen LUT-Datei ist nicht möglich',
'DEBUG_ONLY_FUNCTION'                    => 'Die Funktion ist nur in der Debug-Version vorhanden',
'LUT2_INVALID'                           => 'Kein Datensatz der LUT-Datei ist aktuell gültig',
'LUT2_NOT_YET_VALID'                     => 'Der Datensatz ist noch nicht gültig',
'LUT2_NO_LONGER_VALID'                   => 'Der Datensatz ist nicht mehr gültig',
'LUT2_GUELTIGKEIT_SWAPPED'               => 'Im Gültigkeitsdatum sind Anfangs- und Enddatum vertauscht',
'LUT2_INVALID_GUELTIGKEIT'               => 'Das angegebene Gültigkeitsdatum ist ungültig (Soll: JJJJMMTT-JJJJMMTT)',
'LUT2_INDEX_OUT_OF_RANGE'                => 'Der Index für die Filiale ist ungültig',
'LUT2_INIT_IN_PROGRESS'                  => 'Die Bibliothek wird gerade neu initialisiert',
'LUT2_BLZ_NOT_INITIALIZED'               => 'Das Feld BLZ wurde nicht initialisiert',
'LUT2_FILIALEN_NOT_INITIALIZED'          => 'Das Feld Filialen wurde nicht initialisiert',
'LUT2_NAME_NOT_INITIALIZED'              => 'Das Feld Bankname wurde nicht initialisiert',
'LUT2_PLZ_NOT_INITIALIZED'               => 'Das Feld PLZ wurde nicht initialisiert',
'LUT2_ORT_NOT_INITIALIZED'               => 'Das Feld Ort wurde nicht initialisiert',
'LUT2_NAME_KURZ_NOT_INITIALIZED'         => 'Das Feld Kurzname wurde nicht initialisiert',
'LUT2_PAN_NOT_INITIALIZED'               => 'Das Feld PAN wurde nicht initialisiert',
'LUT2_BIC_NOT_INITIALIZED'               => 'Das Feld BIC wurde nicht initialisiert',
'LUT2_PZ_NOT_INITIALIZED'                => 'Das Feld Prüfziffer wurde nicht initialisiert',
'LUT2_NR_NOT_INITIALIZED'                => 'Das Feld NR wurde nicht initialisiert',
'LUT2_AENDERUNG_NOT_INITIALIZED'         => 'Das Feld Änderung wurde nicht initialisiert',
'LUT2_LOESCHUNG_NOT_INITIALIZED'         => 'Das Feld Löschung wurde nicht initialisiert',
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
'EXCLUDED_AT_COMPILETIME'                => 'Der benötigte Programmteil wurde beim Kompilieren deaktiviert',
'INVALID_LUT_VERSION'                    => 'Die Versionsnummer für die LUT-Datei ist ungültig',
'INVALID_PARAMETER_STELLE1'              => 'ungültiger Prüfparameter (erste zu prüfende Stelle)',
'INVALID_PARAMETER_COUNT'                => 'ungültiger Prüfparameter (Anzahl zu prüfender Stellen)',
'INVALID_PARAMETER_PRUEFZIFFER'          => 'ungültiger Prüfparameter (Position der Prüfziffer)',
'INVALID_PARAMETER_WICHTUNG'             => 'ungültiger Prüfparameter (Wichtung)',
'INVALID_PARAMETER_METHODE'              => 'ungültiger Prüfparameter (Rechenmethode)',
'LIBRARY_INIT_ERROR'                     => 'Problem beim Initialisieren der globalen Variablen',
'LUT_CRC_ERROR'                          => 'Prüfsummenfehler in der blz.lut Datei',
'FALSE_GELOESCHT'                        => 'falsch (die BLZ wurde außerdem gelöscht)',
'OK_NO_CHK_GELOESCHT'                    => 'ok, ohne Prüfung (die BLZ wurde allerdings gelöscht)',
'OK_GELOESCHT'                           => 'ok (die BLZ wurde allerdings gelöscht)',
'BLZ_GELOESCHT'                          => 'die Bankleitzahl wurde gelöscht',
'INVALID_BLZ_FILE'                       => 'Fehler in der blz.txt Datei (falsche Zeilenlänge)',
'LIBRARY_IS_NOT_THREAD_SAFE'             => 'undefinierte Funktion; die library wurde mit THREAD_SAFE=0 kompiliert',
'FATAL_ERROR'                            => 'schwerer Fehler im Konto_check-Modul',
'INVALID_KTO_LENGTH'                     => 'ein Konto muß zwischen 1 und 10 Stellen haben',
'FILE_WRITE_ERROR'                       => 'kann Datei nicht schreiben',
'FILE_READ_ERROR'                        => 'kann Datei nicht lesen',
'ERROR_MALLOC'                           => 'kann keinen Speicher allokieren',
'NO_BLZ_FILE'                            => 'die blz.txt Datei wurde nicht gefunden',
'INVALID_LUT_FILE'                       => 'die blz.lut Datei ist inkosistent/ungültig',
'NO_LUT_FILE'                            => 'die blz.lut Datei wurde nicht gefunden',
'INVALID_BLZ_LENGTH'                     => 'die Bankleitzahl ist nicht achtstellig',
'INVALID_BLZ'                            => 'die Bankleitzahl ist ungültig',
'INVALID_KTO'                            => 'das Konto ist ungültig',
'NOT_IMPLEMENTED'                        => 'die Methode wurde noch nicht implementiert',
'NOT_DEFINED'                            => 'die Methode ist nicht definiert',
'FALSE'                                  => 'falsch',
'OK'                                     => 'ok',
'OK_NO_CHK'                              => 'ok, ohne Prüfung',
'OK_TEST_BLZ_USED'                       => 'ok; für den Test wurde eine Test-BLZ verwendet',
'LUT2_VALID'                             => 'Der Datensatz ist aktuell gültig',
'LUT2_NO_VALID_DATE'                     => 'Der Datensatz enthält kein Gültigkeitsdatum',
'LUT1_SET_LOADED'                        => 'Die Datei ist im alten LUT-Format (1.0/1.1)',
'LUT1_FILE_GENERATED'                    => 'OK; es wurde allerdings eine LUT-Datei im alten Format (1.0/1.1) generiert (version<3)',
);

%Business::KontoCheck::kto_retval_kurz = (
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
   @retval=lut_info($lut_name)
   $retval=lut_filialen($blz[,$offset])
   $retval=lut_name($blz[,$offset])
   $retval=lut_name_kurz($blz[,$offset])
   $retval=lut_plz($blz[,$offset])
   $retval=lut_ort($blz[,$offset])
   $retval=lut_pan($blz[,$offset])
   $retval=lut_bic($blz[,$offset])
   $retval=lut_pz($blz[,$offset])
   $retval=lut_aenderung($blz[,$offset])
   $retval=lut_loeschung($blz[,$offset])
   $retval=lut_nachfolge_blz($blz[,$offset])
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
Prüfziffern von deutschen und österreichischen Bankkonten. Es war
ursprünglich für die Benutzung mit dem dtaus-Paket von Martin
Schulze <joey@infodrom.org> und dem lx2l Präprozessor gedacht;
es läßt sich jedoch auch mit beliebigen anderen Programmen
verwenden. Dies ist die Perl-Version der C-Library (als XSUB
Modul).

=head1 EXPORT

Es werden defaultmäßig die Funkionen kto_check und kto_check_str,
(aus dem deutschen Modul), kto_check_at, kto_check_at_str (aus
dem österreichischen Modul) sowie die Variable %kto_retval (für
beide Module) exportiert.

Optional können auch die Funktionen generate_lut, sowie
generate_lut_at exportiert werden; in diesem Fall sind die gewünschten
Funktionen in der use Klausel anzugeben.

=head1 DESCRIPTION

  Funktion:  kto_check()
             kto_check_str()

  Aufgabe:   Testen eines Kontos

  Aufruf:    $retval=kto_check($blz,$kto,$lut_name);
             $retval=kto_check_str($blz,$kto,$lut_name);

  Parameter:
     $blz:      falls 2- oder 3-stellig: Prüfziffermethode
                (evl. mit Untermethode a, b, c... oder 1, 2, 3)
                falls 8-stellig: Bankleitzahl

     $kto:      Kontonummer (wird vor der Berechnung
                linksbündig mit Nullen auf 10 Stellen
                aufgefüllt)

     $lut_name: Dateiname der Lookup-Tabelle mit Bankleitzahlen.
                Falls NULL oder ein leerer String übergeben wird,
                wird der Dateiname blz.lut benutzt.
                Diese Datei enthält die Prüfziffermethoden für die
                einzelnen Bankleitzahlen; sie kann mit der Funktion
                generate_lut() aus der Bundesbanktabelle generiert
                werden.

  Rückgabewerte:
     Die Funktion kto_check gibt einen numerischen Wert zurück, während die
     Funktion kto_check_str einen kurzen String zurückgibt.
     Werte sind definiert3

     Mittels des assoziativen Arrays %kto_retval lassen sich die numerischen
     und kurzen Rückgabewerte in einen etwas ausführlicheren Rückgabetext
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

     user_info:   Info-Zeile, die zusätzlich in die LUT-Datei
                  geschrieben wird. Diese Zeile wird von der
                  Funktion get_lut_info() in zurückgegeben,
                  aber ansonsten nicht ausgewertet.

     lut_version: Format der LUT-Datei. Mögliche Werte:
                  1: altes Format (1.0)
                  2: altes Format (1.1) mit Infozeile
                  3: (nur für generate_lut2()) neues Format (2.0)

   Die folgenden Parameter gelten nur für generate_lut2():

     gueltigkeit: Gültigkeitsbereich der LUT-Datei, im Format
                  JJJJMMTT-JJJJMMTT, z.B. 20071203-20080302

     felder:      (Integer, 0-9) Felder, die in die LUT-Datei
                  aufgenommen werden sollen.

     filialen:    Flag (0 oder 1), ob die Filialdaten ebenfalls
                  aufgenommen werden sollen.

     slots:       Anzahl Slots (mögliche Verzeichniseinträge) der LUT-Datei

     set:         (Integer, 0, 1 oder 2) Angabe, ob das primäre Set (0
                  bzw. 1) oder sekundäre Datensatz (2) geschrieben
                  werden soll. Falls für set 0 angegeben wird, wird
                  eine neue Datei angelegt, bei 1 und 2 wird der
                  Datensatz an eine vorhandene LUT-Datei angehängt.
                  Das setzt natürlich voraus, daß noch genügend
                  Verzeichnisslots vorhanden sind, um alle Blocks
                  schreiben zu können. Bei Bedarf kann mittels
                  copy_lutfile() die Anzahl der Verzeichnisslots auch
                  erhöht werden.

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
   wird, wird der Wert für eine Filiale bestimmt, ansonsten (und bei
   $filiale==0) der Wert der Hauptstelle. Die Anzahl der Filialen zu
   einer BLZ läßt sich mittels der Funktion $cnt=lut_filialen($blz)
   bestimmen.

   Alle Funktionen lassen sich sowohl im skalaren als auch im Array-
   Kontext aufrufen. Bei Aufruf in skalarem Kontext wird der jeweilige
   Wert zurückgegeben; bei Aufruf im Array-Kontext wird außerdem noch
   der Rückgabestatus der Funktion als Zahl, String (lang) und String
   (kurz) zurückgegeben. Beispiel:

   $ret=lut_name("66090800") liefert für $ret den Wert "BBBank",
   @ret=lut_name("66090800") liefert ein Array mit den Werten
   @ret=("BBBank",1,"ok","OK")

   der Aufruf
   @ret=lut_name("660908") liefert ein Array mit den Werten
   @ret=("",-5,"die Bankleitzahl ist nicht achtstellig","INVALID_BLZ_LENGTH")


-------------------------------------------------------------------------

  Funktion:  kto_check_at()
             kto_check_at_str()

  Aufgabe:   Testen eines österreichischen Kontos

  Aufruf:    $retval=kto_check_at($blz,$kto,$lut_name);
             $retval=kto_check_at_str($blz,$kto,$lut_name);

  Parameter:
  $blz:     BLZ (5-stellig) oder Prüfparameter (mit vorangestelltem p)
            Falls der BLZ ein - vorausgestellt wird, werden auch gelöschte
            Bankleitzahlen geprüft.
            Falls der BLZ ein p vorausgestellt wird, wird der folgende
            Teil (bis zum Blank/Tab) als Prüfparameter angesehen.

  $kto:     Kontonummer

  $lut_name: Name der Lookup-Datei oder Leerstring
            Falls für $lut_name ein Leerstring angegeben wird, versucht
            die Funktion, die Datei blz-at.lut zu lesen.

-------------------------------------------------------------------------

  Funktion:  generate_lut_at()

  Aufgabe:   LUT-Datei für das österreichische Modul generieren

  Aufruf:    $retval=generate_lut_at($inputname,$outputname,$plain_name,$plain_format);

  Parameter:
     $inputname:  Name der INPAR-Datei (nur komplett, nicht inkrementell!)
     $outputname: Name der Zieldatei (z.B. blz-at.lut)
     $plain_name: (optional) Name einer Ausgabedatei für die Klartextausgabe.
     $plain_format: Format der Klartextausgabe (s.u.)

  Bugs:
     Diese Funktion sollte nicht von einem Programm aufgerufen werden,
     das zum Testen von Kontoverbindungen benutzt wird, da teilweise
     dieselben Variablen benutzt werden, und so falsche Ergebnisse
     erzeugt werden können. 

  Die Funktion generate_lut_at() generiert aus der Institutsparameter-
  Datenbankdatei (5,3 MB) eine kleine Datei (8,3 KB), in der nur die
  Bankleitzahlen und Prüfziffermethoden gespeichert sind. Um die Datei
  klein zu halten, wird der größte Teil der Datei binär gespeichert.

  Falls der Parameter plain_name angegeben wird, wird zu jeder INPAR-
  Eintrag außerdem (in einem frei wählbaren Format) noch in eine Klartext-
  datei geschrieben. Das Format der Datei wird durch den 4. Parameter
  ($plain_format) bestimmt. Es sind die folgenden Felder und Escape-
  Sequenzen definiert (der Sortierparameter muß als erstes Zeichen
  kommen!):

     @i   Sortierung nach Identnummern
     @b   Sortierung nach Bankleitzahlen (default)
     %b   Bankleitzahl
     %B   Bankleitzahl (5-stellig, links mit Nullen aufgefüllt)
     %f   Kennzeichen fiktive Bankleitzahl
     %h   Kennzeichen Hauptstelle/Zweigstelle
     %i   Identnummer der Österreichischen Nationalbank
     %I   Identnummer der Österreichischen Nationalbank (7-stellig)
     %l   Löschdatum (DD.MM.YYYY falls vorhanden, sonst nichts)
     %L   Löschdatum (DD.MM.YYYY falls vorhanden, sonst 10 Blanks)
     %n1  Erster Teil des Banknamens
     %n2  Zweiter Teil des Banknamens
     %n3  Dritter Teil des Banknamens
     %N   kompletter Bankname (alle drei Teile zusammengesetzt)
     %p   Kontoprüfparameter
     %t   Name der Prüftabelle
     %z   zugeordnete BLZ (nur bei fiktiver BLZ, sonst nichts)
     %Z   zugeordnete BLZ (5-stellig bei fiktiver BLZ, sonst 5 Blanks)
     %%   das % Zeichen selbst

     \n   Zeilenvorschub
     \r   CR (für M$DOS)
     \t   Tabulatorzeichen
     \\   ein \

  @i (bzw. @b) muß am Anfang des Formatstrings stehen; falls keine
  Sortierung angegeben wird, wird @b benutzt.

  Nicht definierte Felder und Escape-Sequenzen werden (zumindest momentan
  noch) direkt in die Ausgabedatei übernommen. D.h., wenn man %x schreibt,
  erscheint in der Ausgabedatei auch ein %x, ohne daß ein Fehler gemeldet
  wird. Ob dies ein Bug oder Feature ist, sei dahingestellt; momentan
  scheint es eher ein Feature zu sein ;-))).

  Falls kein plain_format angegeben wird, wird "@B%I %B %t %N"
  benutzt. Die Datei ist (anders als die INPAR-Datei) nach
  Bankleitzahlen sortiert. Nähres zur Sortierung findet sich in der
  Einleitung zur Funktion cmp_blz().

  Die Funktion ist **nicht** threadfest, da dies aufgrund der gewählten
  Implementierung nur schwer zu machen wäre, und auch nicht sehr sinnvoll
  ist (sie wird nur benötigt, um die blz-at.lut Datei zu erstellen).

-------------------------------------------------------------------------


=head1 BUGS der Version 2.x:

Die alten Problemfälle aus Version 2.x sind ab Version 3.0 behoben:

 - Die Funktion generate_lut() benutzt einen eigenen Variablensatz, so
   daß keine Interferenzen mit den Testroutinen auftreten (das git noch
   nicht für generate_lut_at()!).

 - Die Bibliothek ist jetzt threadfest

 - Es ist möglich, die Initialisierung mehrfach aufzurufen; der vorher
    allokierte Speicher wird dabei automatisch freigegeben. Auch eine
    inkrementelle Initialisierung (bei der nur einige Blocks der
    LUT-Datei nachgeladen werden) ist möglich. Falls in der LUT-Datei
    zwei Datensätze enthalten sind (und nicht ein bestimmter
    ausgewählt wird), erfolgt die (Neu-)Initialisierung in
    Abhängigkeit vom aktuellen Datum.


=head1 SEE ALSO

Eine ausführliche Beschreibung der Prüfziffermethoden und das Format der
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
