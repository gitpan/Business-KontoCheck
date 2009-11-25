use 5.006000;
use ExtUtils::MakeMaker;

# Configuration part

$use_german   = 1;
$use_austrian = 1;
$use_lx2l     = 0;
$zlib         = "zlib";

# first check, if the zlib development package is available. On serveral systems
# this library was missing, resulting in a fail for automated smoke tests of CPAN testers.

print "Check zlib development package... ";
open(OUT,"> test_zlib.c") or die "can't open test_zlib.c";
print OUT <<EOD
#include <stdio.h>
#include <string.h>
#include <zlib.h>

int main(int argc,char **argv)
{
   unsigned char buffer1[1024],buffer2[1024];
   unsigned char *ptr="hello world, hello world, hello world, hello world, hello world, hello world, "
      "hello world, hello world, hello world, hello world, hello world, hello world, "
      "hello world, hello world, hello world, hello world, hello world, hello world, "
      "hello world, hello world, hello world, hello world, hello world, hello world";
   unsigned long len,len1,len2,retval;

   len=strlen(ptr);
   len1=len2=1024;
   retval=compress2(buffer2,&len2,ptr,len,9);
   printf("compressed: %d -> %d byte\\n",len,len2);
   retval=uncompress(buffer1,&len1,buffer2,len2);
   printf("uncompressed: %d -> %d byte; check: %d\\n",len2,len1,strcmp(buffer1,ptr));
   return strcmp(ptr,buffer1);
}
EOD
;
close(OUT);

$retval=system("make dynamic -f makefile.zlib 2> /dev/null");
if($retval){$retval=system("make dynamic -f makefile.zlib-gcc 2> /dev/null");}
if($retval){$retval=system("make dynamic -f makefile.zlib-icc 2> /dev/null");}
if($retval){   # zlib.h not found, or linking failed
   print "not found\ntry to build a static version of the zlib library\n";
   $retval=system("make static -f makefile.zlib 2> /dev/null");
   if($retval){$retval=system("make static -f makefile.zlib-gcc 2> /dev/null");}
   if($retval){$retval=system("make static -f makefile.zlib-icc 2> /dev/null");}
   if(!$retval){  # build of static library successfull
      $zlib_dir=" -I$zlib";
      $zlib_version="static";
   }
   else{ # build of static library failed; exit with error message
      print "\nThis package requires the zlib development package; the package was\n"
         . "not found on this system, and I was not able to build a static version.\n"
         . "Please install this package first and then try again.\n\n"
			. "Proceed, with fingers crossed...\n";
#      exit(1);
		$zlib_dir="";
		$zlib_version="dynamic";
   }
}
else{
   $zlib_dir="";
   $zlib_version="dynamic";
	print "looks good\n";
}

unlink("test_zlib.c");
unlink("test_zlib");
print "use $zlib_version version of zlib\n";

$define="";

if($use_austrian){
   $define.=" -DINCLUDE_KONTO_CHECK_AT=1 ";
}
else{
   $define.=" -DINCLUDE_KONTO_CHECK_AT=0";
}

if($use_german){
   $define.=" -DINCLUDE_KONTO_CHECK_DE=1";
}
else{
   $define.=" -DINCLUDE_KONTO_CHECK_DE=0";
}

WriteMakefile(
    NAME              => 'Business::KontoCheck',
    VERSION_FROM      => 'lib/Business/KontoCheck.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Business/KontoCheck.pm', # retrieve abstract from module
       AUTHOR         => 'Michael Plugge <m.plugge@hs-mannheim.de>') : ()),
    LIBS              => ['-L.','-lz'],
    LDFLAGS           => '-L.',
    DEFINE            => $define,
    INC               => "-I.$zlib_dir", # e.g., '-I. -I/usr/include/other'
    OBJECT            => '$(O_FILES)', # link all the C files too
    COMPRESS          => 'gzip --best --force', 
    NO_META           => 1,				# META.yml is manually generated

# the following dependencies are for my private build tool lx2l (a little esoteric ;-) )
    ($use_lx2l==1 ?
    (depend            => {'konto_check-cfg.lx' => "konto_check-cfg.lxx\n\tlx2l -x \$<",
                          'lib/Business/KontoCheck.pm' => "pm.lxx konto_check-cfg.lx\n\tlx2l -x \$<",
                          'META.yml'    			=> "META.lx konto_check-cfg.lx\n\tlx2l \$<",
                          'konto_check.h'    	=> "konto_check_h.lx konto_check-cfg.lx\n\tlx2l \$<",
                          'konto_check.c'    	=> "konto_check.lxx konto_check-cfg.lx lib/Business/KontoCheck.pm\n\tlx2l -x \$< -ua1",
                          'konto_check-at.c' 	=> "konto_check-at.lxx konto_check-cfg.lx\n\tlx2l -x \$<",
                          'konto_check-at.h' 	=> "konto_check-at.lxx konto_check-cfg.lx\n\tlx2l -x \$< -uh",
                          'KontoCheck.xs'    	=> "KontoCheck.lx lib/Business/KontoCheck.pm konto_check-cfg.lx\n\tlx2l \$<",
                          'Makefile.PL'      	=> "makefile.lx lib/Business/KontoCheck.pm makefile.zlib makefile.zlib-gcc makefile.zlib-icc konto_check-cfg.lx\n\tlx2l \$< -um",
                          'makefile.zlib'    	=> "makefile.lx lib/Business/KontoCheck.pm konto_check-cfg.lx\n\tlx2l \$< -um1",
                          'makefile.zlib-gcc'   => "makefile.lx lib/Business/KontoCheck.pm konto_check-cfg.lx\n\tlx2l \$< -um2",
                          'makefile.zlib-icc'   => "makefile.lx lib/Business/KontoCheck.pm konto_check-cfg.lx\n\tlx2l \$< -um3"
                         })
                         :())

);
