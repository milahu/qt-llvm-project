; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux                  | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+sse4.2   | FileCheck %s --check-prefixes=SSE,SSE42
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx      | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx2     | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512

;
; trunc(abs(sub(sext(a),sext(b)))) -> abds(a,b)
;

define <16 x i8> @abd_ext_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_ext_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3],xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1],xmm3[2],xmm4[2],xmm3[3],xmm4[3]
; SSE2-NEXT:    psrad $24, %xmm3
; SSE2-NEXT:    pxor %xmm9, %xmm9
; SSE2-NEXT:    pxor %xmm5, %xmm5
; SSE2-NEXT:    pcmpgtd %xmm3, %xmm5
; SSE2-NEXT:    movdqa %xmm3, %xmm0
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm3 = xmm3[2],xmm5[2],xmm3[3],xmm5[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm5 = xmm5[4],xmm4[4],xmm5[5],xmm4[5],xmm5[6],xmm4[6],xmm5[7],xmm4[7]
; SSE2-NEXT:    psrad $24, %xmm5
; SSE2-NEXT:    pxor %xmm6, %xmm6
; SSE2-NEXT:    pcmpgtd %xmm5, %xmm6
; SSE2-NEXT:    movdqa %xmm5, %xmm4
; SSE2-NEXT:    punpckldq {{.*#+}} xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm5 = xmm5[2],xmm6[2],xmm5[3],xmm6[3]
; SSE2-NEXT:    punpckhbw {{.*#+}} xmm7 = xmm7[8],xmm2[8],xmm7[9],xmm2[9],xmm7[10],xmm2[10],xmm7[11],xmm2[11],xmm7[12],xmm2[12],xmm7[13],xmm2[13],xmm7[14],xmm2[14],xmm7[15],xmm2[15]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
; SSE2-NEXT:    psrad $24, %xmm6
; SSE2-NEXT:    pxor %xmm8, %xmm8
; SSE2-NEXT:    pcmpgtd %xmm6, %xmm8
; SSE2-NEXT:    movdqa %xmm6, %xmm2
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm8[0],xmm2[1],xmm8[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm6 = xmm6[2],xmm8[2],xmm6[3],xmm8[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm8 = xmm8[4],xmm7[4],xmm8[5],xmm7[5],xmm8[6],xmm7[6],xmm8[7],xmm7[7]
; SSE2-NEXT:    psrad $24, %xmm8
; SSE2-NEXT:    pxor %xmm10, %xmm10
; SSE2-NEXT:    pcmpgtd %xmm8, %xmm10
; SSE2-NEXT:    movdqa %xmm8, %xmm7
; SSE2-NEXT:    punpckldq {{.*#+}} xmm7 = xmm7[0],xmm10[0],xmm7[1],xmm10[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm8 = xmm8[2],xmm10[2],xmm8[3],xmm10[3]
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm10 = xmm10[0],xmm1[0],xmm10[1],xmm1[1],xmm10[2],xmm1[2],xmm10[3],xmm1[3],xmm10[4],xmm1[4],xmm10[5],xmm1[5],xmm10[6],xmm1[6],xmm10[7],xmm1[7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm11 = xmm11[0],xmm10[0],xmm11[1],xmm10[1],xmm11[2],xmm10[2],xmm11[3],xmm10[3]
; SSE2-NEXT:    psrad $24, %xmm11
; SSE2-NEXT:    pxor %xmm12, %xmm12
; SSE2-NEXT:    pcmpgtd %xmm11, %xmm12
; SSE2-NEXT:    movdqa %xmm11, %xmm13
; SSE2-NEXT:    punpckldq {{.*#+}} xmm13 = xmm13[0],xmm12[0],xmm13[1],xmm12[1]
; SSE2-NEXT:    psubq %xmm13, %xmm0
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm11 = xmm11[2],xmm12[2],xmm11[3],xmm12[3]
; SSE2-NEXT:    psubq %xmm11, %xmm3
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm10 = xmm10[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    psrad $24, %xmm10
; SSE2-NEXT:    pxor %xmm11, %xmm11
; SSE2-NEXT:    pcmpgtd %xmm10, %xmm11
; SSE2-NEXT:    movdqa %xmm10, %xmm12
; SSE2-NEXT:    punpckldq {{.*#+}} xmm12 = xmm12[0],xmm11[0],xmm12[1],xmm11[1]
; SSE2-NEXT:    psubq %xmm12, %xmm4
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm10 = xmm10[2],xmm11[2],xmm10[3],xmm11[3]
; SSE2-NEXT:    psubq %xmm10, %xmm5
; SSE2-NEXT:    punpckhbw {{.*#+}} xmm1 = xmm1[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm10 = xmm10[0],xmm1[0],xmm10[1],xmm1[1],xmm10[2],xmm1[2],xmm10[3],xmm1[3]
; SSE2-NEXT:    psrad $24, %xmm10
; SSE2-NEXT:    pxor %xmm11, %xmm11
; SSE2-NEXT:    pcmpgtd %xmm10, %xmm11
; SSE2-NEXT:    movdqa %xmm10, %xmm12
; SSE2-NEXT:    punpckldq {{.*#+}} xmm12 = xmm12[0],xmm11[0],xmm12[1],xmm11[1]
; SSE2-NEXT:    psubq %xmm12, %xmm2
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm10 = xmm10[2],xmm11[2],xmm10[3],xmm11[3]
; SSE2-NEXT:    psubq %xmm10, %xmm6
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    psrad $24, %xmm1
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm9
; SSE2-NEXT:    movdqa %xmm1, %xmm10
; SSE2-NEXT:    punpckldq {{.*#+}} xmm10 = xmm10[0],xmm9[0],xmm10[1],xmm9[1]
; SSE2-NEXT:    psubq %xmm10, %xmm7
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm1 = xmm1[2],xmm9[2],xmm1[3],xmm9[3]
; SSE2-NEXT:    psubq %xmm1, %xmm8
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm3, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm3
; SSE2-NEXT:    psubq %xmm1, %xmm3
; SSE2-NEXT:    movdqa %xmm4, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm4
; SSE2-NEXT:    psubq %xmm1, %xmm4
; SSE2-NEXT:    movdqa %xmm5, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm5
; SSE2-NEXT:    psubq %xmm1, %xmm5
; SSE2-NEXT:    movdqa %xmm2, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    psubq %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm6, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm6
; SSE2-NEXT:    psubq %xmm1, %xmm6
; SSE2-NEXT:    movdqa %xmm7, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm7
; SSE2-NEXT:    psubq %xmm1, %xmm7
; SSE2-NEXT:    movdqa %xmm8, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm8
; SSE2-NEXT:    psubq %xmm1, %xmm8
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
; SSE2-NEXT:    pand %xmm1, %xmm8
; SSE2-NEXT:    pand %xmm1, %xmm7
; SSE2-NEXT:    packuswb %xmm8, %xmm7
; SSE2-NEXT:    pand %xmm1, %xmm6
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    packuswb %xmm6, %xmm2
; SSE2-NEXT:    packuswb %xmm7, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm5
; SSE2-NEXT:    pand %xmm1, %xmm4
; SSE2-NEXT:    packuswb %xmm5, %xmm4
; SSE2-NEXT:    pand %xmm1, %xmm3
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    packuswb %xmm3, %xmm0
; SSE2-NEXT:    packuswb %xmm4, %xmm0
; SSE2-NEXT:    packuswb %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <16 x i8> %a to <16 x i64>
  %bext = sext <16 x i8> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 false)
  %trunc = trunc <16 x i64> %abs to <16 x i8>
  ret <16 x i8> %trunc
}

define <16 x i8> @abd_ext_v16i8_undef(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_ext_v16i8_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3],xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1],xmm3[2],xmm4[2],xmm3[3],xmm4[3]
; SSE2-NEXT:    psrad $24, %xmm3
; SSE2-NEXT:    pxor %xmm9, %xmm9
; SSE2-NEXT:    pxor %xmm5, %xmm5
; SSE2-NEXT:    pcmpgtd %xmm3, %xmm5
; SSE2-NEXT:    movdqa %xmm3, %xmm0
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm3 = xmm3[2],xmm5[2],xmm3[3],xmm5[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm5 = xmm5[4],xmm4[4],xmm5[5],xmm4[5],xmm5[6],xmm4[6],xmm5[7],xmm4[7]
; SSE2-NEXT:    psrad $24, %xmm5
; SSE2-NEXT:    pxor %xmm6, %xmm6
; SSE2-NEXT:    pcmpgtd %xmm5, %xmm6
; SSE2-NEXT:    movdqa %xmm5, %xmm4
; SSE2-NEXT:    punpckldq {{.*#+}} xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm5 = xmm5[2],xmm6[2],xmm5[3],xmm6[3]
; SSE2-NEXT:    punpckhbw {{.*#+}} xmm7 = xmm7[8],xmm2[8],xmm7[9],xmm2[9],xmm7[10],xmm2[10],xmm7[11],xmm2[11],xmm7[12],xmm2[12],xmm7[13],xmm2[13],xmm7[14],xmm2[14],xmm7[15],xmm2[15]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
; SSE2-NEXT:    psrad $24, %xmm6
; SSE2-NEXT:    pxor %xmm8, %xmm8
; SSE2-NEXT:    pcmpgtd %xmm6, %xmm8
; SSE2-NEXT:    movdqa %xmm6, %xmm2
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm8[0],xmm2[1],xmm8[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm6 = xmm6[2],xmm8[2],xmm6[3],xmm8[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm8 = xmm8[4],xmm7[4],xmm8[5],xmm7[5],xmm8[6],xmm7[6],xmm8[7],xmm7[7]
; SSE2-NEXT:    psrad $24, %xmm8
; SSE2-NEXT:    pxor %xmm10, %xmm10
; SSE2-NEXT:    pcmpgtd %xmm8, %xmm10
; SSE2-NEXT:    movdqa %xmm8, %xmm7
; SSE2-NEXT:    punpckldq {{.*#+}} xmm7 = xmm7[0],xmm10[0],xmm7[1],xmm10[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm8 = xmm8[2],xmm10[2],xmm8[3],xmm10[3]
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm10 = xmm10[0],xmm1[0],xmm10[1],xmm1[1],xmm10[2],xmm1[2],xmm10[3],xmm1[3],xmm10[4],xmm1[4],xmm10[5],xmm1[5],xmm10[6],xmm1[6],xmm10[7],xmm1[7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm11 = xmm11[0],xmm10[0],xmm11[1],xmm10[1],xmm11[2],xmm10[2],xmm11[3],xmm10[3]
; SSE2-NEXT:    psrad $24, %xmm11
; SSE2-NEXT:    pxor %xmm12, %xmm12
; SSE2-NEXT:    pcmpgtd %xmm11, %xmm12
; SSE2-NEXT:    movdqa %xmm11, %xmm13
; SSE2-NEXT:    punpckldq {{.*#+}} xmm13 = xmm13[0],xmm12[0],xmm13[1],xmm12[1]
; SSE2-NEXT:    psubq %xmm13, %xmm0
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm11 = xmm11[2],xmm12[2],xmm11[3],xmm12[3]
; SSE2-NEXT:    psubq %xmm11, %xmm3
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm10 = xmm10[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    psrad $24, %xmm10
; SSE2-NEXT:    pxor %xmm11, %xmm11
; SSE2-NEXT:    pcmpgtd %xmm10, %xmm11
; SSE2-NEXT:    movdqa %xmm10, %xmm12
; SSE2-NEXT:    punpckldq {{.*#+}} xmm12 = xmm12[0],xmm11[0],xmm12[1],xmm11[1]
; SSE2-NEXT:    psubq %xmm12, %xmm4
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm10 = xmm10[2],xmm11[2],xmm10[3],xmm11[3]
; SSE2-NEXT:    psubq %xmm10, %xmm5
; SSE2-NEXT:    punpckhbw {{.*#+}} xmm1 = xmm1[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm10 = xmm10[0],xmm1[0],xmm10[1],xmm1[1],xmm10[2],xmm1[2],xmm10[3],xmm1[3]
; SSE2-NEXT:    psrad $24, %xmm10
; SSE2-NEXT:    pxor %xmm11, %xmm11
; SSE2-NEXT:    pcmpgtd %xmm10, %xmm11
; SSE2-NEXT:    movdqa %xmm10, %xmm12
; SSE2-NEXT:    punpckldq {{.*#+}} xmm12 = xmm12[0],xmm11[0],xmm12[1],xmm11[1]
; SSE2-NEXT:    psubq %xmm12, %xmm2
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm10 = xmm10[2],xmm11[2],xmm10[3],xmm11[3]
; SSE2-NEXT:    psubq %xmm10, %xmm6
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    psrad $24, %xmm1
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm9
; SSE2-NEXT:    movdqa %xmm1, %xmm10
; SSE2-NEXT:    punpckldq {{.*#+}} xmm10 = xmm10[0],xmm9[0],xmm10[1],xmm9[1]
; SSE2-NEXT:    psubq %xmm10, %xmm7
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm1 = xmm1[2],xmm9[2],xmm1[3],xmm9[3]
; SSE2-NEXT:    psubq %xmm1, %xmm8
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm3, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm3
; SSE2-NEXT:    psubq %xmm1, %xmm3
; SSE2-NEXT:    movdqa %xmm4, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm4
; SSE2-NEXT:    psubq %xmm1, %xmm4
; SSE2-NEXT:    movdqa %xmm5, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm5
; SSE2-NEXT:    psubq %xmm1, %xmm5
; SSE2-NEXT:    movdqa %xmm2, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    psubq %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm6, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm6
; SSE2-NEXT:    psubq %xmm1, %xmm6
; SSE2-NEXT:    movdqa %xmm7, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm7
; SSE2-NEXT:    psubq %xmm1, %xmm7
; SSE2-NEXT:    movdqa %xmm8, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm8
; SSE2-NEXT:    psubq %xmm1, %xmm8
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
; SSE2-NEXT:    pand %xmm1, %xmm8
; SSE2-NEXT:    pand %xmm1, %xmm7
; SSE2-NEXT:    packuswb %xmm8, %xmm7
; SSE2-NEXT:    pand %xmm1, %xmm6
; SSE2-NEXT:    pand %xmm1, %xmm2
; SSE2-NEXT:    packuswb %xmm6, %xmm2
; SSE2-NEXT:    packuswb %xmm7, %xmm2
; SSE2-NEXT:    pand %xmm1, %xmm5
; SSE2-NEXT:    pand %xmm1, %xmm4
; SSE2-NEXT:    packuswb %xmm5, %xmm4
; SSE2-NEXT:    pand %xmm1, %xmm3
; SSE2-NEXT:    pand %xmm1, %xmm0
; SSE2-NEXT:    packuswb %xmm3, %xmm0
; SSE2-NEXT:    packuswb %xmm4, %xmm0
; SSE2-NEXT:    packuswb %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v16i8_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v16i8_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <16 x i8> %a to <16 x i64>
  %bext = sext <16 x i8> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 true)
  %trunc = trunc <16 x i64> %abs to <16 x i8>
  ret <16 x i8> %trunc
}

define <8 x i16> @abd_ext_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_ext_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_ext_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <8 x i16> %a to <8 x i64>
  %bext = sext <8 x i16> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 false)
  %trunc = trunc <8 x i64> %abs to <8 x i16>
  ret <8 x i16> %trunc
}

define <8 x i16> @abd_ext_v8i16_undef(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_ext_v8i16_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_ext_v8i16_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <8 x i16> %a to <8 x i64>
  %bext = sext <8 x i16> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 true)
  %trunc = trunc <8 x i64> %abs to <8 x i16>
  ret <8 x i16> %trunc
}

define <4 x i32> @abd_ext_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_ext_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm3, %xmm3
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1]
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm2, %xmm4
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm4[0],xmm2[1],xmm4[1]
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm1[2,3,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    pcmpgtd %xmm5, %xmm3
; SSE2-NEXT:    punpckldq {{.*#+}} xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
; SSE2-NEXT:    psubq %xmm5, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm2, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    psubq %xmm1, %xmm2
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,2],xmm2[0,2]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <4 x i32> %a to <4 x i64>
  %bext = sext <4 x i32> %b to <4 x i64>
  %sub = sub <4 x i64> %aext, %bext
  %abs = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %sub, i1 false)
  %trunc = trunc <4 x i64> %abs to <4 x i32>
  ret <4 x i32> %trunc
}

define <4 x i32> @abd_ext_v4i32_undef(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_ext_v4i32_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm3, %xmm3
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1]
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm2, %xmm4
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm4[0],xmm2[1],xmm4[1]
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm1[2,3,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    pcmpgtd %xmm5, %xmm3
; SSE2-NEXT:    punpckldq {{.*#+}} xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
; SSE2-NEXT:    psubq %xmm5, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm2, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    psubq %xmm1, %xmm2
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,2],xmm2[0,2]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v4i32_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v4i32_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <4 x i32> %a to <4 x i64>
  %bext = sext <4 x i32> %b to <4 x i64>
  %sub = sub <4 x i64> %aext, %bext
  %abs = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %sub, i1 true)
  %trunc = trunc <4 x i64> %abs to <4 x i32>
  ret <4 x i32> %trunc
}

define <2 x i64> @abd_ext_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_ext_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    movq %xmm2, %rax
; SSE2-NEXT:    movq %rax, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    movq %xmm0, %rdx
; SSE2-NEXT:    movq %rdx, %rsi
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    movq %rdi, %r8
; SSE2-NEXT:    sarq $63, %r8
; SSE2-NEXT:    movq %xmm1, %r9
; SSE2-NEXT:    movq %r9, %r10
; SSE2-NEXT:    sarq $63, %r10
; SSE2-NEXT:    subq %r9, %rdx
; SSE2-NEXT:    sbbq %r10, %rsi
; SSE2-NEXT:    subq %rdi, %rax
; SSE2-NEXT:    sbbq %r8, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    xorq %rcx, %rax
; SSE2-NEXT:    subq %rcx, %rax
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    subq %rsi, %rdx
; SSE2-NEXT:    movq %rdx, %xmm0
; SSE2-NEXT:    movq %rax, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movq %xmm0, %rax
; SSE42-NEXT:    movq %rax, %rcx
; SSE42-NEXT:    sarq $63, %rcx
; SSE42-NEXT:    pextrq $1, %xmm0, %rdx
; SSE42-NEXT:    movq %rdx, %rsi
; SSE42-NEXT:    sarq $63, %rsi
; SSE42-NEXT:    movq %xmm1, %rdi
; SSE42-NEXT:    movq %rdi, %r8
; SSE42-NEXT:    sarq $63, %r8
; SSE42-NEXT:    pextrq $1, %xmm1, %r9
; SSE42-NEXT:    movq %r9, %r10
; SSE42-NEXT:    sarq $63, %r10
; SSE42-NEXT:    subq %r9, %rdx
; SSE42-NEXT:    sbbq %r10, %rsi
; SSE42-NEXT:    subq %rdi, %rax
; SSE42-NEXT:    sbbq %r8, %rcx
; SSE42-NEXT:    sarq $63, %rcx
; SSE42-NEXT:    xorq %rcx, %rax
; SSE42-NEXT:    subq %rcx, %rax
; SSE42-NEXT:    sarq $63, %rsi
; SSE42-NEXT:    xorq %rsi, %rdx
; SSE42-NEXT:    subq %rsi, %rdx
; SSE42-NEXT:    movq %rdx, %xmm1
; SSE42-NEXT:    movq %rax, %xmm0
; SSE42-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_ext_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    movq %rax, %rcx
; AVX1-NEXT:    sarq $63, %rcx
; AVX1-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX1-NEXT:    movq %rdx, %rsi
; AVX1-NEXT:    sarq $63, %rsi
; AVX1-NEXT:    vmovq %xmm1, %rdi
; AVX1-NEXT:    movq %rdi, %r8
; AVX1-NEXT:    sarq $63, %r8
; AVX1-NEXT:    vpextrq $1, %xmm1, %r9
; AVX1-NEXT:    movq %r9, %r10
; AVX1-NEXT:    sarq $63, %r10
; AVX1-NEXT:    subq %r9, %rdx
; AVX1-NEXT:    sbbq %r10, %rsi
; AVX1-NEXT:    subq %rdi, %rax
; AVX1-NEXT:    sbbq %r8, %rcx
; AVX1-NEXT:    sarq $63, %rcx
; AVX1-NEXT:    xorq %rcx, %rax
; AVX1-NEXT:    subq %rcx, %rax
; AVX1-NEXT:    sarq $63, %rsi
; AVX1-NEXT:    xorq %rsi, %rdx
; AVX1-NEXT:    subq %rsi, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm0
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    movq %rax, %rcx
; AVX2-NEXT:    sarq $63, %rcx
; AVX2-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX2-NEXT:    movq %rdx, %rsi
; AVX2-NEXT:    sarq $63, %rsi
; AVX2-NEXT:    vmovq %xmm1, %rdi
; AVX2-NEXT:    movq %rdi, %r8
; AVX2-NEXT:    sarq $63, %r8
; AVX2-NEXT:    vpextrq $1, %xmm1, %r9
; AVX2-NEXT:    movq %r9, %r10
; AVX2-NEXT:    sarq $63, %r10
; AVX2-NEXT:    subq %r9, %rdx
; AVX2-NEXT:    sbbq %r10, %rsi
; AVX2-NEXT:    subq %rdi, %rax
; AVX2-NEXT:    sbbq %r8, %rcx
; AVX2-NEXT:    sarq $63, %rcx
; AVX2-NEXT:    xorq %rcx, %rax
; AVX2-NEXT:    subq %rcx, %rax
; AVX2-NEXT:    sarq $63, %rsi
; AVX2-NEXT:    xorq %rsi, %rdx
; AVX2-NEXT:    subq %rsi, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm0
; AVX2-NEXT:    vmovq %rax, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %aext = sext <2 x i64> %a to <2 x i128>
  %bext = sext <2 x i64> %b to <2 x i128>
  %sub = sub <2 x i128> %aext, %bext
  %abs = call <2 x i128> @llvm.abs.v2i128(<2 x i128> %sub, i1 false)
  %trunc = trunc <2 x i128> %abs to <2 x i64>
  ret <2 x i64> %trunc
}

define <2 x i64> @abd_ext_v2i64_undef(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_ext_v2i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    movq %xmm2, %rax
; SSE2-NEXT:    movq %rax, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    movq %xmm0, %rdx
; SSE2-NEXT:    movq %rdx, %rsi
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    movq %rdi, %r8
; SSE2-NEXT:    sarq $63, %r8
; SSE2-NEXT:    movq %xmm1, %r9
; SSE2-NEXT:    movq %r9, %r10
; SSE2-NEXT:    sarq $63, %r10
; SSE2-NEXT:    subq %r9, %rdx
; SSE2-NEXT:    sbbq %r10, %rsi
; SSE2-NEXT:    subq %rdi, %rax
; SSE2-NEXT:    sbbq %r8, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    xorq %rcx, %rax
; SSE2-NEXT:    subq %rcx, %rax
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    subq %rsi, %rdx
; SSE2-NEXT:    movq %rdx, %xmm0
; SSE2-NEXT:    movq %rax, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v2i64_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movq %xmm0, %rax
; SSE42-NEXT:    movq %rax, %rcx
; SSE42-NEXT:    sarq $63, %rcx
; SSE42-NEXT:    pextrq $1, %xmm0, %rdx
; SSE42-NEXT:    movq %rdx, %rsi
; SSE42-NEXT:    sarq $63, %rsi
; SSE42-NEXT:    movq %xmm1, %rdi
; SSE42-NEXT:    movq %rdi, %r8
; SSE42-NEXT:    sarq $63, %r8
; SSE42-NEXT:    pextrq $1, %xmm1, %r9
; SSE42-NEXT:    movq %r9, %r10
; SSE42-NEXT:    sarq $63, %r10
; SSE42-NEXT:    subq %r9, %rdx
; SSE42-NEXT:    sbbq %r10, %rsi
; SSE42-NEXT:    subq %rdi, %rax
; SSE42-NEXT:    sbbq %r8, %rcx
; SSE42-NEXT:    sarq $63, %rcx
; SSE42-NEXT:    xorq %rcx, %rax
; SSE42-NEXT:    subq %rcx, %rax
; SSE42-NEXT:    sarq $63, %rsi
; SSE42-NEXT:    xorq %rsi, %rdx
; SSE42-NEXT:    subq %rsi, %rdx
; SSE42-NEXT:    movq %rdx, %xmm1
; SSE42-NEXT:    movq %rax, %xmm0
; SSE42-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_ext_v2i64_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    movq %rax, %rcx
; AVX1-NEXT:    sarq $63, %rcx
; AVX1-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX1-NEXT:    movq %rdx, %rsi
; AVX1-NEXT:    sarq $63, %rsi
; AVX1-NEXT:    vmovq %xmm1, %rdi
; AVX1-NEXT:    movq %rdi, %r8
; AVX1-NEXT:    sarq $63, %r8
; AVX1-NEXT:    vpextrq $1, %xmm1, %r9
; AVX1-NEXT:    movq %r9, %r10
; AVX1-NEXT:    sarq $63, %r10
; AVX1-NEXT:    subq %r9, %rdx
; AVX1-NEXT:    sbbq %r10, %rsi
; AVX1-NEXT:    subq %rdi, %rax
; AVX1-NEXT:    sbbq %r8, %rcx
; AVX1-NEXT:    sarq $63, %rcx
; AVX1-NEXT:    xorq %rcx, %rax
; AVX1-NEXT:    subq %rcx, %rax
; AVX1-NEXT:    sarq $63, %rsi
; AVX1-NEXT:    xorq %rsi, %rdx
; AVX1-NEXT:    subq %rsi, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm0
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v2i64_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    movq %rax, %rcx
; AVX2-NEXT:    sarq $63, %rcx
; AVX2-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX2-NEXT:    movq %rdx, %rsi
; AVX2-NEXT:    sarq $63, %rsi
; AVX2-NEXT:    vmovq %xmm1, %rdi
; AVX2-NEXT:    movq %rdi, %r8
; AVX2-NEXT:    sarq $63, %r8
; AVX2-NEXT:    vpextrq $1, %xmm1, %r9
; AVX2-NEXT:    movq %r9, %r10
; AVX2-NEXT:    sarq $63, %r10
; AVX2-NEXT:    subq %r9, %rdx
; AVX2-NEXT:    sbbq %r10, %rsi
; AVX2-NEXT:    subq %rdi, %rax
; AVX2-NEXT:    sbbq %r8, %rcx
; AVX2-NEXT:    sarq $63, %rcx
; AVX2-NEXT:    xorq %rcx, %rax
; AVX2-NEXT:    subq %rcx, %rax
; AVX2-NEXT:    sarq $63, %rsi
; AVX2-NEXT:    xorq %rsi, %rdx
; AVX2-NEXT:    subq %rsi, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm0
; AVX2-NEXT:    vmovq %rax, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v2i64_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %aext = sext <2 x i64> %a to <2 x i128>
  %bext = sext <2 x i64> %b to <2 x i128>
  %sub = sub <2 x i128> %aext, %bext
  %abs = call <2 x i128> @llvm.abs.v2i128(<2 x i128> %sub, i1 true)
  %trunc = trunc <2 x i128> %abs to <2 x i64>
  ret <2 x i64> %trunc
}

;
; sub(smax(a,b),smin(a,b)) -> abds(a,b)
;

define <16 x i8> @abd_minmax_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_minmax_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtb %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pand %xmm2, %xmm3
; SSE2-NEXT:    pandn %xmm1, %xmm2
; SSE2-NEXT:    por %xmm3, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm3
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm1, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    psubb %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <16 x i8> @llvm.smin.v16i8(<16 x i8> %a, <16 x i8> %b)
  %max = call <16 x i8> @llvm.smax.v16i8(<16 x i8> %a, <16 x i8> %b)
  %sub = sub <16 x i8> %max, %min
  ret <16 x i8> %sub
}

define <8 x i16> @abd_minmax_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_minmax_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <8 x i16> @llvm.smin.v8i16(<8 x i16> %a, <8 x i16> %b)
  %max = call <8 x i16> @llvm.smax.v8i16(<8 x i16> %a, <8 x i16> %b)
  %sub = sub <8 x i16> %max, %min
  ret <8 x i16> %sub
}

define <4 x i32> @abd_minmax_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_minmax_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pand %xmm2, %xmm3
; SSE2-NEXT:    pandn %xmm1, %xmm2
; SSE2-NEXT:    por %xmm3, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm1, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    psubd %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <4 x i32> @llvm.smin.v4i32(<4 x i32> %a, <4 x i32> %b)
  %max = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %a, <4 x i32> %b)
  %sub = sub <4 x i32> %max, %min
  ret <4 x i32> %sub
}

define <2 x i64> @abd_minmax_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_minmax_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pxor %xmm2, %xmm3
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm3, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[0,0,2,2]
; SSE2-NEXT:    movdqa %xmm3, %xmm6
; SSE2-NEXT:    pcmpeqd %xmm2, %xmm6
; SSE2-NEXT:    pshufd {{.*#+}} xmm6 = xmm6[1,1,3,3]
; SSE2-NEXT:    pand %xmm6, %xmm5
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[1,1,3,3]
; SSE2-NEXT:    por %xmm5, %xmm4
; SSE2-NEXT:    movdqa %xmm0, %xmm5
; SSE2-NEXT:    pand %xmm4, %xmm5
; SSE2-NEXT:    pandn %xmm1, %xmm4
; SSE2-NEXT:    por %xmm5, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm2, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm3[0,0,2,2]
; SSE2-NEXT:    pand %xmm6, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[1,1,3,3]
; SSE2-NEXT:    por %xmm2, %xmm3
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm1, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    psubq %xmm4, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm0
; SSE42-NEXT:    movdqa %xmm2, %xmm3
; SSE42-NEXT:    blendvpd %xmm0, %xmm1, %xmm3
; SSE42-NEXT:    blendvpd %xmm0, %xmm2, %xmm1
; SSE42-NEXT:    psubq %xmm3, %xmm1
; SSE42-NEXT:    movdqa %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_minmax_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vblendvpd %xmm2, %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vblendvpd %xmm2, %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vpsubq %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vblendvpd %xmm2, %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vblendvpd %xmm2, %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vpsubq %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %min = call <2 x i64> @llvm.smin.v2i64(<2 x i64> %a, <2 x i64> %b)
  %max = call <2 x i64> @llvm.smax.v2i64(<2 x i64> %a, <2 x i64> %b)
  %sub = sub <2 x i64> %max, %min
  ret <2 x i64> %sub
}

;
; abs(sub_nsw(x, y)) -> abds(a,b)
;

define <16 x i8> @abd_subnsw_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    psubb %xmm0, %xmm1
; SSE2-NEXT:    pminub %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubb %xmm1, %xmm0
; SSE42-NEXT:    pabsb %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsb %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <16 x i8> %a, %b
  %abs = call <16 x i8> @llvm.abs.v16i8(<16 x i8> %sub, i1 false)
  ret <16 x i8> %abs
}

define <8 x i16> @abd_subnsw_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v8i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubw %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    psubw %xmm0, %xmm1
; SSE2-NEXT:    pmaxsw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v8i16:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubw %xmm1, %xmm0
; SSE42-NEXT:    pabsw %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsw %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <8 x i16> %a, %b
  %abs = call <8 x i16> @llvm.abs.v8i16(<8 x i16> %sub, i1 false)
  ret <8 x i16> %abs
}

define <4 x i32> @abd_subnsw_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubd %xmm1, %xmm0
; SSE42-NEXT:    pabsd %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsd %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <4 x i32> %a, %b
  %abs = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %sub, i1 false)
  ret <4 x i32> %abs
}

define <2 x i64> @abd_subnsw_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubq %xmm1, %xmm0
; SSE42-NEXT:    pxor %xmm1, %xmm1
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    blendvpd %xmm0, %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_subnsw_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm1
; AVX1-NEXT:    vblendvpd %xmm0, %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm1
; AVX2-NEXT:    vblendvpd %xmm0, %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpabsq %xmm0, %xmm0
; AVX512-NEXT:    retq
  %sub = sub nsw <2 x i64> %a, %b
  %abs = call <2 x i64> @llvm.abs.v2i64(<2 x i64> %sub, i1 false)
  ret <2 x i64> %abs
}

declare <16 x i8> @llvm.abs.v16i8(<16 x i8>, i1)
declare <8 x i16> @llvm.abs.v8i16(<8 x i16>, i1)
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)
declare <2 x i64> @llvm.abs.v2i64(<2 x i64>, i1)
declare <4 x i64> @llvm.abs.v4i64(<4 x i64>, i1)
declare <8 x i64> @llvm.abs.v8i64(<8 x i64>, i1)
declare <16 x i64> @llvm.abs.v16i64(<16 x i64>, i1)
declare <2 x i128> @llvm.abs.v2i128(<2 x i128>, i1)

declare <16 x i8> @llvm.smax.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.smax.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>)
declare <2 x i64> @llvm.smax.v2i64(<2 x i64>, <2 x i64>)

declare <16 x i8> @llvm.smin.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.smin.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.smin.v4i32(<4 x i32>, <4 x i32>)
declare <2 x i64> @llvm.smin.v2i64(<2 x i64>, <2 x i64>)
