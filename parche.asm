lorom

!levels_completed_array     = $7EF400
!unlocked_levels_array      = $7EF420
!boss_clears                = $7EF440

!item_index                 = $7EF460
!doppler_access             = $7EF461
!heart_tanks_collected      = $7EF462
!upgrades_collected         = $7EF463
!ride_chip_collected        = $7EF464
!sub_tank_collected_array   = $7EF465

!pickup_array               = $7EF480

!hp_tank_state = $7EF4E0
!hp_tank_timer = $7EF4E1
!hp_tank_counter = $7EF4E1
!hp_tank_timer_2 = $7EF4E2
!hp_refill_state = $7EF4E4
!hp_refill_amount = $7EF4E5
!hp_refill_timer = $7EF4E6

!give_1up = $7EF4E7

!check = $7EF43D

!level_index = $1FAE
!weapon_array = $1FBC

!active_character = $0A8E

!unlocked_doppler_lab = !unlocked_levels_array+$0E

!blast_hornet_clear = !levels_completed_array+$02
!blizzard_buffalo_clear = !levels_completed_array+$0C
!gravity_beetle_clear = !levels_completed_array+$0A
!toxic_seahorse_clear = !levels_completed_array+$00
!volt_catfish_clear = !levels_completed_array+$04
!crush_crawfish_clear = !levels_completed_array+$06
!tunnel_rhino_clear = !levels_completed_array+$0E
!neon_tiger_clear = !levels_completed_array+$08

!sub_tank_array = $1FB7

!heart_tanks = $1FD4

!ride_chip = $1FD7

!upgrades = $1FD1

doppler_configuration = $2FFFF0
doppler_medal_count = $2FFFF1
doppler_weapon_count = $2FFFF2
doppler_armor_count = $2FFFF3
doppler_heart_tank_count = $2FFFF4
doppler_sub_tank_count = $2FFFF5
pickupsanity_configuration = $2FFFF7
starting_life_count = $2FFFF6
debug_infinite_hp = $2FFFFF

org $3CCE4B
    sprite_data_pointers:
        dw $CE6B    ; 00 - ?
        dw $D15C    ; 01 - Blast Hornet
        dw $D510    ; 02 - Blizzard Buffalo
        dw $D8B7    ; 03 - Gravity Beetle
        dw $DC90    ; 04 - Toxic Seahorse
        dw $E06A    ; 05 - Volt Catfish
        dw $E4BF    ; 06 - Crush Crawfish
        dw $E888    ; 07 - Tunnel Rhino
        dw $EC8D    ; 08 - Neon Tiger
        dw $EFC8    ; 09 - Vile's Stage
        dw $F1F3    ; 0A - Doppler Stage 1
        dw $F5BE    ; 0B - Doppler Stage 2
        dw $F878    ; 0C - Doppler Stage 3
        dw $FAEC    ; 0D - Doppler Stage 4
        dw $FBD2    ; 0E - Destroyed Doppler Stage 2
        dw $FE7E    ; 0F - Maverick Intro

; skips over Gold Armor checks
org $13C016
    bra +
org $13C031
    +   

; remap ram for capsules
org $13C03E
    jsr capsule_check_upgrades
org $13C045
;    jsr capsule_check_ride_chip
    and.l !ride_chip_collected
    bne +
    bra ++
org $13C06D
+
org $13C071
++   
;org $13C051
;    jsr capsule_check_upgrades
;org $13C056
;    jsr capsule_load_ride_chip
org $01F103
    jsr ride_chip_check_bank_01
org $01F23F
    jsr ride_chip_write_bank_01
org $02F50B
    jsr ride_chip_check_bank_02
org $039606
    jsr ride_chip_write_bank_03

;# Use ride armors without having chimera
org $03D75F
    bit #$0F

org $008036
    jsl init_ram

org $13E9C7
    jsr get_maverick_medal_toxic_seahorse_bank_13
org $13E4D7
    jsr check_toxic_seahorse_bank_13

org $39A14B
    jsr get_maverick_medal_blast_hornet_bank_39
org $00BEB2
    jsr check_blast_hornet_bank_00
org $07C479
    jsr check_blast_hornet_bank_07
org $399C85
    jsr check_blast_hornet_bank_39

org $13F0BE
    jsr get_maverick_medal_volt_catfish_bank_13
