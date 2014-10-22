#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "konto_check.h"
#include "konto_check-at.h"

MODULE = Business::KontoCheck		PACKAGE = Business::KontoCheck		
PROTOTYPES: ENABLE

# Aufrufe der konto_check Bibliothek
int
kto_check(pz_or_blz,kto,lut_name)
   char *pz_or_blz;
   char *kto;
   char *lut_name;

const char *
kto_check_str(pz_or_blz,kto,lut_name)
   char *pz_or_blz;
   char *kto;
   char *lut_name;

int
kto_check_blz(blz,kto)
   char *blz;
   char *kto;

int
set_verbose_debug(mode)
	int mode;

int
set_default_compression(mode)
	int mode;

int
dump_lutfile(outputname,felder)
   char *outputname;
   int felder;
CODE:
   RETVAL=dump_lutfile_p(outputname,felder);
OUTPUT:
   RETVAL

int
kto_check_pz(pz,kto...)
   char *pz;
   char *kto;
PREINIT:
   char *blz;
CODE:
   switch(items){
      case 2:
         blz=NULL;
         break;
      case 3:
         blz=(char *)SvPV_nolen(ST(2));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::kto_check_pz(pz, kto[, blz])");
         break;
   }
   RETVAL = kto_check_pz(pz,kto,blz);
OUTPUT:
   RETVAL

int
lut_valid()

void
lut_cleanup()

int
lut_init(...)
PREINIT:
   char *lut_name;
   unsigned int required;
   unsigned int set;
CODE:
   switch(items){
      case 0:
         lut_name=NULL;
         required=DEFAULT_INIT_LEVEL;
         set=0;
         break;
      case 1:
         lut_name=(char *)SvPV_nolen(ST(0));
         required=DEFAULT_INIT_LEVEL;
         set=0;
         break;
      case 2:
         lut_name=(char *)SvPV_nolen(ST(0));
         required=(unsigned int)SvUV(ST(1));
         set=0;
         break;
      case 3:
         lut_name=(char *)SvPV_nolen(ST(0));
         required=(unsigned int)SvUV(ST(1));
         set=(unsigned int)SvUV(ST(2));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_init(lut_name[,required[,set]])");
         break;
   }

   RETVAL=lut_init(lut_name,required,set);
OUTPUT:
   RETVAL

int
kto_check_init(lut_name...)
   char *lut_name
PREINIT:
   unsigned int required;
   unsigned int set;
   unsigned int incremental;
CODE:
   switch(items){
      case 1:
         required=DEFAULT_INIT_LEVEL;
         set=0;
         incremental=0;
         break;
      case 2:
         required=(unsigned int)SvUV(ST(1));
         set=0;
         incremental=0;
         break;
      case 3:
         required=(unsigned int)SvUV(ST(1));
         set=(unsigned int)SvUV(ST(2));
         incremental=0;
         break;
      case 4:
         required=(unsigned int)SvUV(ST(1));
         set=(unsigned int)SvUV(ST(2));
         incremental=(unsigned int)SvUV(ST(3));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::kto_check_init(lut_name[,required[,set[,incremental]]])");
         break;
   }

   RETVAL=kto_check_init_p(lut_name,required,set,incremental);
OUTPUT:
   RETVAL

int
lut_keine_iban_berechnung(inputname,outputname...)
   char *inputname;
   char *outputname;
PREINIT:
   unsigned int set;
CODE:
   switch(items){
      case 2:
         set=0;
         break;
      case 3:
         set=(unsigned int)SvUV(ST(2));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_keine_iban_berechnung(inputname, outputname[, set])");
         break;
   }

	RETVAL=lut_keine_iban_berechnung(inputname,outputname,set);
OUTPUT:
   RETVAL

int
generate_lut2(inputname,outputname...)
   char *inputname;
   char *outputname;
PREINIT:
   char *user_info;
   char *gueltigkeit;
   char *keine_iban_berechnung;
   unsigned int felder;
   unsigned int filialen;
   unsigned int slots;
   unsigned int lut_version;
   unsigned int set;
