org $008638
    db $FF,$FF,$FF

org $00865A
    db $FF,$FF,$FF

org $008EFD
    db $FF,$FF,$FF,$FF,$FF

org $008F36
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF

org $008FF2
    db $FF,$FF,$FF,$FF,$FF,$FF

org $009034
    db $FF,$FF,$FF,$FF

org $00B118
    db $FF,$FF,$FF,$FF

org $00EA0B
    db $FF,$FF

org $00EC4C
    db $FF,$FF,$FF

org $00EE76
    db $FF,$FF,$FF,$FF

org $00EF28
    db $FF,$FF

org $01F242
    db $FF,$FF,$FF

org $02E900
    db $FF,$FF,$FF,$FF

org $039604
    db $FF,$FF,$FF,$FF,$FF

org $03B34D
    db $FF,$FF,$FF,$FF,$FF

org $04CE01
    db $FF,$FF,$FF,$FF,$FF,$FF

org $04CF44
    db $FF,$FF,$FF,$FF

org $04CF5C
    db $FF,$FF,$FF,$FF

org $04D095
    db $FF,$FF,$FF,$FF,$FF,$FF

org $059B83
    db $FF,$FF,$FF,$FF

org $05C81D
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    db $FF,$FF,$FF,$FF

org $068E4A
    db $FF,$FF,$FF,$FF

org $0795EA
    db $FF,$FF,$FF,$FF

org $01FF84
    !i #= 0
    while !i < $7C
        db $FF
        !i #= !i+1
    endif

org $03FA80
    !i #= 0
    while !i < $580
        db $FF
        !i #= !i+1
    endif
