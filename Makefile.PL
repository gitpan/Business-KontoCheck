use 5.006000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Business::KontoCheck',
    VERSION_FROM      => 'lib/Business/KontoCheck.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Business/KontoCheck.pm', # retrieve abstract from module
       AUTHOR         => 'Michael Plugge <m.plugge@hs-mannheim.de>') : ()),
    LIBS              => ['-lz'], # e.g., '-lm'
# edit the following line if you need support only for german or austrian account numbers
# (default is to add both packages)
    DEFINE            => '-DINCLUDE_KONTO_CHECK_AT=1 -DINCLUDE_KONTO_CHECK_DE=1 -Wno-parentheses -Wno-uninitialized',
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
    OBJECT            => '$(O_FILES)', # link all the C files too

# the following dependencies are for my private build tool lx2l (a little esoteric ;-) )
#    depend            => {'konto_check-cfg.lx' => "konto_check-cfg.lxx\n\tlx2l -x \$<",
#                          'lib/Business/KontoCheck.pm' => "pm.lxx konto_check-cfg.lx\n\tlx2l -x \$<",
#                          'konto_check.h'    => "konto_check_h.lx konto_check-cfg.lx\n\tlx2l \$<",
#                          'konto_check.c'    => "konto_check.lx konto_check-cfg.lx\n\tlx2l \$<",
#                          'konto_check-at.c' => "konto_check-at.lxx konto_check-cfg.lx\n\tlx2l -x \$<",
#                          'konto_check-at.h' => "konto_check-at.lxx konto_check-cfg.lx\n\tlx2l -x \$< -uh",
#                          'KontoCheck.xs'    => "KontoCheck.lx konto_check-cfg.lx\n\tlx2l \$<"
#                         }

);
