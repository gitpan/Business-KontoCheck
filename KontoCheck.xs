#line 81 "KontoCheck.lx"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "konto_check.h"
#include "konto_check-at.h"

#if 0

/* Global Data (in the current version not used; perhaps later) */

#define MY_CXT_KEY "Business::KontoCheck::_guts" XS_VERSION

typedef struct {
    /* Put Global Data in here */
    int dummy;		/* you can access this elsewhere as MY_CXT.dummy */
} my_cxt_t;

START_MY_CXT

#endif

MODULE = Business::KontoCheck		PACKAGE = Business::KontoCheck		


#if 0

BOOT:
#line 111 "KontoCheck.lx"
{
    MY_CXT_INIT;
    /* If any of the fields in the my_cxt_t struct need
       to be initialised, do it here.
     */
}

#endif

PROTOTYPES: ENABLE

# Aufrufe der konto_check Bibliothek
int
kto_check(pz_or_blz,kto,lut_name)
   char *pz_or_blz;
   char *kto;
   char *lut_name;

char *
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
#line 153 "KontoCheck.lx"
   RETVAL=dump_lutfile_p(outputname,felder);
OUTPUT:
   RETVAL

int
kto_check_pz(pz,kto...)
   char *pz;
   char *kto;
PREINIT:
#line 162 "KontoCheck.lx"
   char *blz;
CODE:
#line 164 "KontoCheck.lx"
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
#line 188 "KontoCheck.lx"
   char *lut_name;
   unsigned int required;
   unsigned int set;
CODE:
#line 192 "KontoCheck.lx"
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
#line 226 "KontoCheck.lx"
   unsigned int required;
   unsigned int set;
   unsigned int incremental;
CODE:
#line 230 "KontoCheck.lx"
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
generate_lut2(inputname,outputname...)
   char *inputname;
   char *outputname;
PREINIT:
#line 265 "KontoCheck.lx"
   char *user_info;
   char *gueltigkeit;
   unsigned int felder;
   unsigned int filialen;
   unsigned int slots;
   unsigned int lut_version;
   unsigned int set;
CODE:
#line 273 "KontoCheck.lx"
   switch(items){
      case 2:
         user_info=NULL;
         gueltigkeit=NULL;
         felder=0;
         filialen=0;
         slots=0;
         lut_version=0;
         set=0;
         break;
      case 3:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=NULL;
         felder=0;
         filialen=0;
         slots=0;
         lut_version=0;
         set=0;
         break;
      case 4:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=0;
         filialen=0;
         slots=0;
         lut_version=0;
         set=0;
         break;
      case 5:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=0;
         slots=0;
         lut_version=0;
         set=0;
         break;
      case 6:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=0;
         lut_version=0;
         set=0;
         break;
      case 7:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         lut_version=0;
         set=0;
         break;
      case 8:
         user_info=(char *)SvPV_nolen(ST(2));
         gueltigkeit=(char *)SvPV_nolen(ST(3));
         felder=(unsigned int)SvUV(ST(4));
         filialen=(unsigned int)SvUV(ST(5));
         slots=(unsigned int)SvUV(ST(6));
         lut_version=(unsigned int)SvUV(ST(7));
         set=0;
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
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::generate_lut2(inputname, outputname[, user_info[, gueltigkeit[, felder[, filialen[, slots[, lut_version[, set]]]]]]])");
         break;
   }

	RETVAL=generate_lut2_p(inputname,outputname,user_info,gueltigkeit,felder,filialen,slots,lut_version,set);
OUTPUT:
   RETVAL

int
lut_filialen_i(r,blz)
   char *blz;
   int r;
CODE:
#line 360 "KontoCheck.lx"
   if(items!=2)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_filialen(blz)");
   RETVAL=lut_filialen(blz,&r);
OUTPUT:
   r
   RETVAL

int lut_multiple_i(blz,filiale...)
char *blz;
int filiale;
PREINIT:
#line 370 "KontoCheck.lx"
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
#line 383 "KontoCheck.lx"
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

#line 415 "KontoCheck.lx"
char *
pz2str(pz...)
   int pz;
CODE:
   int ret;
#line 422 "KontoCheck.lx"
   if(items<1 || items>2)Perl_croak(aTHX_ "Usage: Business::KontoCheck::pz2str(pz[,retval])");

   RETVAL=pz2str(pz,&ret);
   if(items==2){
      sv_setiv(ST(1),(IV)ret);
      SvSETMAGIC(ST(1));
   }
