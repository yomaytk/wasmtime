;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -O static-memory-maximum-size=0 -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0x1000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load8_u offset=0x1000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    0x40(%rdi), %r10
;;       movq    0x38(%rdi), %r9
;;       movl    %edx, %r8d
;;       xorq    %rax, %rax
;;       leaq    0x1000(%r9, %r8), %rsi
;;       cmpq    %r10, %r8
;;       cmovaq  %rax, %rsi
;;       movb    %cl, (%rsi)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    0x40(%rdi), %r8
;;       movq    0x38(%rdi), %rcx
;;       movl    %edx, %edx
;;       xorq    %rax, %rax
;;       leaq    0x1000(%rcx, %rdx), %rsi
;;       cmpq    %r8, %rdx
;;       cmovaq  %rax, %rsi
;;       movzbq  (%rsi), %rax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
