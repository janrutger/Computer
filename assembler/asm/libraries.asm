# Library to test the new USE lib function in ste Stacks language
EQU ~plotter 1
; EQU ~online 1
; EQU ~offline 2
EQU ~send 11
; EQU ~deviceColor 13

# $init_library_support pointer is set and consumed in os_loader
% $init_library_support @init_import_lib

## All current libraies are part of the base rom
## and are loaded at boottime

. $plotlib_str 8
% $plotlib_str \p \l \o \t \l \i \b \null


@init_import_lib

    ## Register the plotter library
    ldi A $plotlib_str  ; A points to the string to hash
    call @hash_filename ; After hashing A contains hash value
    ldi B @plotlib_init
    inc I $LIB_REG_HASH_ADRES_PTR

    stx A $LIB_REG_HASH_TABLE_BASE
    stx B $LIB_REG_ADRES_TABLE_BASE

ret


@add_method_to_stacks
    inc I $LIB_FUNC_HASH_ADRES_PTR

    stx A $LIB_FUNC_HASH_TABLE_BASE
    stx B $LIB_FUNC_ADRES_TABLE_BASE
ret



INCLUDE library_plotter