CODE:
   keine_iban_berechnung=NULL;
   gueltigkeit=NULL;
   felder=-1;
   filialen=slots=lut_version=set=0;
   switch(items){
      case 2:
         user_info=NULL;
         break;
      case 3:
         user_info=(char *)SvPV_nolen(ST(2));
         break;
      case 4:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         break;
      case 5:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         break;
      case 6:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         break;
      case 7:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         break;
      case 8:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         lut_version=(unsigned int)SvUV(ST(7));
         break;
      case 9:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         lut_version=(unsigned int)SvUV(ST(7));
         set=(unsigned int)SvUV(ST(8));
         break;
      case 10:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         lut_version=(unsigned int)SvUV(ST(7));
         set=(unsigned int)SvUV(ST(8));
         keine_iban_berechnung=(char *)SvPV_nolen(ST(9));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::generate_lut2(inputname, outputname[, user_info[, gueltigkeit[, felder[, filialen[, slots[, lut_version[, set[, keine_iban_cfg]]]]]]]])");
         break;
   }

	RETVAL=generate_lut2_p(inputname,outputname,user_info,gueltigkeit,felder,filialen,slots,lut_version,set);
   if(keine_iban_berechnung)lut_keine_iban_berechnung(keine_iban_berechnung,outputname,set);
OUTPUT:
   RETVAL

int
lut_filialen_i(r,blz)
   char *blz;
   int r;
CODE:
   if(items!=2)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_filialen(blz)");
   RETVAL=lut_filialen(blz,&r);
OUTPUT:
   r
   RETVAL

int lut_multiple_i(blz,filiale...)
char *blz;
int filiale;
PREINIT:
   int cnt;
   char **p_name;
   char **p_name_kurz;
   int *p_plz;
   char **p_ort;
   int *p_pan;
   char **p_bic;
   int p_pz;
   int *p_nr;
   char *p_aenderung;
   char *p_loeschung;
   int *p_nachfolge_blz;
 CODE:
   if(items!=14)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_multiple_i(blz, filiale, cnt, "
         "name, name_kurz, plz, ort, pan, bic, pz, nr, aenderung, loeschung, nachfolge_blz)");
   RETVAL=lut_multiple(blz,&cnt,NULL,&p_name,&p_name_kurz,&p_plz,&p_ort,&p_pan,&p_bic,&p_pz,&p_nr,
         &p_aenderung,&p_loeschung,&p_nachfolge_blz,NULL,NULL,NULL);
	sv_setiv(ST(2), (IV)cnt);
	SvSETMAGIC(ST(2));
	sv_setpv((SV*)ST(3), p_name[filiale]);
	SvSETMAGIC(ST(3));
	sv_setpv((SV*)ST(4), p_name_kurz[filiale]);
	SvSETMAGIC(ST(4));
	sv_setiv(ST(5), (IV)p_plz[filiale]);
	SvSETMAGIC(ST(5));
	sv_setpv((SV*)ST(6), p_ort[filiale]);
	SvSETMAGIC(ST(6));
	sv_setiv(ST(7), (IV)p_pan[filiale]);
	SvSETMAGIC(ST(7));
	sv_setpv((SV*)ST(8), p_bic[filiale]);
	SvSETMAGIC(ST(8));
	sv_setiv(ST(9), (IV)p_pz);
	SvSETMAGIC(ST(9));
	sv_setiv(ST(10), (IV)p_nr[filiale]);
	SvSETMAGIC(ST(10));
	sv_setiv(ST(11), (IV)p_aenderung[filiale]);
	SvSETMAGIC(ST(11));
	sv_setiv(ST(12), (IV)p_loeschung[filiale]);
	SvSETMAGIC(ST(12));
	sv_setiv(ST(13), (IV)p_nachfolge_blz[filiale]);
	SvSETMAGIC(ST(13));
OUTPUT:
   RETVAL

const char *
pz2str(pz...)
   int pz;
CODE:
   int ret;
   if(items<1 || items>2)Perl_croak(aTHX_ "Usage: Business::KontoCheck::pz2str(pz[,retval])");

   RETVAL=pz2str(pz,&ret);
   if(items==2){
      sv_setiv(ST(1),(IV)ret);
      SvSETMAGIC(ST(1));
   }