org $13EAAB
    jsr check_volt_catfish_bank_13
org $04E097
    jsr check_volt_catfish_bank_04
org $03C5C4
    jsr check_volt_catfish_bank_03
org $02FE80
    jsr check_volt_catfish_bank_02
org $00BEA7
    jsr check_volt_catfish_bank_00

org $03D5B3
    jsr get_maverick_medal_crush_crawfish_bank_03
org $03D088
    jsr check_crush_crawfish_bank_03

org $13E3AA
    jsr get_maverick_medal_neon_tiger_bank_13
org $13DCE6
    jsr check_neon_tiger_bank_13

org $13F7C1
    jsr get_maverick_medal_gravity_beetle_bank_13
org $13F27F
    jsr check_gravity_beetle_bank_13
org $07B03B
    jsr check_gravity_beetle_bank_07

org $03CD9C
    jsr get_maverick_medal_blizzard_buffalo_bank_03
org $03C8A7
    jsr check_blizzard_buffalo_bank_03

org $3FEB12
    jsr get_maverick_medal_tunnel_rhino_bank_3F
org $3FE629
    jsr check_tunnel_rhino_bank_3F

    ;# checks before
org $01CDD0  ; 01CDAD
    jsr check_vile_boss_count_bank_01
    ;# Checks during the level itself?
org $01F0EA ; 01EBD4
    jsr check_vile_boss_count_bank_01
    ;# Checks during the boss itself?
org $07E652 ; 07E49F
    jsr check_vile_boss_count_bank_07

    ;# Allow exiting a level at any time
org $00CF0C
   lda #$40
   nop


org $01E84A
    jsr remap_heart_tank_check
org $01E971
    remap_heart_tank_set:
        ora.l !heart_tanks_collected
        sta.l !heart_tanks_collected
        lda #$04
        sta $01
        rtl

org $01FF84
    remap_heart_tank_check:
        and.l !heart_tanks_collected
        rts 
    check_vile_boss_count_bank_01:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !levels_completed_array,x
        plb 
        rts 
    ride_chip_check_bank_01:
        and.l !ride_chip_collected
        rts 
    ride_chip_write_bank_01:
        phb 
        pea $7E7E
        plb 
        plb 
        tsb.w !ride_chip_collected
        plb 
        rts 
    upgrades_check_bank_01:
        lda.l !upgrades_collected
        rts 
    upgrades_write_bank_01:
        phb 
        pea $7E7E
        plb 
        plb 
        tsb.w !upgrades_collected
        plb 
        rts 
    sub_tank_check_bank_01:
        lda.l !sub_tank_collected_array,x
        rts 
    sub_tank_write_bank_01:
        sta.l !sub_tank_collected_array,x
        rts 


org $01DC33
    jsr sub_tank_check_bank_01
org $01DC3A
    jsr sub_tank_write_bank_01
org $01DAE1
    jsr upgrades_check_bank_01
org $01DC3F
    jsr upgrades_write_bank_01

org $01D82D
    jsl pickupsanity_hp
    nop 
org $01D53E
    jsl pickupsanity_weapon
    nop
org $01DAA1
    jsl pickupsanity_1up
    nop

org $00A4A5
    jsr check_portraits_on_menu_load
        
org $00FD19
    check_portraits_on_menu_load:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !levels_completed_array,x
        plb 
        rts 
    check_blast_hornet_bank_00:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !blast_hornet_clear
        plb 
        rts 
    check_volt_catfish_bank_00:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !volt_catfish_clear
        plb 
        rts 
    check_random_bank_00:
        lda.l !levels_completed_array,x
        rts 
    write_boss_clear_bank_00:
        sta.l !levels_completed_array-$02,x
        rts 

    

    warnpc $00FEF0



org $00AABA
    ;jsr write_boss_clear_bank_00
    nop #3

; infinite hp
org $008108
    jsl main_loop
    nop

org $038063
    doppler_unlock:
        lda.l !doppler_access
        eor #$FF
        and #$08
        sta $2C
        cmp #$08
        rtl 
    warnpc $038078
        

org $00C2CC
    
org $00c44a
    jsl boss_locking

