; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -verify-machineinstrs < %s | FileCheck --check-prefixes=GCN,GFX8,VARIANT0 %s
; RUN: llc -march=amdgcn -mattr=+auto-waitcnt-before-barrier -verify-machineinstrs < %s | FileCheck --check-prefixes=GCN,GFX8,VARIANT1 %s
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck --check-prefixes=GCN,GFX9,VARIANT2 %s
; RUN: llc -march=amdgcn -mcpu=gfx900 -mattr=+auto-waitcnt-before-barrier -verify-machineinstrs < %s | FileCheck --check-prefixes=GCN,GFX9,VARIANT3 %s

define amdgpu_kernel void @test_barrier(i32 addrspace(1)* %out, i32 %size) #0 {
; VARIANT0-LABEL: test_barrier:
; VARIANT0:       ; %bb.0: ; %entry
; VARIANT0-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; VARIANT0-NEXT:    s_load_dword s2, s[0:1], 0xb
; VARIANT0-NEXT:    s_mov_b32 s7, 0xf000
; VARIANT0-NEXT:    s_mov_b32 s6, 0
; VARIANT0-NEXT:    v_lshlrev_b32_e32 v1, 2, v0
; VARIANT0-NEXT:    v_mov_b32_e32 v2, 0
; VARIANT0-NEXT:    v_not_b32_e32 v3, v0
; VARIANT0-NEXT:    s_waitcnt lgkmcnt(0)
; VARIANT0-NEXT:    buffer_store_dword v0, v[1:2], s[4:7], 0 addr64
; VARIANT0-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; VARIANT0-NEXT:    s_barrier
; VARIANT0-NEXT:    v_add_i32_e32 v3, vcc, s2, v3
; VARIANT0-NEXT:    v_ashrrev_i32_e32 v4, 31, v3
; VARIANT0-NEXT:    v_lshl_b64 v[3:4], v[3:4], 2
; VARIANT0-NEXT:    buffer_load_dword v0, v[3:4], s[4:7], 0 addr64
; VARIANT0-NEXT:    s_waitcnt vmcnt(0)
; VARIANT0-NEXT:    buffer_store_dword v0, v[1:2], s[4:7], 0 addr64
; VARIANT0-NEXT:    s_endpgm
;
; VARIANT1-LABEL: test_barrier:
; VARIANT1:       ; %bb.0: ; %entry
; VARIANT1-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; VARIANT1-NEXT:    s_load_dword s2, s[0:1], 0xb
; VARIANT1-NEXT:    s_mov_b32 s7, 0xf000
; VARIANT1-NEXT:    s_mov_b32 s6, 0
; VARIANT1-NEXT:    v_lshlrev_b32_e32 v1, 2, v0
; VARIANT1-NEXT:    v_mov_b32_e32 v2, 0
; VARIANT1-NEXT:    v_not_b32_e32 v3, v0
; VARIANT1-NEXT:    s_waitcnt lgkmcnt(0)
; VARIANT1-NEXT:    buffer_store_dword v0, v[1:2], s[4:7], 0 addr64
; VARIANT1-NEXT:    s_barrier
; VARIANT1-NEXT:    v_add_i32_e32 v3, vcc, s2, v3
; VARIANT1-NEXT:    v_ashrrev_i32_e32 v4, 31, v3
; VARIANT1-NEXT:    v_lshl_b64 v[3:4], v[3:4], 2
; VARIANT1-NEXT:    s_waitcnt expcnt(0)
; VARIANT1-NEXT:    buffer_load_dword v0, v[3:4], s[4:7], 0 addr64
; VARIANT1-NEXT:    s_waitcnt vmcnt(0)
; VARIANT1-NEXT:    buffer_store_dword v0, v[1:2], s[4:7], 0 addr64
; VARIANT1-NEXT:    s_endpgm
;
; VARIANT2-LABEL: test_barrier:
; VARIANT2:       ; %bb.0: ; %entry
; VARIANT2-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; VARIANT2-NEXT:    s_load_dword s0, s[0:1], 0x2c
; VARIANT2-NEXT:    v_lshlrev_b32_e32 v1, 2, v0
; VARIANT2-NEXT:    s_waitcnt lgkmcnt(0)
; VARIANT2-NEXT:    v_mov_b32_e32 v2, s3
; VARIANT2-NEXT:    v_xad_u32 v3, v0, -1, s0
; VARIANT2-NEXT:    v_ashrrev_i32_e32 v4, 31, v3
; VARIANT2-NEXT:    v_add_co_u32_e32 v1, vcc, s2, v1
; VARIANT2-NEXT:    v_lshlrev_b64 v[3:4], 2, v[3:4]
; VARIANT2-NEXT:    v_addc_co_u32_e32 v2, vcc, 0, v2, vcc
; VARIANT2-NEXT:    global_store_dword v[1:2], v0, off
; VARIANT2-NEXT:    v_mov_b32_e32 v0, s3
; VARIANT2-NEXT:    v_add_co_u32_e32 v3, vcc, s2, v3
; VARIANT2-NEXT:    v_addc_co_u32_e32 v4, vcc, v0, v4, vcc
; VARIANT2-NEXT:    s_waitcnt vmcnt(0)
; VARIANT2-NEXT:    s_barrier
; VARIANT2-NEXT:    global_load_dword v0, v[3:4], off
; VARIANT2-NEXT:    s_waitcnt vmcnt(0)
; VARIANT2-NEXT:    global_store_dword v[1:2], v0, off
; VARIANT2-NEXT:    s_endpgm
;
; VARIANT3-LABEL: test_barrier:
; VARIANT3:       ; %bb.0: ; %entry
; VARIANT3-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; VARIANT3-NEXT:    s_load_dword s0, s[0:1], 0x2c
; VARIANT3-NEXT:    v_lshlrev_b32_e32 v1, 2, v0
; VARIANT3-NEXT:    s_waitcnt lgkmcnt(0)
; VARIANT3-NEXT:    v_mov_b32_e32 v2, s3
; VARIANT3-NEXT:    v_xad_u32 v3, v0, -1, s0
; VARIANT3-NEXT:    v_ashrrev_i32_e32 v4, 31, v3
; VARIANT3-NEXT:    v_add_co_u32_e32 v1, vcc, s2, v1
; VARIANT3-NEXT:    v_lshlrev_b64 v[3:4], 2, v[3:4]
; VARIANT3-NEXT:    v_addc_co_u32_e32 v2, vcc, 0, v2, vcc
; VARIANT3-NEXT:    global_store_dword v[1:2], v0, off
; VARIANT3-NEXT:    v_mov_b32_e32 v0, s3
; VARIANT3-NEXT:    v_add_co_u32_e32 v3, vcc, s2, v3
; VARIANT3-NEXT:    v_addc_co_u32_e32 v4, vcc, v0, v4, vcc
; VARIANT3-NEXT:    s_barrier
; VARIANT3-NEXT:    global_load_dword v0, v[3:4], off
; VARIANT3-NEXT:    s_waitcnt vmcnt(0)
; VARIANT3-NEXT:    global_store_dword v[1:2], v0, off
; VARIANT3-NEXT:    s_endpgm
entry:
  %tmp = call i32 @llvm.amdgcn.workitem.id.x()
  %tmp1 = getelementptr i32, i32 addrspace(1)* %out, i32 %tmp
  store i32 %tmp, i32 addrspace(1)* %tmp1
  call void @llvm.amdgcn.s.barrier()
  %tmp3 = sub i32 %size, 1
  %tmp4 = sub i32 %tmp3, %tmp
  %tmp5 = getelementptr i32, i32 addrspace(1)* %out, i32 %tmp4
  %tmp6 = load i32, i32 addrspace(1)* %tmp5
  store i32 %tmp6, i32 addrspace(1)* %tmp1
  ret void
}

declare void @llvm.amdgcn.s.barrier() #1
declare i32 @llvm.amdgcn.workitem.id.x() #2

attributes #0 = { nounwind }
attributes #1 = { convergent nounwind }
attributes #2 = { nounwind readnone }
