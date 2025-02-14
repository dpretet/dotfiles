vim9script

#############################################################
# Leader key setup, handled with vim-leader-mapper
#############################################################

nnoremap <Space> <Nop>
g:mapleader = "\<Space>"

# Define Main leader key menu
g:leaderMenu =  {
    f: [":CtrlPMixed",                                      "Fuzzy find with CtrlP"],
    l: [":ls",                                              'List opened buffers'],
    d: [":Bclose",                                          'Close buffer (but keeps the panel)'],
    e: [":Lexplore",                                        'Open explorer'],
    E: [":Lexplore %:p:h",                                  "Open explorer current file\'s folder"],
    o: [":normal gF",                                       'Open file under cursor'],
    v: [":vsplit",                                          'Split buffer vertically'],
    h: [":split",                                           'Split buffer horizontally'],
    H: [":hide",                                            'Hide panel'],
    c: [":Commenter",                                       'Toggle comment of current line'],
    C: [":'<,'>Commenter",                                  'Toggle comment of visual selection'],
    t: [":call FloatTerm()",                                'Open a floating terminal'],
    x: [":%!xxd",                                           'Display a buffer in hexadecimal'],
    j: [":exe \"vertical resize \" . (winwidth(0) * 2/3)",  'Downsize panel'],
    k: [":exe \"vertical resize \" . (winwidth(0) * 3/2)",  'Upsize panel'],
    w: [":VenterToggle",                                    'Center buffer'],
}

nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>


#############################################################
# Mu-Complete
#############################################################
# g:mucomplete#enable_auto_at_startup = 1


#############################################################
# ALE
#############################################################

g:ale_c_parse_makefile = 1
g:ale_c_parse_compile_commands = 1
g:ale_linters_explicit = 1
g:ale_sign_error = '✘'
g:ale_sign_warning = '⚠'
g:ale_sign_column_always = 1
g:ale_echo_msg_error_str = 'E'
g:ale_echo_msg_warning_str = 'W'
g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

g:ale_linters = {
   'systemverilog': ['verilator', 'iverilog'],
   'S': [''],
   'asm': [''],
   'c': ['gcc'],
   'c++': ['clang'],
   'python': ['pylint'],
}

# Specify rustc option for linting (avoid to use nightly build)
g:ale_verilog_iverilog_options = "-g2012 -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32"
g:ale_verilog_verilator_options = "+1800-2017ext+sv +1800-2005ext+v  -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32 -Wno-STMTDLY -Wno-UNUSED -Wno-UNDRIVEN"

# Compile options
g:ale_c_cc_options = '-Wall -std=c11 -Wpedantic'

g:ale_c_cc_options = g:ale_c_cc_options .. ' -I./include'
g:ale_c_cc_options = g:ale_c_cc_options .. ' -I./lib'

# Add include path for system headers
g:ale_c_cc_options = g:ale_c_cc_options .. ' -I/usr/include'
g:ale_c_cc_options = g:ale_c_cc_options .. ' -I/usr/local/include'
g:ale_c_cc_options = g:ale_c_cc_options .. ' -I/Library/Developer/CommandLineTools/SDKs/MacOS.sdk/usr/include'
g:ale_c_cc_options = g:ale_c_cc_options .. ' -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include'
g:ale_c_cc_options = g:ale_c_cc_options .. " -I/opt/homebrew/Cellar/verilator/5.002/share/verilator/include"

# Set clang and gcc with the same options
g:ale_c_clang_options = g:ale_c_cc_options

# Avoid system header analysis
g:ale_c_clang_options = g:ale_c_clang_options .. ' -Wno-everything -Wno-error'
g:ale_c_cc_options = g:ale_c_cc_options .. ' -w'

#############################################################
# Auto-popmenu plugin
#############################################################

# Enable this plugin for certain filetypes
g:apc_enable_ft = {'text': 1, 'vim': 1, 'markdown': 1, 'verilog': 1, 'c': 1, 'systemverilog': 1}