org $2FF000
    init_ram:
        lda #$0000
    .clear
        ldx #$0100
    ..loop
        sta !levels_completed_array,x
        dex #2
        bpl ..loop
        lda #$DEAD
        sta !check
        sep #$30
        lda #$FF
        sta !doppler_access
        lda #$06
        rtl 

    boss_locking:
        jsl $038000
        beq .skip
        php 
        pha 
        phx 
        phy 
        lda $2A
        jsr divide_by_9
        ply 
        asl 
        tax 
        lda.l !unlocked_levels_array,x
        plx 
        cmp #$00
        bne .unlocked
        lda $02,s
        ora #$02
        sta $02,s
    .unlocked
        pla 
        plp 
    .skip
        rtl 


    divide_by_9:
        pha
        lsr
        lsr
        lsr
        adc $01,s
        ror
        adc $01,s 
        ror
        adc $01,s
        ror
        lsr
        lsr
        lsr
        ply
        rts 

    pickupsanity:
    .hp
        jsr .handle
        lda $09FF
        and #$7F
        rtl 
    .weapon
        jsr .handle
        lda $09FF
        and #$7F
        rtl 
    .1up
        jsr .handle
        lda #$09
        cmp $1FB4
        rtl 

    .handle
        lda $7E00D0
        cmp #$02
        bne .skip
        lda $0B
        bmi .process
    .skip
        rts
    .process
        phx 
        phy
        phb 
        phk 
        plb 
        php 
        rep #$30
        lda !level_index
        and #$00FF
        asl 
        tax 
        lda.w pickups_ptrs,x
        pha 
        ldy #$0000
    .loop
        lda ($01,s),y
        cmp #$FFFF
        beq .end
        iny #2
        cmp $0C
        bne .next
        lda ($01,s),y
        tax 
        sep #$20
        lda #$01
        sta.l !pickup_array,x
        rep #$20
    .end
        pla 
        plp 
        plb 
        ply 
        plx 
        rts
    .next
        iny #2
        bra .loop
        
    
    pickups:
        .intro
            dw $FA7A,$0000      ; Hunter Base - HP Pickup 1
            dw $FB65,$0001      ; Hunter Base - HP Pickup 2
            dw $FFFF
        .blast_hornet
            dw $FA6B,$0002      ; Blast Hornet Stage - HP Pickup 1
            dw $FB5B,$0003      ; Blast Hornet Stage - HP Pickup 2
            dw $FFFF
        .blizzard_buffalo
            dw $FA89,$0004      ; Blizzard Buffalo Stage - HP Pickup 1
            dw $FA75,$0005      ; Blizzard Buffalo Stage - HP Pickup 2
            dw $FB1A,$0006      ; Blizzard Buffalo Stage - HP Pickup 3
            dw $FB83,$0007      ; Blizzard Buffalo Stage - HP Pickup 4
            dw $FBB5,$0008      ; Blizzard Buffalo Stage - HP Pickup 5
            dw $FFFF
        .gravity_beetle
            dw $FA4D,$0009      ; Gravity Beetle Stage - HP Pickup 1
            dw $FB3D,$000A      ; Gravity Beetle Stage - HP Pickup 2
            dw $FB8D,$000B      ; Gravity Beetle Stage - Weapon Energy Pickup 1
            dw $FB92,$000C      ; Gravity Beetle Stage - HP Pickup 3
            dw $FB56,$000D      ; Gravity Beetle Stage - HP Pickup 4
            dw $FB51,$000E      ; Gravity Beetle Stage - 1up Pickup
            dw $FB7E,$000F      ; Gravity Beetle Stage - HP Pickup 5
            dw $FB83,$0010      ; Gravity Beetle Stage - Weapon Energy Pickup 2
            dw $FBDD,$0011      ; Gravity Beetle Stage - HP Pickup 6
            dw $FFFF
        .toxic_seahorse
            dw $FA9D,$0012      ; Toxic Seahorse Stage - HP Pickup 1
            dw $FA89,$0013      ; Toxic Seahorse Stage - HP Pickup 2
            dw $FBF6,$0014      ; Toxic Seahorse Stage - HP Pickup 3
            dw $FFFF
        .volt_catfish
            dw $FB01,$0015      ; Volt Catfish Stage - HP Pickup 1
            dw $FAFC,$0016      ; Volt Catfish Stage - HP Pickup 2
            dw $FC41,$0017      ; Volt Catfish Stage - HP Pickup 3
            dw $FBFB,$0018      ; Volt Catfish Stage - Weapon Energy Pickup 1
            dw $FC2D,$0019      ; Volt Catfish Stage - Weapon Energy Pickup 2
            dw $FC00,$001A      ; Volt Catfish Stage - HP Pickup 4
            dw $FB60,$001B      ; Volt Catfish Stage - Weapon Energy Pickup 3
            dw $FB6F,$001C      ; Volt Catfish Stage - HP Pickup 5
            dw $FFFF
        .crush_crawfish
            dw $FA5C,$001D      ; Crush Crawfish Stage - HP Pickup 1
            dw $FA66,$001E      ; Crush Crawfish Stage - HP Pickup 2
            dw $FB06,$001F      ; Crush Crawfish Stage - HP Pickup 3
            dw $FB60,$0020      ; Crush Crawfish Stage - HP Pickup 4
            dw $FB74,$0021      ; Crush Crawfish Stage - Weapon Energy Pickup
            dw $FB79,$0022      ; Crush Crawfish Stage - HP Pickup 5
            dw $FB7E,$0023      ; Crush Crawfish Stage - HP Pickup 6
            dw $FBFB,$0024      ; Crush Crawfish Stage - 1up Pickup 1
            dw $FC00,$0025      ; Crush Crawfish Stage - 1up Pickup 2
            dw $FFFF
        .tunnel_rhino
            dw $FAE3,$0026      ; Tunnel Rhino Stage - Weapon Energy Pickup
            dw $FB3D,$0027      ; Tunnel Rhino Stage - HP Pickup
            dw $FFFF
        .neon_tiger
            dw $FA39,$0028      ; Neon Tiger Stage - HP Pickup 1
            dw $FA98,$0029      ; Neon Tiger Stage - HP Pickup 2
            dw $FAA7,$002A      ; Neon Tiger Stage - HP Pickup 3
            dw $FFFF
        .vile
            dw $FA66,$002B      ; Vile Stage - HP Pickup 1
            dw $FA3E,$002C      ; Vile Stage - HP Pickup 2
            dw $FA61,$002D      ; Vile Stage - HP Pickup 3
            dw $FA39,$002E      ; Vile Stage - HP Pickup 4
            dw $FA89,$002F      ; Vile Stage - Weapon Energy Pickup
            dw $FAF7,$0030      ; Vile Stage - HP Pickup 5
            dw $FAC5,$0031      ; Vile Stage - HP Pickup 6
            dw $FACA,$0032      ; Vile Stage - HP Pickup 7
            dw $FAF2,$0033      ; Vile Stage - 1up Pickup
            dw $FB1F,$0034      ; Vile Stage - HP Pickup 8
            dw $FB38,$0035      ; Vile Stage - HP Pickup 9
            dw $FFFF
        .doppler_1
            dw $FA93,$0036      ; Dr. Doppler's Lab 1 - HP Pickup 1
            dw $FA98,$0037      ; Dr. Doppler's Lab 1 - Weapon Energy Pickup
            dw $FB92,$0038      ; Dr. Doppler's Lab 1 - HP Pickup 2
            dw $FFFF
        .doppler_2
            dw $FFFF
        .doppler_3
            dw $FAE3,$0039      ; Dr. Doppler's Lab 3 - HP Pickup
            dw $FFFF
        .doppler_4
            dw $FFFF
        .doppler_2_destroyed
            dw $FFFF
        .maverick_intro
            dw $FFFF

    .ptrs:
        dw .intro
        dw .blast_hornet
        dw .blizzard_buffalo
        dw .gravity_beetle
        dw .toxic_seahorse
        dw .volt_catfish
        dw .crush_crawfish
        dw .tunnel_rhino
        dw .neon_tiger
        dw .vile
        dw .doppler_1
        dw .doppler_2
        dw .doppler_3
        dw .doppler_4
        dw .doppler_2_destroyed
        dw .maverick_intro

    listener_blizzard_buffalo:
        jsl $03C861
        php 
        sep #$30
        ldx #$04        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$13        ; lab 3
    .nope
        jmp generic_listener

    listener_blast_hornet:
        jsl $399BA9
        php 
        sep #$30
        ldx #$02        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$1A        ; lab 3
    .nope
        jmp generic_listener

    listener_crush_crawfish:
        jsl $03D03D
        php 
        sep #$30
        ldx #$09        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$17        ; lab 3
    .nope
        jmp generic_listener

    listener_tunnel_rhino:
        jsl $3FE5E4
        php 
        sep #$30
        ldx #$0A        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$15        ; lab 3
    .nope
        jmp generic_listener

    listener_neon_tiger:
        jsl $13DCA0
        php 
        sep #$30
        ldx #$0C        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$18        ; lab 3
    .nope
        jmp generic_listener

    listener_toxic_seahorse:
        jsl $13E493
        php 
        sep #$30
        ldx #$06        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$14        ; lab 3
    .nope
        jmp generic_listener

    listener_volt_catfish:
        jsl $13EA67
        php 
        sep #$30
        ldx #$08        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$16        ; lab 3
    .nope
        jmp generic_listener

    listener_gravity_beetle:
        jsl $13F239
        php 
        sep #$30
        ldx #$05        ; regular
        lda !level_index
        cmp #$0C
        bne .nope
        ldx #$19        ; lab 3
    .nope
        jmp generic_listener

    listener_press_disposer:
        jsl $13C5FD
        php 
        sep #$30
        ldx #$0E
        jmp generic_listener

    listener_mosquitus:
        jsl $0891F2
        php 
        sep #$30
        ldx #$11
        jmp generic_listener

    listener_vile:
        jsl $05A2D2
        php 
        sep #$30
        lda !level_index
        cmp #$0B
        bne .nope
        ldx #$10        ; regular
        jmp generic_listener
    .nope
        plp 
        rtl 
        
    listener_worm_seeker_r:
        jsl $399225
        php 
        sep #$30
        ldx #$0D
        jmp generic_listener

    listener_doppler:
        jsl $13D58A
        php 
        sep #$30
        ldx #$12
        jmp generic_listener

    listener_rex_2000:
        jsl $3CCA25
        php 
        sep #$30
        ldx #$0F
        jmp generic_listener

    listener_volt_kurageil:
        jsl $3CB5FD
        php 
        sep #$30
        ldx #$10
        jmp generic_listener

    listener_godkarmachine:
        jsl $32F2E9
        php 
        sep #$30
        ldx #$0E
        jmp generic_listener

    listener_hell_crusher:
        jsl $3CA000
        php 
        sep #$30
        ldx #$0B
        jmp generic_listener

    listener_hotareeca:
        jsl $3DF884
        php 
        sep #$30
        ldx #$07
        jmp generic_listener

    listener_shurikein:
        jsl $3CBECE
        php 
        sep #$30
        ldx #$03
        jmp generic_listener

    listener_maoh:
        jsl $02E7DE
        php 
        sep #$30
        ldx #$00
        jmp generic_listener

    listener_mac:
        jsl $08B7B1
        php 
        sep #$30
        ldx #$01
    generic_listener:
        lda $01
        cmp #$04
        bne .nope
        lda #$01
        sta.l !boss_clears,x
    .nope
        plp 
        rtl

    main_loop:
        .unlock_doppler
            lda $7E00D0
            cmp #$02
            bcc .reset
            phb 
            pea $7E7E
            plb 
            plb 
            lda.l doppler_configuration
            asl 
            tax 
            jsr (.ptrs,x)
            plb 
            bra +
        .reset
            lda #$00
            sta !item_index

        +

        .increment_hp
            lda $7E00D0
            cmp #$02
            bcc ..skip
            jsl handle_heart_tank_upgrade
            jsl handle_hp_refill
            jsl give_1up
        ..skip


        .infinite_hp
            lda.l debug_infinite_hp
            beq ..nope 
            lda $09FF
            cmp #$07
            bcs ..nope
            lda $1FD2
            sta $09FF
        ..nope

        .return_to_loop
            inc $09CB
            ldx #$00
            rtl 

    .ptrs
        dw .multiworld
        dw .require_medals
        dw .require_weapons
        dw .require_armor_upgrades
        dw .require_heart_tanks
        dw .require_sub_tanks

    .multiworld
        rts
    .require_medals
        lda #$00
        ldx #$0E
    ..loop
        bit.w !levels_completed_array,x
        bvc $01
        inc 
        dex #2
        bpl ..loop
        cmp.l doppler_medal_count
        bcs ..enable
        jmp .disable
    ..enable 
        jmp .enable

    .require_weapons
        lda #$00
        ldx #$0E
    ..loop
        bit.w !weapon_array,x
        bvc $01
        inc 
        dex #2
        bpl ..loop
        cmp.l doppler_weapon_count
        bcs ..enable
        jmp .disable
    ..enable 
        jmp .enable

    .require_armor_upgrades
        lda !ride_chip
        and #$F0
        pha 
        lda !upgrades
        and #$0F
        ora $01,s
        sta $01,s
        ldy #$00
        ldx #$07
    ..loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ..loop
        pla 
        tya 
        cmp.l doppler_armor_count
        bcs ..enable
        jmp .disable
    ..enable 
        jmp .enable

    .require_heart_tanks
        ldy #$00
        ldx #$07
    ..loop
        lda.w !heart_tanks
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ..loop
        tya 
        cmp.l doppler_heart_tank_count
        bcs ..enable
        jmp .disable
    ..enable 
        jmp .enable

    .require_sub_tanks
        lda !upgrades
        and #$F0
        pha 
        ldy #$00
        ldx #$07
    ..loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ..loop
        pla 
        tya 
        cmp.l doppler_sub_tank_count
        bcs ..enable
        jmp .disable
    ..enable 
        jmp .enable

    .disable 
        lda #$FF
        sta !doppler_access
        rts 
    .enable
        lda #$00
        sta !doppler_access
        lda #$01
        sta !unlocked_doppler_lab
        rts

    .bit_check
        db $01,$02,$04,$08,$10,$20,$40,$80

    handle_heart_tank_upgrade:
        lda !hp_tank_state
        tax 
        jmp (.ptrs,x)
    .ptrs
        dw .waiting
        dw .init
        dw .wait_for_anim
        dw .increment_hp
        dw .end

    .waiting
        rtl 
    .init
        lda $1FD2
        cmp #$20
        bcc ..continue
        lda #$00
        sta !hp_tank_state
        rtl
    ..continue
        lda #$04
        sta !hp_tank_state
        lda #$50
        sta !hp_tank_timer
        lda #$01
        sta $1F25
        sta $1F26
        sta $1F27
        sta $1F28
        sta $1F29
        sta $1F2A
        sta $1F2B
        sta $09E6
        jsl $04D0E8
        lda #$19
        jml $01802B     ; sfx
    
    .wait_for_anim
        lda !hp_tank_timer
        dec 
        sta !hp_tank_timer
        bne ..not_yet
        lda #$06
        sta !hp_tank_state
        lda #$02
        sta !hp_tank_counter
        sta !hp_tank_timer_2
    ..not_yet
        rtl 

    .increment_hp
        lda $09FF
        and #$7F
        beq ..not_done_inc
        lda !hp_tank_timer_2
        dec 
        sta !hp_tank_timer_2
        bne ..not_done_inc
        lda #$04
        sta !hp_tank_timer_2
        lda $1FD2
        inc 
        cmp #$20
        bcc ..not_max
        lda #$08
        sta !hp_tank_state
        lda #$20
    ..not_max
        sta $1FD2
        inc $09FF
        lda #$80
        tsb $09FF
        lda #$15
        jsl $01802B     ; sfx
        lda !hp_tank_counter
        dec 
        sta !hp_tank_counter
        bne ..not_done_inc
        lda #$08
        sta !hp_tank_state
    ..not_done_inc
        jml $01EA24
    .end
        stz $1F25
        stz $1F26
        stz $1F27
        stz $1F28
        stz $1F29
        stz $1F2A
        stz $1F2B
        lda #$00
        sta !hp_tank_state
        jsl $04D130
        jml $01EA35

    handle_hp_refill:
        lda !hp_refill_state
        tax 
        jmp (.ptrs,x)
    .ptrs
        dw .waiting
        dw .init
        dw .increment_hp
        dw .end
        dw .end_tank

    .waiting
        rtl
    .init
        lda $09FF
        and #$7F
        cmp $1FD2
        beq ..max_hp
        jmp ..not_max
    ..max_hp
        lda !hp_refill_amount
        dec 
        dec 
        sta $0000
        ldx #$00
    ..loop
        lda $1FB7,x
        bpl ..next_tank
        cmp #$8E
        bcs ..next_tank
        pha 
        lda #$16
        jsl $01802B
        pla 
        inc 
        sta $1FB7,x
        cmp #$8E
        beq ..max_tank
        ldy $0000
        bne ..done_filling
        inc 
        sta $1FB7,x
        cmp #$8E
        beq ..max_tank
        lda #$06
        sta !hp_refill_state
        lda #$04
        sta !hp_refill_timer
        rtl 
    ..next_tank
        inx 
        cpx #$04
        bne ..loop
    ..done_filling
        lda #$00
        sta !hp_refill_state
        rtl 
    ..max_tank
        lda #$17
        jsl $01802B
        bra ..done_filling

    ..not_max
        lda #$04
        sta !hp_refill_state
        lda #$04
        sta !hp_refill_timer
        lda #$01
        sta $1F25
        sta $1F26
        sta $1F27
        sta $1F28
        sta $1F29
        sta $1F2A
        sta $1F2B
        sta $09E6
        lda #$7F
        sta $1F4F
        jsl $04D0E8
        rtl 

    .increment_hp
        lda $09FF
        and #$7F
        beq ..force_finish
        lda !hp_refill_timer
        dec 
        sta !hp_refill_timer
        bne ..not_done_inc
        lda #$04
        sta !hp_refill_timer
        lda $09FF
        and #$7F
        inc 
        cmp $1FD2
        bcc ..not_max
        lda #$06
        sta !hp_refill_state
        lda $1FD2
    ..not_max
        ora #$80
        sta $09FF
        lda #$15
        jsl $01802B     ; sfx
        lda !hp_refill_amount
        dec 
        sta !hp_refill_amount
        bne ..not_done_inc
    ..force_finish
        lda #$06
        sta !hp_refill_state
    ..not_done_inc
        rtl 
    .end
        stz $1F25
        stz $1F26
        stz $1F27
        stz $1F28
        stz $1F29
        stz $1F2A
        stz $1F2B
        lda #$00
        sta !hp_refill_state
        jsl $04D130
        rtl 

    .end_tank
        lda !hp_refill_timer
        dec
        sta !hp_refill_timer
        bne ..not_yet
        lda #$16
        jsl $01802B
        lda #$00
        sta !hp_refill_state
    ..not_yet
        rtl 

    give_1up:
        lda !give_1up
        beq .already_full
        dec 
        sta !give_1up
        lda $1FB4
        cmp #$09
        bcs .already_full
    .give
        inc $1FB4
        lda #$1A
        jsl $01802B
    .already_full
        rtl 

    print pc

    warnpc $2FFFF0

