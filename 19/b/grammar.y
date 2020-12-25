%{
%}

%token A
%token B
%token EOL

%glr-parser

%%

r0: r8 r11 EOL
r1: r113 r125 | r68 r121
r2: r117 r125 | r51 r121
r3: r109 r121 | r12 r125
r4: r96 r125 | r124 r121
r5: r125 r74 | r121 r127
r6: r48 r64
r7: r125 r52 | r121 r131
r8: r42 | r42 r8
r9: r121 r124 | r125 r46
r10: r125 r102 | r121 r88
r11: r42 r31 | r42 r11 r31
r12: r125 r51 | r121 r44
r13: r70 r121 | r47 r125
r14: r83 r125 | r130 r121
r15: r104 r121 | r95 r125
r16: r121 r99 | r125 r98
r17: r48 r113
r18: r125 r111 | r121 r66
r19: r125 r90 | r121 r3
r20: r35 r121 | r27 r125
r21: r125 r44 | r121 r96
r22: r125 r125 | r48 r121
r23: r121 r84
r24: r125 r78 | r121 r5
r25: r121 r56 | r125 r44
r26: r121 r77 | r125 r129
r27: r44 r121 | r127 r125
r28: r124 r121 | r74 r125
r29: r56 r121
r30: r125 r116
r31: r121 r120 | r125 r126
r32: r82 r121 | r29 r125
r33: r74 r125 | r68 r121
r34: r50 r121 | r105 r125
r35: r121 r85 | r125 r56
r36: r125 r19 | r121 r43
r37: r68 r121 | r56 r125
r38: r24 r125 | r7 r121
r39: r46 r121 | r44 r125
r40: r125 r92 | r121 r6
r41: r125 r113 | r121 r124
r42: r125 r34 | r121 r103
r43: r121 r49 | r125 r114
r44: r125 r125 | r121 r125
r45: r127 r125 | r74 r121
r46: r121 r121 | r121 r125
r47: r59 r125 | r69 r121
r48: r121 | r125
r49: r82 r121 | r21 r125
r50: r125 r93 | r121 r14
r51: r48 r125 | r125 r121
r52: r121 r124
r53: r121 r22 | r125 r127
r54: r121 r125 | r125 r121
r55: r118 r121 | r69 r125
r56: r125 r125
r57: r22 r121 | r51 r125
r58: r121 r17 | r125 r77
r59: r48 r127
r60: r124 r121 | r54 r125
r61: r46 r125 | r85 r121
r62: r132 r125 | r75 r121
r63: r121 r61 | r125 r53
r64: r121 r117 | r125 r85
r65: r125 r45 | r121 r25
r66: r121 r68 | r125 r85
r67: r121 r54 | r125 r22
r68: r125 r125 | r125 r121
r69: r22 r125 | r96 r121
r70: r121 r87 | r125 r1
r71: r122 r121 | r73 r125
r72: r125 r9 | r121 r107
r73: r125 r72 | r121 r18
r74: r125 r125 | r121 r121
r75: r121 r127 | r125 r117
r76: r121 r13 | r125 r38
r77: r96 r121 | r46 r125
r78: r54 r121 | r74 r125
r79: r46 r48
r80: r91 r125 | r112 r121
r81: r121 r46 | r125 r68
r82: r48 r44
r83: r125 r2 | r121 r81
r84: r121 r46
r85: r121 r125
r86: r85 r125 | r54 r121
r87: r121 r51 | r125 r96
r88: r125 r94 | r121 r30
r89: r86 r125 | r39 r121
r90: r28 r121 | r41 r125
r91: r108 r125 | r39 r121
r92: r121 r41 | r125 r100
r93: r121 r58 | r125 r16
r94: r37 r125 | r61 r121
r95: r32 r125 | r55 r121
r96: r125 r121
r97: r89 r125 | r62 r121
r98: r56 r121 | r54 r125
r99: r96 r125 | r96 r121
r100: r96 r125 | r54 r121
r101: r79 r121 | r35 r125
r102: r23 r121 | r65 r125
r103: r125 r15 | r121 r71
r104: r20 r125 | r115 r121
r105: r125 r80 | r121 r40
r106: r127 r121 | r117 r125
r107: r121 r113 | r125 r22
r108: r74 r121 | r56 r125
r109: r127 r48
r110: r33 r125 | r60 r121
r111: r48 r68
r112: r9 r121 | r77 r125
r113: r121 r121 | r125 r121
r114: r121 r123 | r125 r67
r115: r121 r4 | r125 r81
r116: r125 r117 | r121 r54
r117: r48 r48
r118: r121 r127 | r125 r96
r119: r97 r121 | r128 r125
r120: r125 r76 | r121 r119
r121: A
r122: r63 r125 | r26 r121
r123: r113 r121 | r68 r125
r124: r121 r125 | r48 r121
r125: B
r126: r121 r10 | r125 r36
r127: r125 r125 | r121 r48
r128: r101 r121 | r110 r125
r129: r125 r56 | r121 r56
r130: r106 r121 | r57 r125
r131: r68 r121 | r117 r125
r132: r121 r68 | r125 r113

%%
