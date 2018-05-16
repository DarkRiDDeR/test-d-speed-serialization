# test-d-speed-serialization
Benchmark of serialization methods in d language

Methods:
- std.json
- cerealed
- msgpack-d
- drmi.sbin
- Jsonizer + std.json

Intel Xeon e5-2640

OS Windows 10

DMD 2.080.0
LDC 1.9.0.


# DMD results:
  
  
===CEREALED===

book

serialize test = 35 ms, 541 s, and 3 hnsecs. Size = 20320000

deserialize test = 6 ms, 749 s, and 3 hnsecs

page cache

serialize test = 155 ms, 351 s, and 3 hnsecs. Size = 3199680000

deserialize test = 1 ms, 733 s, and 4 hnsecs

long structure

serialize test = 103 ms, 885 s, and 5 hnsecs. Size = 10480000

deserialize test = 28 ms, 565 s, and 4 hnsecs


===JSONIZER===

book

serialize test = 243 ms, 896 s, and 5 hnsecs. Size = 27680000

deserialize test = 395 ms, 887 s, and 5 hnsecs

page cache

serialize test = 24 secs, 552 ms, 290 s, and 3 hnsecs. Size = 3538720000

deserialize test = 39 secs, 557 ms, 286 s, and 2 hnsecs

long structure

serialize test = 508 ms, 511 s, and 4 hnsecs. Size = 47680000

deserialize test = 664 ms and 580 s


===MessagePack===

book

serialize test = 17 ms, 126 s, and 1 hnsec. Size = 20240000

deserialize test = 44 ms, 883 s, and 1 hnsec

page cache

serialize test = 56 ms, 830 s, and 3 hnsecs. Size = 3199920000

deserialize test = 172 ms, 461 s, and 1 hnsec

long structure

serialize test = 40 ms, 623 s, and 6 hnsecs. Size = 9280000

deserialize test = 111 ms, 743 s, and 7 hnsecs


===DRMI===

book

serialize test = 25 ms, 734 s, and 3 hnsecs. Size = 22240000

deserialize test = 128 ms, 250 s, and 1 hnsec

page cache

serialize test = 143 ms, 941 s, and 9 hnsecs. Size = 3200160000

deserialize test = 14 secs, 669 ms, 953 s, and 5 hnsecs

long structure

serialize test = 50 ms and 787 s. Size = 16240000

deserialize test = 119 ms, 182 s, and 8 hnsecs


===Json===

book

serialize test = 276 ms, 748 s, and 9 hnsecs. Size = 25200000

deserialize test = 396 ms, 121 s, and 8 hnsecs

page cache

serialize test = 24 secs, 46 ms, 474 s, and 8 hnsecs. Size = 3537680000

deserialize test = 37 secs, 574 ms, 384 s, and 9 hnsecs


# LDC results with flags -mcpu=native and -mattr=+sse4.2:

===CEREALED===

book

serialize test = 12 ms, 687 s, and 3 hnsecs. Size = 40640000

deserialize test = 2 ms, 64 s, and 7 hnsecs

page cache

serialize test = 73 ms, 74 s, and 6 hnsecs. Size = 6399360000

deserialize test = 971 s and 9 hnsecs

long structure

serialize test = 40 ms, 172 s, and 3 hnsecs. Size = 20960000

deserialize test = 15 ms, 165 s, and 8 hnsecs


===JSONIZER===

book

serialize test = 110 ms, 594 s, and 7 hnsecs. Size = 55360000

deserialize test = 191 ms, 63 s, and 1 hnsec

page cache

serialize test = 11 secs, 225 ms, 660 s, and 7 hnsecs. Size = 7077440000

deserialize test = 19 secs, 548 ms, 295 s, and 9 hnsecs

long structure

serialize test = 245 ms, 105 s, and 6 hnsecs. Size = 95360000

deserialize test = 408 ms, 406 s, and 9 hnsecs


===MessagePack===

book

serialize test = 9 ms, 673 s, and 1 hnsec. Size = 40480000

deserialize test = 16 ms, 886 s, and 9 hnsecs

page cache

serialize test = 37 ms, 37 s, and 6 hnsecs. Size = 6399840000

deserialize test = 58 ms, 599 s, and 3 hnsecs

long structure

serialize test = 21 ms, 563 s, and 3 hnsecs. Size = 18560000

deserialize test = 64 ms, 410 s, and 7 hnsecs


===DRMI===

book

serialize test = 10 ms, 740 s, and 1 hnsec. Size = 44480000

deserialize test = 73 ms and 954 s

page cache

serialize test = 71 ms, 404 s, and 6 hnsecs. Size = 6400320000

deserialize test = 9 secs, 646 ms, 396 s, and 2 hnsecs

long structure

serialize test = 24 ms, 38 s, and 5 hnsecs. Size = 32480000

deserialize test = 65 ms, 717 s, and 8 hnsecs


===ASDF===

book

serialize test = 38 ms, 895 s, and 9 hnsecs. Size = 50400000

deserialize test = 20 ms, 803 s, and 1 hnsec

page cache

serialize test = 3 secs, 661 ms, 944 s, and 6 hnsecs. Size = 6861920000

deserialize test = 1 sec, 300 ms, 98 s, and 5 hnsecs


===PROTOBUF===

book

serialize test = 14 ms and 954 s. Size = 0

deserialize test = 115 s and 5 hnsecs

page cache

serialize test = 40 ms, 278 s, and 8 hnsecs. Size = 0

deserialize test = 133 s and 9 hnsecs


===Json===

book

serialize test = 107 ms, 28 s, and 4 hnsecs. Size = 50400000

deserialize test = 176 ms, 829 s, and 1 hnsec

page cache

serialize test = 11 secs, 190 ms, 930 s, and 3 hnsecs. Size = 7075360000

deserialize test = 19 secs, 454 ms, 427 s, and 5 hnsecs
