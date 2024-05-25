org $008638
    db $85,$B4,$8A

org $00865A
    db $85,$B4,$8A

org $008EFD
    db $A9,$10,$20,$91,$86

org $008F36
    db $A5,$AD,$89,$08,$F0,$09,$A5,$3C
    db $3A,$10,$11,$A9,$02,$80,$0D,$89
    db $24,$F0,$24,$A5,$3C,$1A,$C9,$03
    db $D0,$02,$A9,$00,$85,$3C,$AA,$BD
    db $F8,$87,$8D,$E0,$09,$A5,$3C,$18
    db $69,$10,$20,$91,$86,$A9,$F0,$85
    db $3B,$A9,$1C,$22,$2B,$80,$01

org $008FF2
    db $9C,$D9,$09,$9C,$DA,$09

org $009034
    db $64,$38,$64,$39

org $00B118
    db $A9,$08,$85,$D5

org $00EA0B
    db $62,$81

org $00EC4C
    db $85,$00,$0A

org $00EE76
    db $9F,$CB,$FF,$7E

org $00EF28
    db $41,$88

org $01F242
    db $A9,$02,$85

org $02E900
    db $A9,$04,$85,$01

org $039604
    db $A9,$01,$0C,$D7,$1F

org $03B34D
    db $A9,$C0,$0C,$B2,$1F

org $04CE01
    db $ED,$00,$00,$8D,$FF,$09

org $04CF44
    db $85,$27,$A9,$20

org $04CF5C
    db $64,$27,$A9,$06

org $04D095
    db $ED,$00,$00,$8D,$FF,$09

org $059B83
    db $A9,$04,$85,$01

org $05C81D
    db $BD,$FD,$BB,$0C,$D1,$1F,$60,$A9
    db $FF,$0C,$CC,$1F

org $068E4A
    db $AD,$97,$AD,$97

org $0795EA
    db $A9,$04,$85,$01

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
