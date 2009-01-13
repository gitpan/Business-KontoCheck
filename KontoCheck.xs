#line 64 "KontoCheck.lx"
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
#line 94 "KontoCheck.lx"
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
dump_lutfile(outputname,felder)
   char *outputname;
   int felder;
CODE:
#line 132 "KontoCheck.lx"
   RETVAL=dump_lutfile_p(outputname,felder);
OUTPUT:
   RETVAL

int
kto_check_pz(pz,kto...)
   char *pz;
   char *kto;
PREINIT:
#line 141 "KontoCheck.lx"
   char *blz;
CODE:
#line 143 "KontoCheck.lx"
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
#line 167 "KontoCheck.lx"
   char *lut_name;
   unsigned int required;
   unsigned int set;
CODE:
#line 171 "KontoCheck.lx"
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
#line 205 "KontoCheck.lx"
   unsigned int required;
   unsigned int set;
   unsigned int incremental;
CODE:
#line 209 "KontoCheck.lx"
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
#line 244 "KontoCheck.lx"
   char *user_info;
   char *gueltigkeit;
   unsigned int felder;
   unsigned int filialen;
   unsigned int slots;
   unsigned int lut_version;
   unsigned int set;
CODE:
#line 252 "KontoCheck.lx"
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
#line 339 "KontoCheck.lx"
   if(items!=2)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_filialen(blz)");
   RETVAL=lut_filialen(blz,&r);
OUTPUT:
   r
   RETVAL

int lut_multiple_i(blz,filiale...)
char *blz;
int filiale;
PREINIT:
#line 349 "KontoCheck.lx"
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
#line 362 "KontoCheck.lx"
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

#line 371 "KontoCheck.lx"

char *
lut_name_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 378 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 381 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_name(blz[,offset])");

   RETVAL=lut_name(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 372 "KontoCheck.lx"

char *
lut_name_kurz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 379 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 382 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_name_kurz(blz[,offset])");

   RETVAL=lut_name_kurz(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 373 "KontoCheck.lx"

int
lut_plz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 380 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 383 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_plz(blz[,offset])");

   RETVAL=lut_plz(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 374 "KontoCheck.lx"

char *
lut_ort_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 381 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 384 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_ort(blz[,offset])");

   RETVAL=lut_ort(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 375 "KontoCheck.lx"

int
lut_pan_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 382 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 385 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_pan(blz[,offset])");

   RETVAL=lut_pan(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 376 "KontoCheck.lx"

char *
lut_bic_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 383 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 386 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_bic(blz[,offset])");

   RETVAL=lut_bic(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 377 "KontoCheck.lx"

int
lut_pz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 384 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 387 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_pz(blz[,offset])");

   RETVAL=lut_pz(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 378 "KontoCheck.lx"

int
lut_aenderung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 385 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 388 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_aenderung(blz[,offset])");

   RETVAL=lut_aenderung(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 379 "KontoCheck.lx"

int
lut_loeschung_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 386 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 389 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_loeschung(blz[,offset])");

   RETVAL=lut_loeschung(blz,offset,&r);
OUTPUT:
   r
   RETVAL

#line 380 "KontoCheck.lx"

int
lut_nachfolge_blz_i(r,blz...)
   char *blz;
   int r;
PREINIT:
#line 387 "KontoCheck.lx"
   unsigned int offset;
CODE:
#line 390 "KontoCheck.lx"
   if(items==2)
      offset=0;
   else if(items==3)
      offset=(unsigned int)SvUV(ST(1));
   else
      Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_nachfolge_blz(blz[,offset])");

   RETVAL=lut_nachfolge_blz(blz,offset,&r);
OUTPUT:
   r
   RETVAL

char *
kto_check_retval2txt(ret)
   int ret;

char *
kto_check_retval2txt_short(ret)
   int ret;

char *
kto_check_retval2html(ret)
   int ret;

char *
kto_check_retval2utf8(ret)
   int ret;

char *
kto_check_retval2dos(ret)
   int ret;


int
lut_info_i(lut_name...)
   char *lut_name;
PREINIT:
#line 413 "KontoCheck.lx"
   char *info1,*info2;
   int valid1,valid2,want_array,ret;
CODE:
#line 416 "KontoCheck.lx"
   want_array=(int)SvIV(ST(1));
   if(items!=6)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_info_i(lut_name,want_array,info1,valid1,info2,valid2)");
   if(want_array<0)Perl_croak(aTHX_ "Usage: Business::KontoCheck::lut_info(lut_name)");
   if(want_array){
      ret=lut_info(lut_name,&info1,&info2,&valid1,&valid2);
      if(!info1)info1="";
      if(!info2)info2="";
   }
   else{
      ret=lut_info(lut_name,NULL,NULL,&valid1,&valid2);
      info1=info2="";
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
	if(want_array){   /* der Speicher von info1 und info2 muß wieder freigegeben werden */
      if(*info1)free(info1);
      if(*info2)free(info2);
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
#line 558 "KontoCheck.lx"
   char *plain_name;
   char *plain_format;
CODE:
#line 561 "KontoCheck.lx"
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

