# test-d-speed-serialization
Benchmark of serialization methods in d language

Methods:
- std.json
- cerealed
- msgpack-d
- drmi.sbin
- Jsonizer + std.json

OS Windows 10

DMD 2.080.0
LDC 1.9.0.

# DMD results:

===CEREALED===
book
serialize test = 35 ms, 541 ╬╝s, and 3 hnsecs. Size = 20320000
deserialize test = 6 ms, 749 ╬╝s, and 3 hnsecs
page cache
serialize test = 155 ms, 351 ╬╝s, and 3 hnsecs. Size = 3199680000
deserialize test = 1 ms, 733 ╬╝s, and 4 hnsecs
long structure
serialize test = 103 ms, 885 ╬╝s, and 5 hnsecs. Size = 10480000
deserialize test = 28 ms, 565 ╬╝s, and 4 hnsecs

===JSONIZER===
book
serialize test = 243 ms, 896 ╬╝s, and 5 hnsecs. Size = 27680000
deserialize test = 395 ms, 887 ╬╝s, and 5 hnsecs
page cache
serialize test = 24 secs, 552 ms, 290 ╬╝s, and 3 hnsecs. Size = 3538720000
deserialize test = 39 secs, 557 ms, 286 ╬╝s, and 2 hnsecs
long structure
serialize test = 508 ms, 511 ╬╝s, and 4 hnsecs. Size = 47680000
deserialize test = 664 ms and 580 ╬╝s

===MessagePack===
book
serialize test = 17 ms, 126 ╬╝s, and 1 hnsec. Size = 20240000
deserialize test = 44 ms, 883 ╬╝s, and 1 hnsec
page cache
serialize test = 56 ms, 830 ╬╝s, and 3 hnsecs. Size = 3199920000
deserialize test = 172 ms, 461 ╬╝s, and 1 hnsec
long structure
serialize test = 40 ms, 623 ╬╝s, and 6 hnsecs. Size = 9280000
deserialize test = 111 ms, 743 ╬╝s, and 7 hnsecs

===DRMI===
book
serialize test = 25 ms, 734 ╬╝s, and 3 hnsecs. Size = 22240000
deserialize test = 128 ms, 250 ╬╝s, and 1 hnsec
page cache
serialize test = 143 ms, 941 ╬╝s, and 9 hnsecs. Size = 3200160000
deserialize test = 14 secs, 669 ms, 953 ╬╝s, and 5 hnsecs
long structure
serialize test = 50 ms and 787 ╬╝s. Size = 16240000
deserialize test = 119 ms, 182 ╬╝s, and 8 hnsecs

===Json===
book
serialize test = 276 ms, 748 ╬╝s, and 9 hnsecs. Size = 25200000
deserialize test = 396 ms, 121 ╬╝s, and 8 hnsecs
page cache
serialize test = 24 secs, 46 ms, 474 ╬╝s, and 8 hnsecs. Size = 3537680000
deserialize test = 37 secs, 574 ms, 384 ╬╝s, and 9 hnsecs