org $008FFE
    load_to_map_from_title_screen:
        stz $09D9
        stz $09DA
        stz $09DB

        phd 
        pea $0000
        pld 
        jsr $8641
        lda #$07
        tsb $A3
        jsr $8162
        pld 

        jsl load_map_extended
        jmp $9987
    warnpc $009028

org $00FCF1
    jsl listener_mac
org $00FCEC
    jsl listener_vile
org $00FCCE
    jsl listener_mosquitus
org $00FCC9
    jsl listener_press_disposer
org $00FCC4
    jsl listener_gravity_beetle
org $00FCBF
    jsl listener_volt_catfish
org $00FCBA
    jsl listener_toxic_seahorse
org $00FCB5
    jsl listener_neon_tiger
org $00FCB0
    jsl listener_tunnel_rhino
org $00FCAB
    jsl listener_crush_crawfish
org $00FCA6
    jsl listener_blast_hornet
org $00FCA1
    jsl listener_blizzard_buffalo
org $00FC9C
    jsl listener_rex_2000
org $00FC92
    jsl listener_shurikein
org $00FC79
    jsl listener_volt_kurageil
org $00FC6F
    jsl listener_doppler
org $00FC56
    jsl listener_godkarmachine
org $00FC51
    jsl listener_hotareeca