OUTPUT:
   RETVAL

#line 433 "KontoCheck.lx"
int
lut_blz_i(blz...)
   char *blz;
PREINIT:
#line 439 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 442 "KontoCheck.lx"
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

#line 431 "KontoCheck.lx"

char *
lut_name_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 438 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 441 "KontoCheck.lx"
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

#line 432 "KontoCheck.lx"

char *
lut_name_kurz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 439 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 442 "KontoCheck.lx"
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

#line 433 "KontoCheck.lx"

int
lut_plz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 440 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 443 "KontoCheck.lx"
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

#line 434 "KontoCheck.lx"

char *
lut_ort_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 441 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 444 "KontoCheck.lx"
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

#line 435 "KontoCheck.lx"

int
lut_pan_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 442 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 445 "KontoCheck.lx"
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

#line 436 "KontoCheck.lx"

char *
lut_bic_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 443 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 446 "KontoCheck.lx"
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

#line 437 "KontoCheck.lx"

int
lut_pz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 444 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 447 "KontoCheck.lx"
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

#line 438 "KontoCheck.lx"

int
lut_aenderung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 445 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 448 "KontoCheck.lx"
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

#line 439 "KontoCheck.lx"

int
lut_loeschung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 446 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 449 "KontoCheck.lx"
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

#line 440 "KontoCheck.lx"

int
lut_nachfolge_blz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 447 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 450 "KontoCheck.lx"
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

char *
kto_check_retval2txt(ret)
   int ret;

#line 455 "KontoCheck.lx"

char *
retval2txt(ret)
   int ret;
CODE:
#line 461 "KontoCheck.lx"
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt(ret)");

   RETVAL=kto_check_retval2txt(ret);
OUTPUT:
   RETVAL

char *
kto_check_retval2txt_short(ret)
   int ret;

#line 456 "KontoCheck.lx"

char *
retval2txt_short(ret)
   int ret;
CODE:
#line 462 "KontoCheck.lx"
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2txt_short(ret)");

   RETVAL=kto_check_retval2txt_short(ret);
OUTPUT:
   RETVAL

char *
kto_check_retval2html(ret)
   int ret;

#line 457 "KontoCheck.lx"

char *
retval2html(ret)
   int ret;
CODE:
#line 463 "KontoCheck.lx"
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2html(ret)");

   RETVAL=kto_check_retval2html(ret);
OUTPUT:
   RETVAL

char *
kto_check_retval2utf8(ret)
   int ret;

#line 458 "KontoCheck.lx"

char *
retval2utf8(ret)
   int ret;
CODE:
#line 464 "KontoCheck.lx"
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2utf8(ret)");

   RETVAL=kto_check_retval2utf8(ret);
OUTPUT:
   RETVAL

char *
kto_check_retval2dos(ret)
   int ret;

#line 459 "KontoCheck.lx"

char *
retval2dos(ret)
   int ret;
CODE:
#line 465 "KontoCheck.lx"
   if(items!=1)Perl_croak(aTHX_ "Usage: Business::KontoCheck::retval2dos(ret)");

   RETVAL=kto_check_retval2dos(ret);
OUTPUT:
   RETVAL


int
lut_info_i(lut_name...)
   char *lut_name;
PREINIT:
#line 477 "KontoCheck.lx"
   char *info1,*info2,*dptr;
   int valid1,valid2,want_array,ret;