OUTPUT:
   RETVAL

int
lut_blz_i(blz...)
   char *blz;
PREINIT:
   unsigned int offset;
CODE:
   if(items==1)
      offset=0;
   else if(items==2 || items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_blz(blz[,offset[,retval]])");

   RETVAL=lut_blz(blz,offset);
   if(items==3){
      sv_setiv(ST(2),(IV)RETVAL);
      SvSETMAGIC(ST(2));
   }
OUTPUT:
   RETVAL


const char *
lut_name_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_name(blz[,offset[,retval]])");

   RETVAL=lut_name(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


const char *
lut_name_kurz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_name_kurz(blz[,offset[,retval]])");

   RETVAL=lut_name_kurz(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_plz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_plz(blz[,offset[,retval]])");

   RETVAL=lut_plz(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


const char *
lut_ort_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_ort(blz[,offset[,retval]])");

   RETVAL=lut_ort(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_pan_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_pan(blz[,offset[,retval]])");

   RETVAL=lut_pan(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


const char *
lut_bic_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_bic(blz[,offset[,retval]])");

   RETVAL=lut_bic(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_pz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_pz(blz[,offset[,retval]])");

   RETVAL=lut_pz(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_aenderung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_aenderung(blz[,offset[,retval]])");

   RETVAL=lut_aenderung(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_loeschung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_loeschung(blz[,offset[,retval]])");

   RETVAL=lut_loeschung(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_nachfolge_blz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_nachfolge_blz(blz[,offset[,retval]])");

   RETVAL=lut_nachfolge_blz(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL


int
lut_iban_regel_i(r,blz...)
   char *blz;
   int r;
PREINIT:
   unsigned int offset;
CODE:
   if(items==2)
      offset=0;
   else if(items==3 || items==4)
      offset=(unsigned int)SvUV(ST(2));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_iban_regel(blz[,offset[,retval]])");

   RETVAL=lut_iban_regel(blz,offset,&r);
   if(items==4){
      sv_setiv(ST(3),(IV)r);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   r
   RETVAL

const char *
kto_check_retval2txt(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt(ret)");

   RETVAL=kto_check_retval2txt(ret);
OUTPUT:
   RETVAL



const char *
retval2txt(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt(ret)");

   RETVAL=kto_check_retval2txt(ret);
OUTPUT:
   RETVAL

const char *
kto_check_retval2iso(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2iso(ret)");

   RETVAL=kto_check_retval2iso(ret);
OUTPUT:
   RETVAL



const char *
retval2iso(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2iso(ret)");

   RETVAL=kto_check_retval2iso(ret);
OUTPUT:
   RETVAL

const char *
kto_check_retval2txt_short(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt_short(ret)");

   RETVAL=kto_check_retval2txt_short(ret);
OUTPUT:
   RETVAL



const char *
retval2txt_short(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt_short(ret)");

   RETVAL=kto_check_retval2txt_short(ret);
OUTPUT:
   RETVAL

const char *
kto_check_retval2html(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2html(ret)");

   RETVAL=kto_check_retval2html(ret);
OUTPUT:
   RETVAL



const char *
retval2html(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2html(ret)");

   RETVAL=kto_check_retval2html(ret);
OUTPUT:
   RETVAL

const char *
kto_check_retval2utf8(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2utf8(ret)");

   RETVAL=kto_check_retval2utf8(ret);
OUTPUT:
   RETVAL



const char *
retval2utf8(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2utf8(ret)");

   RETVAL=kto_check_retval2utf8(ret);
OUTPUT:
   RETVAL

const char *
kto_check_retval2dos(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2dos(ret)");

   RETVAL=kto_check_retval2dos(ret);
OUTPUT:
   RETVAL



const char *
retval2dos(ret)
   int ret;
CODE:
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2dos(ret)");

   RETVAL=kto_check_retval2dos(ret);
OUTPUT:
   RETVAL


const char *
kto_check_encoding_str(mode)
   int mode

int
kto_check_encoding(mode)
   int mode

int
keep_raw_data(mode)
   int mode

const char *
current_lutfile_name_i(want_array...)
   int want_array;
PREINIT:
   int set,level,ret;
CODE:
   if(items!=4)Perl_croak(aTHX_ "Usage: Business::KontoCheck::current_lutfile_name_i(want_array,set,level,retval)");
   if(want_array)
      RETVAL=current_lutfile_name(&set,&level,&ret);
   else
      RETVAL=current_lutfile_name(NULL,NULL,&ret);
   if(ret<0)RETVAL="";
   if(want_array){
      sv_setiv(ST(1), (IV)set);
      SvSETMAGIC(ST(1));
      sv_setiv(ST(2), (IV)level);
      SvSETMAGIC(ST(2));
      sv_setiv(ST(3), (IV)ret);
      SvSETMAGIC(ST(3));
   }
OUTPUT:
   RETVAL


int
lut_info_i(lut_name...)
   char *lut_name;
PREINIT:
   char *info1,*info2,*dptr;
   int valid1,valid2,want_array,ret;
CODE:
   want_array=(int)SvIV(ST(1));
   if(items!=7)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_info_i(lut_name,want_array,info1,valid1,info2,valid2,lut_dir)");
   if(want_array<0)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_info(lut_name)");
   if(want_array){
       ret=lut_info(lut_name,&info1,&info2,&valid1,&valid2);
       lut_dir_dump_str(lut_name,&dptr);
       if(!info1)info1="";
       if(!info2)info2="";
   }
   else{
      ret=lut_info(lut_name,NULL,NULL,&valid1,&valid2);
      dptr=info1=info2="";
   }
   if(ret<OK)
   	RETVAL=ret;
   else if(valid1==LUT2_VALID || valid2==LUT2_VALID)
   	RETVAL=LUT2_VALID;
   else if(valid1==LUT1_SET_LOADED)
   	RETVAL=LUT1_SET_LOADED;
   else if(valid1==LUT2_NO_VALID_DATE || valid2==LUT2_NO_VALID_DATE)
   	RETVAL=LUT2_NO_VALID_DATE;
   else
   	RETVAL=LUT2_INVALID;

 	sv_setpv((SV*)ST(2), info1);
 	SvSETMAGIC(ST(2));
 	sv_setiv(ST(3), (IV)valid1);
 	SvSETMAGIC(ST(3));
 	sv_setpv((SV*)ST(4), info2);
 	SvSETMAGIC(ST(4));
 	sv_setiv(ST(5), (IV)valid2);
 	SvSETMAGIC(ST(5));
 	sv_setpv((SV*)ST(6),dptr);
 	SvSETMAGIC(ST(6));

 	if(want_array){
         /* der Speicher von info1, info2 und dptr mu� wieder freigegeben
          * werden. Dazu kann allerdings nicht einfach free() benutzt werden,
          * da das von strawberry perl auf die Perl-Version umdefiniert wird
          * und dann zu einem Absturz f�hrt. kc_free() ist in konto_check.c
          * definiert und ruft dort einfach free() auf.
          */
       if(*info1)kc_free(info1);
       if(*info2)kc_free(info2);
       if(*dptr)kc_free(dptr);
   }
OUTPUT:
   RETVAL

int
generate_lut(inputname,outputname,user_info,lut_version)
   char *inputname;
   char *outputname;
   char *user_info;
   unsigned int lut_version;

int
copy_lutfile(old_name,new_name,new_slots)
   char *old_name;
   char *new_name;
   int new_slots

int
iban_check(iban...)
   char *iban;
PREINIT:
   int *ret,r;
CODE:
   switch(items){
      case 1:
         ret=NULL;
         break;
      case 2:
         ret=&r;
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::iban_check(iban[,ret])");
         break;
   }
   RETVAL=iban_check(iban,ret);
   if(ret){
      sv_setiv(ST(1),(IV)r);
      SvSETMAGIC(ST(1));
   }
OUTPUT:
   RETVAL

int
iban_gen_i(blz,kto...)
   char *blz;
   char *kto;
PREINIT:
   char *ptr,*dptr,*papier,iban[24],blz2[16],kto2[16];
   const char *bic;
   int regel,ret;
#if PERL_IBAN_DBG>0 && DEBUG>0
   RETVAL rv;
#endif
CODE:
   if(items!=9){
      Perl_croak(aTHX_ "Business::KontoCheck::iban_gen_i() requires 9 arguments, %d are given",(int)items);
      RETVAL=0;
   }
   else{
      papier=iban_bic_gen(blz,kto,&bic,blz2,kto2,&ret);
      if(papier){
         for(ptr=papier,dptr=iban;*ptr;ptr++)if(*ptr!=' ')*dptr++=*ptr;
         *dptr=0;
         sv_setpv((SV*)ST(2),iban);
         SvSETMAGIC(ST(2));
         sv_setpv((SV*)ST(3),papier);
         SvSETMAGIC(ST(3));
         kc_free(papier);
      }
      if(bic){
         sv_setpv((SV*)ST(4),bic);
         SvSETMAGIC(ST(4));
      }
      regel=lut_iban_regel(blz,0,NULL);
      sv_setiv(ST(5),regel);
      SvSETMAGIC(ST(5));
#if PERL_IBAN_DBG>0 && DEBUG>0
      kto_check_blz_dbg(blz,kto,&rv);
      sv_setpv((SV*)ST(6),rv.methode);
#else
      sv_setpv((SV*)ST(6),"no debug version");
#endif
      SvSETMAGIC(ST(6));
      sv_setpv((SV*)ST(7),blz2);
      SvSETMAGIC(ST(7));
      sv_setpv((SV*)ST(8),kto2);
      SvSETMAGIC(ST(8));
      RETVAL=ret;
   }
OUTPUT:
   RETVAL

int
ipi_check(zweck)
   char *zweck;

int 
ipi_gen_i(zweck...)
   char *zweck;
PREINIT:
   char ipi_buffer[24],ipi_papier[32];
CODE:
   if(items<1 || items>3)Perl_croak(aTHX_ "Usage: Business::KontoCheck::ipi_gen(zweck[,zweck_edv[,zweck_papier]])");
   RETVAL=ipi_gen(zweck,ipi_buffer,ipi_papier);
   if(items>=2){
      sv_setpv((SV*)ST(1),ipi_buffer);
      SvSETMAGIC(ST(1));
   }
   if(items==3){
      sv_setpv((SV*)ST(2),ipi_papier);
      SvSETMAGIC(ST(2));
   }
OUTPUT:
   RETVAL

void
lut_suche_volltext_i(want_array,search...)
   int want_array;
   char *search;
PREINIT:
   char **base_name;
   int i,ret,anzahl,anzahl_name,start_name_idx,*start_idx,*zw,*bb;
   int sort,uniq,anzahl2,*idx_o,*cnt_o;
   AV *zweigstelle,*blz_array,*vals,*cnt_array;
   SV *zweigstelle_p,*blz_array_p,*vals_p,*cnt_array_p;
PPCODE:
   if(items<2 || items>5)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_volltext(suchworte[,retval[,uniq[,sort]]])");
   ret=lut_suche_volltext(search,&anzahl_name,&start_name_idx,&base_name,&anzahl,&start_idx,&zw,&bb);
   if(items>=3){
      sv_setiv(ST(2),(IV)ret);
      SvSETMAGIC(ST(2));
   }

   sort=uniq=-1;
   if(items>=4)uniq=(int)SvIV(ST(3));
   if(items>=5)sort=(int)SvIV(ST(4));
   if(uniq>0)
      uniq=2;
   else if(uniq<=0 && sort>0)
      uniq=1;
   else if(uniq<0 && sort<0)
      uniq=UNIQ_DEFAULT_PERL;
   if(uniq) /* bei uniq>0 sortieren, uniq>1 sortieren + uniq */
      lut_suche_sort1(anzahl,bb,zw,start_idx,&anzahl2,&idx_o,&cnt_o,uniq>1);
   else{
      anzahl2=anzahl;
      idx_o=start_idx;
      cnt_o=NULL;
   }

   blz_array=newAV();
   if(anzahl2){
      /* das BLZ-Array und cnt-Array auch in ein neues Array kopieren und als Referenz zur�ckgeben */
      av_unshift(blz_array,anzahl2); /* Platz machen */
      for(i=0;i<anzahl2;i++)av_store(blz_array,i,newSViv(bb[idx_o[i]]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* die drei n�chsten Arrays werden nur bei Bedarf gef�llt */
      zweigstelle=newAV();
      vals=newAV();
      cnt_array=newAV();
      if(anzahl2){
            /* die Zweigstellen und Werte in ein neues Array kopieren, dann als Referenz zur�ckgeben */
         av_unshift(vals,anzahl_name);    /* Platz machen */
         av_unshift(zweigstelle,anzahl2);
         if(cnt_o)av_unshift(cnt_array,anzahl2);
         for(i=0;i<anzahl_name;i++)av_store(vals,i,newSVpvf("%s",base_name[start_name_idx+i]));
         for(i=0;i<anzahl2;i++){
            av_store(zweigstelle,i,newSViv(zw[idx_o[i]]));
            if(cnt_o)av_store(cnt_array,i,newSViv(cnt_o[i]));
         }
      }
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstelle)));
      vals_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)vals)));
      cnt_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)cnt_array)));
      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(vals_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XPUSHs(cnt_array_p);
      XSRETURN(5);
   }
   else{
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      XPUSHs(blz_array_p);
      XSRETURN(1);
   }

void
lut_suche_multiple_i(want_array,search...)
   int want_array;
   char *search;
PREINIT:
   char *such_cmd;
   int i,uniq,ret;
   UINT4 anzahl,*blz,*zweigstellen;
   AV *zweigstellen_array,*blz_array;
   SV *zweigstelle_p,*blz_array_p;
PPCODE:

            /* Anzahl, BLZ, Zweigstellen: nur R�ckgabeparameter */
   switch(items){
      case 2:  /* keine zus�tzlichen Parameter */
         uniq=UNIQ_DEFAULT_PERL;
         such_cmd=NULL;
         break;
      case 3:  /* nur uniq */
         uniq=SvIV(ST(2));
         such_cmd=NULL;
         break;
      case 4:
      case 5:
         uniq=SvIV(ST(2));
         such_cmd=SvPV_nolen(ST(3));
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_multiple(search_words[,uniq[,search_cmd[,ret]]])");
         break;
   }

   ret=lut_suche_multiple(search,uniq,such_cmd,&anzahl,&zweigstellen,&blz);
   if(items>4){   /* retval zur�ckgeben */
      sv_setiv(ST(4),(IV)ret);
      SvSETMAGIC(ST(4));
   }

   blz_array=newAV();
   if(anzahl){
      /* das BLZ-Array auch in ein neues Array kopieren und als Referenz zur�ckgeben */
      av_unshift(blz_array,anzahl); /* Platz machen */
      for(i=0;i<anzahl;i++)av_store(blz_array,i,newSViv(blz[i]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* das n�chste Array wird nur bei Bedarf gef�llt */
      zweigstellen_array=newAV();
      if(anzahl){
            /* die Zweigstellen in ein neues Array kopieren, dann als Referenz zur�ckgeben */
         av_unshift(zweigstellen_array,anzahl);
         for(i=0;i<anzahl;i++)av_store(zweigstellen_array,i,newSViv(zweigstellen[i]));
      }
      kc_free((char*)zweigstellen);
      kc_free((char*)blz);
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstellen_array)));
      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XSRETURN(3);
   }
   else{
      kc_free((char*)zweigstellen);
      kc_free((char*)blz);
      XPUSHs(blz_array_p);
      XSRETURN(1);
   }

void
lut_suche_c(want_array,art...)
   int want_array;
   int art;
PREINIT:
   char *search,**base_name,warn_buffer[128],*fkt;
   int i,ret,anzahl,*start_idx,*zw,*bb;
   int sort,uniq,anzahl2,*idx_o,*cnt_o;
   STRLEN len;
   AV *zweigstellen_array,*blz_array,*vals,*cnt_array;
   SV *zweigstelle_p,*blz_array_p,*vals_p,*cnt_array_p;
PPCODE:
   switch(art){
      case 1:
         fkt="bic";
         break;
      case 2:
         fkt="namen";
         break;
      case 3:
         fkt="namen_kurz";
         break;
      case 4:
         fkt="ort";
         break;
      default:
         fkt=NULL;
         break;
   }
   if(items>2 && items<7)
      search=SvPV(ST(2),len);
   else{
      if(fkt)
         snprintf(warn_buffer,128,"Usage: Business::KontoCheck::lut_suche_%s(%s[,retval[,uniq[,sort]]])",fkt,fkt);
      else
         snprintf(warn_buffer,128,"unknown internal subfunction for lut_suche_c");
      Perl_croak(aTHX_ "%s",warn_buffer);
   }
   switch(art){   /* die entsprechenden Funktionen aufrufen */
      case 1:
         ret=lut_suche_bic(search,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      case 2:
         ret=lut_suche_namen(search,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      case 3:
         ret=lut_suche_namen_kurz(search,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      case 4:
         ret=lut_suche_ort(search,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      default:
         Perl_croak(aTHX_ "unknown internal subfunction for lut_suche_c");
         break;
   }
   if(items>3){
      sv_setiv(ST(3),(IV)ret);
      SvSETMAGIC(ST(3));
   }
   uniq=sort=-1;
   if(items>4)uniq=(int)SvIV(ST(4));
   if(items>5)sort=(int)SvIV(ST(5));
   if(uniq>0)
      uniq=2;
   else if(uniq<=0 && sort>0)
      uniq=1;
   else if(uniq<0 && sort<0)
      uniq=UNIQ_DEFAULT_PERL;
   if(uniq) /* bei uniq>0 sortieren, uniq>1 sortieren + uniq */
      lut_suche_sort1(anzahl,bb,zw,start_idx,&anzahl2,&idx_o,&cnt_o,uniq>1);
   else{
      anzahl2=anzahl;
      idx_o=start_idx;
      cnt_o=NULL;
   }
   blz_array=newAV();
   if(anzahl2){
         /* das BLZ-Array auch in ein neues Array kopieren und als Referenz zur�ckgeben */
      av_unshift(blz_array,anzahl2); /* Platz machen */
      for(i=0;i<anzahl2;i++)av_store(blz_array,i,newSViv(bb[idx_o[i]]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* die drei n�chsten Arrays werden nur bei Bedarf gef�llt */
      zweigstellen_array=newAV();
      vals=newAV();
      cnt_array=newAV();
      if(anzahl2){
            /* die Zweigstellen und Werte in ein neues Array kopieren, dann als Referenz zur�ckgeben */
         av_unshift(zweigstellen_array,anzahl2);
         av_unshift(vals,anzahl2);
         if(cnt_o)av_unshift(cnt_array,anzahl2);
         for(i=0;i<anzahl2;i++){
            av_store(zweigstellen_array,i,newSViv(zw[idx_o[i]]));
            av_store(vals,i,newSVpvf("%s",base_name[idx_o[i]]));
            if(cnt_o)av_store(cnt_array,i,newSViv(cnt_o[i]));
         }
      }
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstellen_array)));
      vals_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)vals)));
      cnt_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)cnt_array)));
      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(vals_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XPUSHs(cnt_array_p);
      XSRETURN(5);
   }
   else{
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      XPUSHs(blz_array_p);
      XSRETURN(1);
   }

void
lut_suche_i(want_array,art...)
   int want_array;
   int art;
PREINIT:
   int search1;
   int search2;
   int i,ret,anzahl,*start_idx,*base_name,*zw,*bb;
   int sort,uniq,anzahl2,*idx_o,*cnt_o;
   AV *zweigstellen_array,*blz_array,*vals,*cnt_array;
   SV *zweigstelle_p,*blz_array_p,*vals_p,*cnt_array_p;
PPCODE:
   sort=uniq=-1;
   switch(items){
      case 3:
         search1=search2=(int)SvIV(ST(2));
         break;
      case 7:  /* alle Parameter mit uniq und sort angegeben */
         sort=(int)SvIV(ST(6));
      case 6:  /* nur uniq angegeben, kein sort */
         uniq=(int)SvIV(ST(5));
      case 4:  /* Angabe von search1 und search2; ret, uniq und sort weggelassen */
      case 5:  /* search1, search2 und ret angegeben */
         search1=(int)SvIV(ST(2));
         search2=(int)SvIV(ST(3));
         break;
      default:
         switch(art){
            case 1:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_blz(blz1[,blz2[,retval[,uniq[,sort]]]])");
               break;
            case 2:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_pz(pz1[,pz2[,retval[,uniq[,sort]]]])");
               break;
            case 3:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_plz(plz1[,plz2[,retval[,uniq[,sort]]]])");
               break;
            default:
               Perl_croak(aTHX_ "unknown internal subfunction for lut_suche_i");
               break;
         }
         break;
   }
   switch(art){   /* die entsprechenden Funktionen aufrufen */
      case 1:
         ret=lut_suche_blz(search1,search2,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      case 2:
         ret=lut_suche_pz(search1,search2,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      case 3:
         ret=lut_suche_plz(search1,search2,&anzahl,&start_idx,&zw,&base_name,&bb);
         break;
      default:
         Perl_croak(aTHX_ "unknown internal subfunction for lut_suche_i");
         break;
   }

   if(uniq>0)
      uniq=2;
   else if(uniq<=0 && sort>0)
      uniq=1;
   else if(uniq<0 && sort<0)
      uniq=UNIQ_DEFAULT_PERL;
   if(uniq) /* bei uniq>0 sortieren, uniq>1 sortieren + uniq */
      lut_suche_sort1(anzahl,bb,zw,start_idx,&anzahl2,&idx_o,&cnt_o,uniq>1);
   else{
      anzahl2=anzahl;
      idx_o=start_idx;
      cnt_o=NULL;
   }
   if(items>=5){
      sv_setiv(ST(4),(IV)ret);
      SvSETMAGIC(ST(4));
   }

   blz_array=newAV();
   if(anzahl2){
         /* das BLZ-Array auch in ein neues Array kopieren und als Referenz zur�ckgeben */
      av_unshift(blz_array,anzahl2); /* Platz machen */
      for(i=0;i<anzahl2;i++)av_store(blz_array,i,newSViv(bb[idx_o[i]]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* die drei n�chsten Arrays werden nur bei Bedarf gef�llt */
      zweigstellen_array=newAV();
      vals=newAV();
      cnt_array=newAV();
      if(anzahl2){
            /* die Zweigstellen und Werte in ein neues Array kopieren, dann als Referenz zur�ckgeben */
         av_unshift(zweigstellen_array,anzahl2);
         av_unshift(vals,anzahl2);
         if(cnt_o)av_unshift(cnt_array,anzahl2);
         for(i=0;i<anzahl2;i++){
            av_store(zweigstellen_array,i,newSViv(zw[idx_o[i]]));
            av_store(vals,i,newSViv(base_name[idx_o[i]]));
            if(cnt_o)av_store(cnt_array,i,newSViv(cnt_o[i]));
         }
      }
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstellen_array)));
      vals_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)vals)));
      cnt_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)cnt_array)));

      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(vals_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XPUSHs(cnt_array_p);
      XSRETURN(5);
   }
   else{
      if(uniq){
         kc_free((char*)idx_o);
         kc_free((char*)cnt_o);
      }
      XPUSHs(blz_array_p);
      XSRETURN(1);
   }

int
kto_check_at(blz,kto,lut_name)
   char *blz;
   char *kto;
   char *lut_name;

char *
kto_check_at_str(blz,kto,lut_name)
   char *blz;
   char *kto;
   char *lut_name;

int
generate_lut_at(inputname,outputname...)
   char *inputname;
   char *outputname;
PREINIT:
   char *plain_name;
   char *plain_format;
CODE:
   if(items==2){
      plain_name=NULL;
      plain_format=NULL;
   }
   else if(items==3){
      plain_name=(char *)SvPV_nolen(ST(2));
      plain_format=NULL;
   }
   else if(items==4){
      plain_name=(char *)SvPV_nolen(ST(2));
      plain_format=(char *)SvPV_nolen(ST(3));
   }
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::generate_lut_at(inputname,outputname[,plain_name[,plain_format]])");
   RETVAL=generate_lut_at(inputname,outputname,plain_name,plain_format);
OUTPUT:
   RETVAL