org $00FBF7
    jsl listener_hell_crusher
org $00FBCA
    jsl listener_worm_seeker_r
org $00FC97
    jsl listener_maoh



org $13FA6E
    check_toxic_seahorse_bank_13:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !toxic_seahorse_clear
        plb 
        rts 
    get_maverick_medal_toxic_seahorse_bank_13:
        sta.l !toxic_seahorse_clear
        rts
    check_volt_catfish_bank_13:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !volt_catfish_clear
        plb 
        rts 
    get_maverick_medal_volt_catfish_bank_13:
        sta.l !volt_catfish_clear
        rts 
    check_neon_tiger_bank_13:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !neon_tiger_clear
        plb 
        rts 
    get_maverick_medal_neon_tiger_bank_13:
        sta.l !neon_tiger_clear
        rts
    check_gravity_beetle_bank_13:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !gravity_beetle_clear
        plb 
        rts 
    get_maverick_medal_gravity_beetle_bank_13:
        sta.l !gravity_beetle_clear
        rts 
    capsule_check_ride_chip:
        and.l !ride_chip_collected
        rts 
    capsule_check_upgrades:
        and.l !upgrades_collected
        rts 
    capsule_load_ride_chip:
        lda.l !ride_chip_collected
        rts 

org $03D879
    jsl ride_armor_better_menu


