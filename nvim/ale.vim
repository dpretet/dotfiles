" ------------------------------------------------------
" ALE Configuration, to port in Lua
" ------------------------------------------------------
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '✺'

let g:ale_linters = {
\   'systemverilog': ['verilator', 'iverilog'],
\   'c': ['clang'],
\   'c++': ['clang'],
\   'python': ['pylint'],
\}

" Specify rustc option for linting (avoid to use nightly build)
let g:ale_verilog_iverilog_options = "-g2012 -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32"
let g:ale_verilog_verilator_options = "+1800-2017ext+sv +1800-2005ext+v  -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32 -Wno-STMTDLY -Wno-UNUSED -Wno-UNDRIVEN"
let g:ale_c_clangformat_options = "-std=c++11 -I /opt/riscv/include -I /opt/homebrew/Cellar/verilator/4.220/share/verilator/include"
