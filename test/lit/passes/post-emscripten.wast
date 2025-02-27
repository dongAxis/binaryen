;; NOTE: Assertions have been generated by update_lit_checks.py --all-items and should not be edited.
;; RUN: wasm-opt %s --post-emscripten -S -o - | filecheck %s

;; Checks that the start/stop exports are removed and that the data they
;; refer to is either zero'd out, or the segment emptied.

(module
 ;; CHECK:      (global $em_asm_start i32 (i32.const 1000))
 (global $em_asm_start i32 (i32.const 1000))
 ;; CHECK:      (global $em_asm_stop i32 (i32.const 1011))
 (global $em_asm_stop i32 (i32.const 1011))
 ;; CHECK:      (global $em_js_start i32 (i32.const 2006))
 (global $em_js_start i32 (i32.const 2006))
 ;; CHECK:      (global $em_js_stop i32 (i32.const 2015))
 (global $em_js_stop i32 (i32.const 2015))
 ;; CHECK:      (global $em_lib_deps_start i32 (i32.const 3000))
 (global $em_lib_deps_start i32 (i32.const 3000))
 ;; CHECK:      (global $em_lib_deps_stop i32 (i32.const 3009))
 (global $em_lib_deps_stop i32 (i32.const 3009))
 ;; CHECK:      (global $foo_start i32 (i32.const 4000))
 (global $foo_start i32 (i32.const 4000))
 ;; CHECK:      (global $foo_stop i32 (i32.const 4015))
 (global $foo_stop i32 (i32.const 4015))
 (memory 10 10)
 ;; CHECK:      (memory $0 10 10)

 ;; CHECK:      (data $data1 (i32.const 1000) "")
 (data $data1 (i32.const 1000) "hello world")
 ;; CHECK:      (data $data2 (i32.const 2000) "hello \00\00\00\00\00\00\00\00\00 world")
 (data $data2 (i32.const 2000) "hello DELETE ME world")
 ;; CHECK:      (data $data3 (i32.const 3000) "")
 (data $data3 (i32.const 3000) "some deps")
 (export "__start_em_asm" (global $em_asm_start))
 (export "__stop_em_asm" (global $em_asm_stop))
 (export "__start_em_js" (global $em_js_start))
 (export "__stop_em_js" (global $em_js_stop))
 (export "__start_em_lib_deps" (global $em_lib_deps_start))
 (export "__stop_em_lib_deps" (global $em_lib_deps_stop))
 ;; CHECK:      (export "__start_foo" (global $foo_start))
 (export "__start_foo" (global $foo_start))
 ;; CHECK:      (export "__stop_foo" (global $foo_stop))
 (export "__stop_foo" (global $foo_stop))
)