org $03FF00
    ride_armor_better_menu:
        sta $35
        lda $1FD7
        bit #$01
        beq +
        lda #$00
        sta $34
        rtl
    +   
        lda $1FD7
        bit #$02
        beq +
        lda #$01
        sta $34
        rtl
    +   
        lda $1FD7
        bit #$04
        beq +
        lda #$02
        sta $34
        rtl
    +   
        lda #$03
        sta $34
        rtl
    check_volt_catfish_bank_03:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !volt_catfish_clear
        plb 
        rts 
    check_crush_crawfish_bank_03:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !crush_crawfish_clear
        plb 
        rts 
    get_maverick_medal_crush_crawfish_bank_03:
        sta.l !crush_crawfish_clear
        rts 
    check_blizzard_buffalo_bank_03:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !blizzard_buffalo_clear
        plb 
        rts 
    get_maverick_medal_blizzard_buffalo_bank_03:
        sta.l !blizzard_buffalo_clear
        rts 
    ride_chip_write_bank_03:
        phb 
        pea $7E7E
        plb 
        plb 
        tsb.w !ride_chip_collected
        plb 
        rts 

org $05C833
    jsr ride_chip_write_bank_05
org $05C5E0
    jsr ride_chip_check_bank_05
org $05C820
    jsr upgrades_write_bank_05