CODE:
#line 480 "KontoCheck.lx"
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
         /* der Speicher von info1, info2 und dptr muß wieder freigegeben
          * werden. Dazu kann allerdings nicht einfach free() benutzt werden,
          * da das von strawberry perl auf die Perl-Version umdefiniert wird
          * und dann zu einem Absturz führt. kc_free() ist in konto_check.c
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

char *
iban_gen(blz,kto...)
   char *blz;
   char *kto;
PREINIT:
   int *ret,r;
CODE:
   switch(items){
      case 2:
         ret=NULL;
         break;
      case 3:
         ret=&r;
         break;
      default:
         Perl_croak(aTHX_ "Usage: Business::KontoCheck::iban_gen(blz,kto[,ret])");
         break;
   }
   RETVAL=iban_gen(blz,kto,ret);
   if(ret){
      sv_setiv(ST(2),(IV)r);
      SvSETMAGIC(ST(2));
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
lut_suche_c(want_array,art...)
   int want_array;
   int art;
PREINIT:
#line 621 "KontoCheck.lx"
   char *search,**base_name,warn_buffer[128],*fkt;
   int i,ret,anzahl,*start_idx,*zw,*bb;
   STRLEN len;
   AV *zweigstelle,*blz_array,*vals;
   SV *zweigstelle_p,*blz_array_p,*vals_p;
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
   switch(items){
      case 3:
      case 4:
         search=SvPV(ST(2),len);
         break;
      default:
         if(fkt)
            snprintf(warn_buffer,128,"Usage: Business::KontoCheck::lut_suche_%s(%s[,retval])",fkt,fkt);
         else
            snprintf(warn_buffer,128,"unknown internal subfunction for lut_suche_c");
         Perl_croak(aTHX_ warn_buffer);
         break;
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
   if(items>=4){
      sv_setiv(ST(3),(IV)ret);
      SvSETMAGIC(ST(3));
   }

   blz_array=newAV();
   if(anzahl){
      /* das BLZ-Array auch in ein neues Array kopieren und als Referenz zurückgeben */
      av_unshift(blz_array,anzahl); /* Platz machen */
      for(i=0;i<anzahl;i++)av_store(blz_array,i,newSViv(bb[start_idx[i]]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* die beiden nächsten Arrays werden nur bei Bedarf gefüllt */
      zweigstelle=newAV();
      vals=newAV();
      if(anzahl){
            /* die Zweigstellen und Werte in ein neues Array kopieren, dann als Referenz zurückgeben */
         av_unshift(zweigstelle,anzahl);
         av_unshift(vals,anzahl);
         for(i=0;i<anzahl;i++){
            av_store(zweigstelle,i,newSViv(zw[start_idx[i]]));
            av_store(vals,i,newSVpvf("%s",base_name[start_idx[i]]));
         }
      }
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstelle)));
      vals_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)vals)));
      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(vals_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XSRETURN(4);
   }
   else{
      XPUSHs(blz_array_p);
      XSRETURN(1);
   }

void
lut_suche_i(want_array,art...)
   int want_array;
   int art;
PREINIT:
#line 717 "KontoCheck.lx"
   int search1;
   int search2;
   int i,ret,anzahl,*start_idx,*base_name,*zw,*bb;
   AV *zweigstelle,*blz_array,*vals;
   SV *zweigstelle_p,*blz_array_p,*vals_p;
PPCODE:
   switch(items){
      case 3:
         search1=search2=(int)SvIV(ST(2));
         break;
      case 4:
      case 5:
         search1=(int)SvIV(ST(2));
         search2=(int)SvIV(ST(3));
         break;
      default:
         switch(art){
            case 1:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_blz(blz1[,blz2[,retval]])");
               break;
            case 2:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_pz(pz1[,pz2[,retval]])");
               break;
            case 3:
               Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_suche_plz(plz1[,plz2[,retval]])");
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
   if(items>=5){
      sv_setiv(ST(4),(IV)ret);
      SvSETMAGIC(ST(4));
   }

   blz_array=newAV();
   if(anzahl){
      /* das BLZ-Array auch in ein neues Array kopieren und als Referenz zurückgeben */
      av_unshift(blz_array,anzahl); /* Platz machen */
      for(i=0;i<anzahl;i++)av_store(blz_array,i,newSViv(bb[start_idx[i]]));
   }
   blz_array_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)blz_array)));

   if(want_array){   /* die beiden nächsten Arrays werden nur bei Bedarf gefüllt */
      zweigstelle=newAV();
      vals=newAV();
      if(anzahl){
            /* die Zweigstellen und Werte in ein neues Array kopieren, dann als Referenz zurückgeben */
         av_unshift(zweigstelle,anzahl);
         av_unshift(vals,anzahl);
         for(i=0;i<anzahl;i++){
            av_store(zweigstelle,i,newSViv(zw[start_idx[i]]));
            av_store(vals,i,newSViv(base_name[start_idx[i]]));
         }
      }
      zweigstelle_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)zweigstelle)));
      vals_p=sv_2mortal((SV*)newRV(sv_2mortal((SV*)vals)));

      XPUSHs(blz_array_p);
      XPUSHs(zweigstelle_p);
      XPUSHs(vals_p);
      XPUSHs(sv_2mortal(newSViv(ret)));
      XSRETURN(4);
   }
   else{
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
#line 819 "KontoCheck.lx"
   char *plain_name;
   char *plain_format;
CODE:
#line 822 "KontoCheck.lx"
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

