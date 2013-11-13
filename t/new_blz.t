# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl new_blz.t'

use Test::More tests => 447;

BEGIN { use_ok('Business::KontoCheck') };

$ok_cnt=$nok_cnt=0;
$retval=lut_init("blz.lut");
$ret_txt=$kto_retval{$retval};
if($retval>0){$ok_cnt++;}else{$nok_cnt++;}
ok($retval gt 0,"init: $retval => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");

if($retval>0){
   while(<DATA>){
      chomp;
      ($ret,$blz,$kto)=split(/ /);
      $retval=kto_check_blz($blz,$kto);
      $ret_txt=$kto_retval{$retval};
      if($retval==$ret){$ok_cnt++;}else{$nok_cnt++;}
      ok($retval eq $ret,"BLZ/KTO (neu) $blz $kto: $retval (Soll: $ret) => $ret_txt (ok: $ok_cnt, nok: $nok_cnt)");
   }
}

__DATA__
1 10010010 73245108
1 10010010 73395105
1 10010010 73395105
1 14051462 0069000000
1 16050000 4636004502
1 17052302 48074470
1 18062678 4004469
1 20040000 225050400
1 20050550 1268118377
1 20080000 620616500
1 21050170 0000239314
1 21050170 844675
1 21566356 110060
1 25010030 749044307
1 25010030 763548309
1 25010030 904278305
1 25020600 2323222881
-133 25020700 3100755555
1 25050180 19968
1 30050000 632935
1 30070010 2508000
1 32250050 236075
1 36010043 319310430
1 36010043 319310430
1 36010043 444444431
1 36080080 429090203
1 37010050 277501502
1 37010050 277501502
1 37010050 285526507
1 37010050 313753507
1 37010050 313753507
1 37010050 33323502
1 37010050 38522505
1 37010050 491830508
1 37050299 184004087
1 37060193 122122
1 37060193 19963012
1 37070024 781200100
1 38070724 143867000
1 38070724 143867000
1 40060265 3161600
1 44010046 266722467
1 44040037 366026300
1 44080050 771220000
1 45070024 210550005
1 46040033 891695900
1 46262456 102484800
1 50010060 106728602
1 50010060 283557609
1 50010060 301230605
1 50010517 782919930
1 50010517 782919930
1 50080000 710481900
1 50190000 500130598
1 50190000 500130598
1 50850150 639630
1 50950068 1440106
1 50950068 1440106
1 50951469 10324037
1 50951469 10324037
1 50951469 13116620
1 50951469 13116620
-4 50991400 4138406
-4 50991400 5004403
-4 50991400 5004403
1 51140029 3700739
1 51190000 627003
1 54050220 100984855
1 54050220 100984855
1 54051990 120006895
1 54510067 146201675
1 54510067 146201675
1 54510067 149311676
1 54510067 149311676
1 54510067 158480675
1 54510067 158480675
1 54510067 159025677
1 54510067 159025677
1 54510067 17764674
1 54510067 194067673
1 54510067 194067673
1 54510067 216914677
1 54510067 35486679
1 54510067 6432676
1 54510067 73144675
1 54510067 73144675
1 54510067 76910671
1 54510067 76910671
1 54520194 3930184682
1 54520194 3930184682
1 54540033 2068609
1 54540033 2068609
1 54550010 8856296
1 54550010 8856296
1 54550010 978700
1 54550010 978700
1 54550120 139691
1 54550120 189233
1 54550120 189233
1 54550120 1928183
1 54550120 1928183
1 54561310 815381
1 54561310 815381
1 54570024 1546019
1 54570024 1546019
1 54580020 103790000
1 54580020 103790000
1 54651240 1009510635
1 54651240 117127225
1 54651240 117127225
1 54651240 1406893014
1 54651240 1406893014
1 54651240 380105
1 54690623 105186323
1 54761411 992526
1 54761411 992526
1 54790000 20164700
1 54790000 20164700
1 54790000 350010
1 54850010 135062560
1 54850010 135302842
1 54851440 1000033165
1 54851440 20000030
1 54851440 20000444
1 54851440 26001594
1 54851440 26001594
1 54851440 26012757
1 54851440 26014035
1 54851440 26028399
1 54862500 102804026
1 54862500 45500
1 54862500 781355
1 55090500 100161711
1 55090500 100161711
1 55090500 110581974
1 55090500 204568
1 55090500 204568
1 55090500 220427
1 55090500 3360091
1 55090500 3463494
1 55090500 3695549
1 55090500 581974
1 55090500 581974
1 55090500 731516
1 55090500 731516
1 55350010 4302379
1 55350010 4302379
1 55350010 7270086
1 55350010 7270086
1 55390000 6060005
1 58570048 506071
1 58570048 506071
1 60010070 267474702
1 60010070 267474702
1 60010070 276606707
1 60010070 276606707
1 60040071 523308501
1 60040071 624080805
1 60050101 1018668
1 60050101 2247067
1 60090800 1236650
1 60090800 204862
1 60090800 204862
1 60090800 339515
1 60090800 339515
1 60350130 6554
1 64390130 11149000
1 66010075 142321756
1 66010075 321052756
1 66010075 354826753
1 66010075 354826753
1 66010075 363266753
1 66010075 363266753
1 66010075 382734759
1 66010075 382734759
1 66010075 94089759
1 66010075 94089759
1 66050101 10543361
1 66050101 10543361
1 66050101 22636104
1 66090800 1278797
1 66090800 1278797
1 66090800 1486101
1 66090800 1486101
1 66090800 1581058
1 66090800 1581058
1 66090800 2768836
1 66090800 2768836
1 66090800 3042871
1 66090800 3042871
1 66090800 3330036
1 66090800 3668657
1 66090800 4334671
1 66090800 4334671
1 66090800 4346327
1 66090800 4346327
1 66090800 5012287
1 66090800 5012287
1 67010111 2384856100
1 67010111 2384856100
1 67040031 317450500
1 67040031 317450500
1 67040031 352029300
1 67040031 352029300
1 67040031 366096600
1 67040031 366096600
1 67040031 3782323
1 67040031 3782323
1 67040031 6060065
1 67040031 6060065
-4 67050101 3136892
-4 67050101 3136892
-4 67050101 3152386
-4 67050101 3152386
-4 67050101 3245362
-4 67050101 3245362
-4 67050101 4055976
-4 67050101 4055976
-4 67050101 4199105
-4 67050101 4199105
-4 67050101 4298261
-4 67050101 4298261
-4 67050101 4298261 
-4 67050101 4704011
-4 67050101 7218381
-4 67050101 7218381
-4 67050101 7566284
-4 67050101 7566284
-4 67050101 7692700
-4 67050101 7692700
-4 67050101 7863764
-4 67050101 7863764
-4 67050101 7882665
-4 67050101 7890452
-4 67050101 7890452
-4 67050101 7951056
-4 67050101 7951056
1 67050505 33168381
1 67050505 33168381
1 67050505 34006865
1 67050505 34006865
1 67050505 34298262 
1 67050505 34704015
1 67050505 37381870
1 67050505 37381870
1 67050505 37904074
1 67050505 37904074
1 67050505 68010446
1 67050505 68010446
1 67050505 73201888
-4 67052385 15184523
-4 67052385 15184523
1 67060031 35182500
1 67070010 101063
1 67070010 101063
1 67070010 6074066
1 67070010 6074066
1 67070010 6074454
1 67070010 6074454
1 67070010 7106289
1 67070010 7106289
1 67070010 7654312
1 67070010 7654312
1 67070024 243451
1 67070024 243451
1 67070024 6200471
1 67070024 6200471
1 67070024 7849250
1 67070024 7849250
1 67080050 4701862900
1 67080050 4701862900
1 67080050 677332100
1 67080050 712615300
1 67080050 712615300
1 67080050 741259900
1 67080050 741259900
1 67080050 744499000
1 67080050 744499000
1 67090000 2310007
1 67090000 2420708
1 67090000 2420708
1 67090000 2743108
1 67090000 2743108
1 67090000 3190706
1 67090000 3190706
1 67090000 3830608
1 67090000 3830608
1 67090000 4897900
1 67090000 4897900
1 67090000 5481406
1 67090000 5481406
1 67090000 6502300
1 67090000 6502300
1 67090000 760307
1 67090000 779105
1 67090000 779105
1 67090000 8449600
1 67090000 8449600
1 67092300 31558808
1 67210111 2080918600
1 67210111 2080918600
1 67230000 4039634044
1 67250020 25123239
1 67250020 25123239
1 67250020 3510921
1 67250020 3510921
1 67250020 4318919
1 67270003 454009
1 67270003 454009
1 67292200 50767507
1 67292200 50767507
1 70010080 30042806
1 70010080 626687800
1 70054306 532713
1 70070010 852616202
1 70070024 531869601
1 70091600 5147522
1 71061009 22284
1 71152570 8737462
1 72120078 5724414
1 73150000 247247
1 74351310 616144
1 74351310 616144
1 74351310 616144
1 75090300 103002721
1 75090300 2152002
1 75090300 51799
1 75090300 58882
1 76010085 78245851
1 76026000 2702164004
1 76026000 2702164004
1 76080040 621733300
1 80053762 485065366
1 82020087 4063503
1 82020087 4063503
1 82054052 41010076
1 87096124 9072772692
1 20690500 556343
2 30020900 1607761319
2 37020500 5379552220
2 50010700 533472
2 50010700 533472
2 70020270 345661
2 70030300 1088774
2 76060000 210850
1 14051462 0071433699
1 14051462 0046996983
1 14051462 0098138585
1 14051462 0083239121
1 14051462 0017801841
1 14051462 0062117328
1 14051462 0043949698
1 14051462 0098234702
1 14051462 0097151235
1 14051462 0021306093
1 15051732 0062316937
1 15051732 0050945322
1 15051732 0074926978
1 15051732 0070921723
1 15051732 0033094628
1 15051732 0098610038
1 15051732 0010516267
1 15051732 0084530280
1 15051732 0016834215
1 15051732 0029840550
1 17052302 0069295778
1 17052302 0073355024
1 17052302 0088014264
1 17052302 0010973407
1 17052302 0090304376
1 17052302 0011781562
1 17052302 0027358945
1 17052302 0046727902
1 17052302 0062076693
1 17052302 0073160593
1 80053572 0043939385
1 80053572 0052621053
1 80053572 0048723364
1 80053572 0011294877
1 80053572 0096147488
1 80053572 0013675307
1 80053572 0062235244
1 80053572 0019704658
1 80053572 0017943233
1 80053572 0072835403
1 82054052 0052219981
1 82054052 0095627360
1 82054052 0064356764
1 82054052 0087367255
1 82054052 0027936129
1 82054052 0096978023
1 82054052 0052398174
1 82054052 0069999742
1 82054052 0094783775
1 82054052 0089769733
1 80053762 0894117043
1 80053762 0418866278
1 80053762 0780136839
1 80053762 0162098747
1 80053762 0361733017
1 80053762 0217818082
1 80053762 0950493119
1 80053762 0664777745
1 80053762 0338369533
1 80053762 0637508985
1 80053762 0356336198
1 80053762 0309534824
1 80053762 0133040659
1 80053762 0716411107
1 80053762 0663254125
1 80053762 0894508335
1 80053762 0111694222
1 80053762 0736556073
1 80053762 0725448439
1 80053762 0817853939
1 80053772 0134968507
1 80053772 0151567643
1 80053772 0619586013
1 80053772 0910902412
1 80053772 0101661098
1 80053772 0489313853
1 80053772 0967058154
1 80053772 0592637458
1 80053772 0947853960
1 80053772 0961054262
1 80053782 0447186653
1 80053782 0835587170
1 80053782 0661584649
1 80053782 0433487761
1 80053782 0863403028
1 80053782 0974627582
1 80053782 0387430796
1 80053782 0255102679
1 80053782 0529195865
1 80053782 0289152394
1 13051172 0053675915
1 13051172 0092774852
1 13051172 0096373095
1 13051172 0023034617
1 13051172 0054804790
1 13051172 0080695559
1 13051172 0049036072
1 13051172 0063886716
1 13051172 0073335037
1 13051172 0079690566