org $05FBF3
    ride_chip_write_bank_05:
        phb 
        pea $7E7E
        plb 
        plb 
        tsb.w !ride_chip_collected
        plb 
        rts 
    ride_chip_check_bank_05:
        lda.l !ride_chip_collected
        rts 
    upgrades_write_bank_05:
        phb 
        pea $7E7E
        plb 
        plb 
        tsb.w !upgrades_collected
        plb 
        rts 

    load_map_extended:
        lda #$02
        sta $D0
        stz $D1
        sta $1FD3
        lda #$01
        sta $D2
        stz $D3

        lda.l starting_life_count
        sta $1FB4 
        rtl 

;org $04A5B5
;    jsr level_clear_load_ram
;org $04A5C7
;    jsr level_clear_store_ram


org $04FFA5
    check_volt_catfish_bank_04:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !volt_catfish_clear
        plb 
        rts 
    level_clear_load_ram:
        lda.l !levels_completed_array-$03,x
        rts 
    level_clear_store_ram:
        sta.l !levels_completed_array-$03,x
        rts 


org $07FFD8
    check_vile_boss_count_bank_07:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !levels_completed_array,x
        plb 
        rts 
    check_gravity_beetle_bank_07:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !gravity_beetle_clear
        plb 
        rts 
    check_blast_hornet_bank_07:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !blast_hornet_clear
        plb 
        rts 

org $3FF4BE
    check_tunnel_rhino_bank_3F:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !tunnel_rhino_clear
        plb 
        rts 
    get_maverick_medal_tunnel_rhino_bank_3F:
        sta.l !tunnel_rhino_clear
        rts 


org $39FFE6
    get_maverick_medal_blast_hornet_bank_39:
        sta.l !blast_hornet_clear
        rts 
    check_blast_hornet_bank_39:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !blast_hornet_clear
        plb 
        rts 

org $02FF73
    ride_chip_check_bank_02:
        and.l !ride_chip
        rts 
    check_volt_catfish_bank_02:
        phb 
        pea $7E7E
        plb 
        plb 
        bit.w !volt_catfish_clear
        plb 
        rts 


