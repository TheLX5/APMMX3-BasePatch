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
!vile_access                = $7EF466
!energy_link_send_packet    = $7EF467
!play_sfx_flag              = $7EF469
!play_sfx_num               = $7EF46A

!victory = $7EF46B
!map_portraits_array        = $7EF500
!map_portraits_flag         = $7EF500

!pickup_array               = $7EF480

!hp_tank_state = $7EF4E0
!hp_tank_timer = $7EF4E1
!hp_tank_counter = $7EF4E1
!hp_tank_timer_2 = $7EF4E2
!hp_refill_state = $7EF4E4
!hp_refill_amount = $7EF4E5
!hp_refill_timer = $7EF4E6

!give_1up = $7EF4E7

!giving_item = $7EF4FF

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

!x_speed = $09F2
!y_speed = $09F4

doppler_configuration = $2FFFE0
doppler_medal_count = $2FFFE1
doppler_weapon_count = $2FFFE2
doppler_armor_count = $2FFFE3
doppler_heart_tank_count = $2FFFE4
doppler_sub_tank_count = $2FFFE5
pickupsanity_configuration = $2FFFE7
starting_life_count = $2FFFE6
vile_configuration = $2FFFE8
vile_medal_count = $2FFFE9
vile_weapon_count = $2FFFEA
vile_armor_count = $2FFFEB
vile_heart_tank_count = $2FFFEC
vile_sub_tank_count = $2FFFED
logic_boss_weakness = $2FFFEE
logic_vile_required = $2FFFEF
logic_z_saber = $2FFFF0
doppler_lab_1_boss = $2FFFF1
doppler_lab_2_boss = $2FFFF2
doppler_lab_3_boss_rematch_count = $2FFFF3
bit_medal_count = $2FFFF4
byte_medal_count = $2FFFF5
disable_charge_freeze = $2FFFF6
energy_link = $2FFFF7
death_link = $2FFFF8
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

; Disable capsules giving out items and cosmetic changes
org $05C7C7
    dw $C81B  ;$C7D9    ; helmet upgrade
    dw $C81B  ;$C7E0    ; arm upgrade
    dw $C81B  ;$C7F3    ; body upgrade
    dw $C81B  ;$C808    ; leg upgrade
    dw $C82E  ;$C82E    ; helmet chip
    dw $C82E  ;$C824    ; arm chip
    dw $C82E  ;$C82E    ; body chip
    dw $C82E  ;$C82E    ; leg chip
    dw $C82E  ;$C824    ; gold armor

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
;#org $01CDD0  ; 01CDAD
;#    jsr check_vile_boss_count_bank_01
    ;# Checks during the level itself?
;#org $01F0EA ; 01EBD4
;#    jsr check_vile_boss_count_bank_01
    ;# Checks during the boss itself?
;#org $07E652 ; 07E49F
;#    jsr check_vile_boss_count_bank_07

;# Rewrite Vile access logic
org $01CDAD
    vile_access_1:
        lda !vile_access
        bpl code_01CDC2
        jmp $CDBF
org $01CDC2
    code_01CDC2:

org $01EBD4
    vile_access_2:
        lda !vile_access
        bmi code_01EBE6
        jmp $EBEA
org $01EBE6
    code_01EBE6:

org $07E49F
    vile_access_3:
        lda !vile_access
        bmi code_07E4F7
        jmp $E4B1
org $07E4F7
    code_07E4F7:



    ;# Allow exiting a level at any time
org $00CEF9
    nop #4
org $00CF0C
+
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

org $3CC491
    jsl bit_byte_level_completed
org $078F85
    jsl bit_byte_level_completed
org $3CC497
    jsl bit_byte_medal_count
org $078F8B
    jsl bit_byte_medal_count
org $078F8F
    jml bit_medal_constraints
org $3CC49B
    jml byte_medal_contraints


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

org $00C4E9
    jml lab_2_stage_special_case


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
        sta !vile_access
        lda #$06
        rtl 

;########################################################################################

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

;########################################################################################

lab_2_stage_special_case:
    lda.l doppler_lab_2_boss
    beq .return
    lda #$0E
    sta $1FAE
.return
    jml $00C4F5

;########################################################################################

bit_byte_level_completed:
        ldx !level_index
        lda.l !levels_completed_array,x
        bvc .nope
        sec  
        rtl
    .nope
        clc 
        rtl 

bit_byte_medal_count:
        phb 
        pea $7E7E
        plb 
        plb 
        lda #$00
        ldx #$0E
    .loop
        bit.w !levels_completed_array,x
        bvc $01
        inc 
        dex #2
        bpl .loop
        plb 
        rtl 

bit_medal_constraints:
        pha 
        lda.l byte_medal_count
        dec 
        pha 
        lda $02,s
        cmp $01,s
        beq .force
        cmp.l byte_medal_count
        bpl .ignore
        cmp.l bit_medal_count
        bmi .ignore
    .check
        pla 
        pla 
        jml $078F9B
    .ignore
        pla 
        pla 
        jml $078FB4
    .force
        pla 
        pla 
        jml $078FAD

byte_medal_contraints:
        cmp #$07
        beq .force
        cmp.l byte_medal_count
        bmi .ignore
        jml $3CC4A3
    .ignore
        jml $3CC4BE
    .force
        jml $3CC4B7

;########################################################################################

    pickupsanity:
    .hp
        jsr .handle
        jsr .add_el_packet
        lda $09FF
        and #$7F
        rtl 
    .weapon
        jsr .handle
        jsr .add_el_packet
        lda $09FF
        and #$7F
        rtl 
    .1up
        rep #$20
        lda !energy_link_send_packet
        clc 
        adc #$00C0
        sta !energy_link_send_packet
        sep #$20
        jsr .handle
        lda #$09
        cmp $1FB4
        rtl 
    
    .add_el_packet
        rep #$20
        lda $0B
        and #$007F
        bne ..small
    ..large
        lda !energy_link_send_packet
        clc 
        adc #$0020
        bra ..end
    ..small
        lda !energy_link_send_packet
        clc 
        adc #$0008
    ..end
        sta !energy_link_send_packet
        sep #$20
        rts 

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

;########################################################################################

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
        lda $0B
        bne .nope
        ldx #$0E
        jmp generic_listener
    .nope
        plp 
        rtl 

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
        lda $0B
        beq .nope
        lda !level_index
        cmp #$0E
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
        lda $0B
        bne .nope 
        ldx #$10
        jmp generic_listener
    .nope
        plp
        rtl 

    listener_godkarmachine:
        jsl $32F2E9
        php 
        sep #$30
        lda $0B
        bne .nope
        ldx #$0E
        jmp generic_listener
    .nope
        plp 
        rtl 

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
        lda $0B
        beq generic_listener_nope
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

;########################################################################################

main_loop:
        lda $00D0
        beq .reset
        cmp #$02
        bne .return
    .playable
        ldx $00D1
        cpx #$08
        bcs .return
        jsr (.game_ptrs,x)
    .return
        inc $09CB
        ldx #$00
        rtl
    .reset 
        lda #$00
        sta !item_index
        bra .return

    .game_ptrs
        dw map
        dw level_intro
        dw level
        dw credits

;##########################################################

credits:
        lda !doppler_access
        bne .not_yet
        lda #$01
        sta !victory
    .not_yet
        rts 

;##########################################################

level_intro:
        rts

;##########################################################

map:
        jsr playback_sfx
        lda #$00
        sta !giving_item

        lda $1E59
        cmp #$04
        bne .return
        lda $7E2027
        cmp #$22
        bne +
    .return
        rts 
    +   
        ; modify ram code to allow our data be there
        lda #$22
        sta $7E2027
        lda.b #hack_portraits
        sta $7E2028
        lda.b #hack_portraits>>8
        sta $7E2029
        lda.b #hack_portraits>>16
        sta $7E202A
        lda #$EA
        sta $7E202B
        lda #$EA
        sta $7E202C

        ldx #$1F
        lda #$FF
    .loop
        sta.l !map_portraits_array,x
        dex 
        bpl .loop
        rts 


hack_portraits:
        lda $00D1
        beq .safety
    ;# restore
        lda #$AD
        sta $7E2027
        lda #$CE
        sta $7E2028
        lda #$09
        sta $7E2029
        lda #$0D 
        sta $7E202A
        lda #$D0
        sta $7E202B
        lda #$09
        sta $7E202C
    
        lda $09CE
        ora $09D0
        rtl 

    .safety
        php 
        phb 
        phk 
        plb 
        sep #$30
        lda $09CB
        and #$0F
        asl 
        tax 
        lda.l .offsets,x
        bne +
        jmp ..skip
    +   
        lda !unlocked_levels_array,x
        beq ..locked
    ..unlocked
        phx 
        lda.l .completed_indexes,x
        tax 
        lda.l !levels_completed_array,x
        plx 
        ora !unlocked_levels_array,x
        cmp !map_portraits_array,x
        beq ..skip
        sta !map_portraits_array,x
        ldy #$80
        sty $2115
        cmp #$00
        rep #$20
        phx 
        lda.l .completed_indexes,x
        tax 
        lda.l !levels_completed_array,x
        plx 
        and #$0040
        bne ..beaten
    ..pending
        lda.l .portrait_ptrs,x
        bra ..shared
    ..beaten
        lda.l .completed_portrait_ptrs,x
        bra ..shared
    ..locked
        cmp !map_portraits_array,x
        beq ..skip
        sta !map_portraits_array,x
        rep #$20
        lda.w #.blank_portrait
    ..shared 
        pha 
        phx
        lda.l .offsets,x
        pha 
        sta $2116
        ldx #$00
        ldy #$00
    ...loop
        lda ($04,s),y
        sta $2118
        iny #2
        inx 
        cpx #$06
        bne ...loop
        cpy #$3B
        bcs ...break
        ldx #$00
        lda $01,s
        clc 
        adc #$0020
        sta $01,s
        sta $2116
        bra ...loop
    ...break
        pla 
        plx 
        pla 
        sep #$20
    ..skip
        plb 
        plp 
        lda $09CE
        ora $09D0
        rtl 

    .offsets
        dw $5841    ;# Blast hornet
        dw $5847    ;# Blizzard Buffalo
        dw $FFFF    ;# Blank
        dw $5853    ;# Gravity Beetle
        dw $5859    ;# Toxic Seahorse
        dw $5AA1    ;# Volt Catfish
        dw $5AA7    ;# Crush Crawfish
        dw $FFFF    ;# Blank
        dw $5AB3    ;# Tunnel Rhino
        dw $5AB9    ;# Neon Tiger
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank

    .completed_indexes
        dw $0002
        dw $000C
        dw $FFFF
        dw $000A
        dw $0000
        dw $0004
        dw $0006
        dw $FFFF
        dw $000E
        dw $0008
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank
        dw $FFFF    ;# Blank

    .portrait_ptrs
        dw .blast_hornet_portrait
        dw .blizzard_buffalo_portrait
        dw $FFFF
        dw .gravity_beetle_portrait
        dw .toxic_seahorse_portrait
        dw .volt_catfish_portrait
        dw .crush_crawfish_portrait
        dw $FFFF
        dw .tunnel_rhino_portrait
        dw .neon_tiger_portrait

    .completed_portrait_ptrs
        dw .blast_hornet_completed_portrait
        dw .blizzard_buffalo_completed_portrait
        dw $FFFF
        dw .gravity_beetle_completed_portrait
        dw .toxic_seahorse_completed_portrait
        dw .volt_catfish_completed_portrait
        dw .crush_crawfish_completed_portrait
        dw $FFFF
        dw .tunnel_rhino_completed_portrait
        dw .neon_tiger_completed_portrait

    .blank_portrait
        ..row_1
            dw $140F,$140F,$140F,$140F,$140F,$140F
        ..row_2
            dw $140F,$140F,$140F,$140F,$140F,$140F
        ..row_3
            dw $140F,$140F,$140F,$140F,$140F,$140F
        ..row_4
            dw $140F,$140F,$140F,$140F,$140F,$140F
        ..row_5
            dw $140F,$140F,$140F,$140F,$140F,$140F

    .blast_hornet_portrait
        ..row_1
            dw $1415,$1416,$1417,$1418,$1419,$141A
        ..row_2
            dw $1424,$1425,$1426,$1427,$1428,$1429
        ..row_3
            dw $1434,$1435,$1436,$1437,$1438,$1439
        ..row_4
            dw $1444,$1445,$1446,$1447,$1448,$1449
        ..row_5
            dw $1453,$1454,$1455,$1456,$1457,$1458
    .blizzard_buffalo_portrait
        ..row_1
            dw $1C0F,$1C1B,$1C1C,$1C1D,$1C1E,$1C1F
        ..row_2
            dw $1C2A,$1C2B,$1C2C,$1C2D,$1C2E,$1C2F
        ..row_3
            dw $1C3A,$1C3B,$1C3C,$1C3D,$1C3E,$1C3F
        ..row_4
            dw $1C4A,$1C4B,$1C4C,$1C4D,$1C4E,$1C4F
        ..row_5
            dw $1C59,$1C5A,$1C5B,$1C5C,$1C5D,$1C5E
    .gravity_beetle_portrait
        ..row_1
            dw $14E8,$14E9,$14EA,$14EB,$14EC,$14ED
        ..row_2
            dw $14F6,$14F7,$14F8,$14F9,$14FA,$14FB
        ..row_3
            dw $1504,$1505,$1506,$1507,$1508,$1509
        ..row_4
            dw $1512,$1513,$1514,$1515,$1516,$1517
        ..row_5
            dw $1521,$1522,$1523,$1524,$1525,$140F
    .toxic_seahorse_portrait
        ..row_1
            dw $18EE,$18EF,$18F0,$18F1,$18F2,$18F3
        ..row_2
            dw $18FC,$18FD,$18FE,$18FF,$1900,$1901
        ..row_3
            dw $190A,$190B,$190C,$190D,$190E,$190F
        ..row_4
            dw $1918,$1919,$191A,$191B,$191C,$191D
        ..row_5
            dw $1926,$1927,$1928,$1929,$192A,$192B
    .volt_catfish_portrait
        ..row_1
            dw $15E8,$15E9,$15EA,$15EB,$15EC,$15ED
        ..row_2
            dw $15F7,$15F8,$15F9,$15FA,$15FB,$15FC
        ..row_3
            dw $1606,$1607,$1608,$1609,$160A,$160B
        ..row_4
            dw $1615,$1616,$1617,$1618,$1619,$161A
        ..row_5
            dw $1624,$1625,$1626,$1627,$1628,$1629
    .crush_crawfish_portrait
        ..row_1
            dw $1DEE,$1DEF,$1DF0,$1DF1,$1DF2,$1DF3
        ..row_2
            dw $1DFD,$1DFE,$1DFF,$1E00,$1E01,$1E02
        ..row_3
            dw $1E0C,$1E0D,$1E0E,$1E0F,$1E10,$1E11
        ..row_4
            dw $1E1B,$1E1C,$1E1D,$1E1E,$1E1F,$1E20
        ..row_5
            dw $1E2A,$1E2B,$1E2C,$1E2D,$1E2E,$1E2F
    .tunnel_rhino_portrait
        ..row_1
            dw $1A9F,$1AA0,$1AA1,$1AA2,$1AA3,$1AA4
        ..row_2
            dw $1AAE,$1AAF,$1AB0,$1AB1,$1AB2,$1AB3
        ..row_3
            dw $1ABD,$1ABE,$1ABF,$1AC0,$1AC1,$1AC2
        ..row_4
            dw $1ACA,$1ACB,$1ACC,$1ACD,$1ACE,$1ACF
        ..row_5
            dw $1AD7,$1AD8,$1AD9,$1ADA,$1ADB,$1ADC
    .neon_tiger_portrait
        ..row_1
            dw $1EA5,$1EA6,$1EA7,$1EA8,$1EA9,$1EAA
        ..row_2
            dw $1EB4,$1EB5,$1EB6,$1EB7,$1EB8,$1EB9
        ..row_3
            dw $1EC3,$1EC4,$1EC5,$1EC6,$1EC7,$1EC8
        ..row_4
            dw $1ED0,$1ED1,$1ED2,$1ED3,$1ED4,$1ED5
        ..row_5
            dw $1EDD,$1EDE,$1EDF,$1EE0,$1EE1,$1EE2

    .blast_hornet_completed_portrait
        ..row_1
            dw $0415,$0416,$0417,$0418,$0419,$041A
        ..row_2
            dw $0424,$0425,$0426,$0427,$0428,$0429
        ..row_3
            dw $0434,$0435,$0436,$0437,$0438,$0439
        ..row_4
            dw $0444,$0445,$0446,$0447,$0448,$0449
        ..row_5
            dw $0453,$0454,$0455,$0456,$0457,$0458
    .blizzard_buffalo_completed_portrait
        ..row_1
            dw $040F,$041B,$041C,$041D,$041E,$041F
        ..row_2
            dw $042A,$042B,$042C,$042D,$042E,$042F
        ..row_3
            dw $043A,$043B,$043C,$043D,$043E,$043F
        ..row_4
            dw $044A,$044B,$044C,$044D,$044E,$044F
        ..row_5
            dw $0459,$045A,$045B,$045C,$045D,$045E
    .gravity_beetle_completed_portrait
        ..row_1
            dw $04E8,$04E9,$04EA,$04EB,$04EC,$04ED
        ..row_2
            dw $04F6,$04F7,$04F8,$04F9,$04FA,$04FB
        ..row_3
            dw $0504,$0505,$0506,$0507,$0508,$0509
        ..row_4
            dw $0512,$0513,$0514,$0515,$0516,$0517
        ..row_5
            dw $0521,$0522,$0523,$0524,$0525,$040F
    .toxic_seahorse_completed_portrait
        ..row_1
            dw $04EE,$04EF,$04F0,$04F1,$04F2,$04F3
        ..row_2
            dw $04FC,$04FD,$04FE,$04FF,$0500,$0501
        ..row_3
            dw $050A,$050B,$050C,$050D,$050E,$050F
        ..row_4
            dw $0518,$0519,$051A,$051B,$051C,$051D
        ..row_5
            dw $0526,$0527,$0528,$0529,$052A,$052B
    .volt_catfish_completed_portrait
        ..row_1
            dw $05E8,$05E9,$05EA,$05EB,$05EC,$05ED
        ..row_2
            dw $05F7,$05F8,$05F9,$05FA,$05FB,$05FC
        ..row_3
            dw $0606,$0607,$0608,$0609,$060A,$060B
        ..row_4
            dw $0615,$0616,$0617,$0618,$0619,$061A
        ..row_5
            dw $0624,$0625,$0626,$0627,$0628,$0629
    .crush_crawfish_completed_portrait
        ..row_1
            dw $05EE,$05EF,$05F0,$05F1,$05F2,$05F3
        ..row_2
            dw $05FD,$05FE,$05FF,$0600,$0601,$0602
        ..row_3
            dw $060C,$060D,$060E,$060F,$0610,$0611
        ..row_4
            dw $061B,$061C,$061D,$061E,$061F,$0620
        ..row_5
            dw $062A,$062B,$062C,$062D,$062E,$062F
    .tunnel_rhino_completed_portrait
        ..row_1
            dw $069F,$06A0,$06A1,$06A2,$06A3,$06A4
        ..row_2
            dw $06AE,$06AF,$06B0,$06B1,$06B2,$06B3
        ..row_3
            dw $06BD,$06BE,$06BF,$06C0,$06C1,$06C2
        ..row_4
            dw $06CA,$06CB,$06CC,$06CD,$06CE,$06CF
        ..row_5
            dw $06D7,$06D8,$06D9,$06DA,$06DB,$06DC
    .neon_tiger_completed_portrait
        ..row_1
            dw $06A5,$06A6,$06A7,$06A8,$06A9,$06AA
        ..row_2
            dw $06B4,$06B5,$06B6,$06B7,$06B8,$06B9
        ..row_3
            dw $06C3,$06C4,$06C5,$06C6,$06C7,$06C8
        ..row_4
            dw $06D0,$06D1,$06D2,$06D3,$06D4,$06D5
        ..row_5
            dw $06DD,$06DE,$06DF,$06E0,$06E1,$06E2


;##########################################################

level:
        jsr unlock_doppler_vile
        jsr boss_rematch
        jsr handle_heart_tank_upgrade
        jsr handle_hp_refill
        jsr give_1up
        jsr fix_softlock
        jsr playback_sfx
        jsr infinite_hp
        rts 

;##########################################################

fix_softlock:
        lda !hp_tank_state
        ora !hp_refill_state
        ora !give_1up
        bne .nope
        lda #$00
        sta !giving_item
    .nope
        rts

;##########################################################

playback_sfx:
        lda !play_sfx_flag
        beq .return
        lda !play_sfx_num
        jsl $01802B
        lda #$00
        sta !play_sfx_flag
    .return
        rts

;##########################################################

boss_rematch:
        lda.l doppler_lab_3_boss_rematch_count
        bne .return
        lda #$FF
        sta $1FDA
    .return 
        rts

;##########################################################

infinite_hp:
        lda.l debug_infinite_hp
        beq .nope 
        lda $09FF
        cmp #$07
        bcs .nope
        lda $1FD2
        sta $09FF
    .nope
        rts

;##########################################################

unlock_doppler_vile:
        phb 
        pea $7E7E
        plb 
        plb 
        lda.l doppler_configuration
        asl 
        tax 
        jsr (.doppler_ptrs,x)
        lda.l vile_configuration
        asl 
        tax 
        jsr (.vile_ptrs,x)
        plb 
        rts 

    .doppler_ptrs
        dw ..multiworld
        dw ..require_medals
        dw ..require_weapons
        dw ..require_armor_upgrades
        dw ..require_heart_tanks
        dw ..require_sub_tanks

    ..multiworld
        rts
    ..require_medals
        lda #$00
        ldx #$0E
    ...loop
        bit.w !levels_completed_array,x
        bvc $01
        inc 
        dex #2
        bpl ...loop
        cmp.l doppler_medal_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_weapons
        lda #$00
        ldx #$0E
    ...loop
        bit.w !weapon_array,x
        bvc $01
        inc 
        dex #2
        bpl ...loop
        cmp.l doppler_weapon_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_armor_upgrades
        lda !ride_chip
        and #$F0
        pha 
        lda !upgrades
        and #$0F
        ora $01,s
        sta $01,s
        ldy #$00
        ldx #$07
    ...loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        pla 
        tya 
        cmp.l doppler_armor_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_heart_tanks
        ldy #$00
        ldx #$07
    ...loop
        lda.w !heart_tanks
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        tya 
        cmp.l doppler_heart_tank_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_sub_tanks
        lda !upgrades
        and #$F0
        pha 
        ldy #$00
        ldx #$07
    ...loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        pla 
        tya 
        cmp.l doppler_sub_tank_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..disable 
        lda #$FF
        sta !doppler_access
        rts 
    ..enable
        lda #$00
        sta !doppler_access
        lda #$01
        sta !unlocked_doppler_lab
        rts

    .bit_check
        db $01,$02,$04,$08,$10,$20,$40,$80

;##########################################################

    .vile_ptrs
        dw ..multiworld
        dw ..require_medals
        dw ..require_weapons
        dw ..require_armor_upgrades
        dw ..require_heart_tanks
        dw ..require_sub_tanks

    ..multiworld
        rts
    ..require_medals
        lda #$00
        ldx #$0E
    ...loop
        bit.w !levels_completed_array,x
        bvc $01
        inc 
        dex #2
        bpl ...loop
        cmp.l vile_medal_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_weapons
        lda #$00
        ldx #$0E
    ...loop
        bit.w !weapon_array,x
        bvc $01
        inc 
        dex #2
        bpl ...loop
        cmp.l vile_weapon_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_armor_upgrades
        lda !ride_chip
        and #$F0
        pha 
        lda !upgrades
        and #$0F
        ora $01,s
        sta $01,s
        ldy #$00
        ldx #$07
    ...loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        pla 
        tya 
        cmp.l vile_armor_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_heart_tanks
        ldy #$00
        ldx #$07
    ...loop
        lda.w !heart_tanks
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        tya 
        cmp.l vile_heart_tank_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..require_sub_tanks
        lda !upgrades
        and #$F0
        pha 
        ldy #$00
        ldx #$07
    ...loop
        lda $01,s
        and.l .bit_check,x
        beq $01
        iny 
        dex 
        bpl ...loop
        pla 
        tya 
        cmp.l vile_sub_tank_count
        bcs ...enable
        jmp ..disable
    ...enable 
        jmp ..enable

    ..disable 
        lda #$FF
        sta !vile_access
        rts 
    ..enable
        lda #$00
        sta !vile_access
        rts

;##########################################################

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
        rts
    .init
        lda $1FD2
        cmp #$20
        bcc ..continue
        lda #$00
        sta !hp_tank_state
        rts
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
        jsl $01802B     ; sfx
        rts 
    
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
        rts

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
        jsl $01EA24
        rts 
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
        sta !giving_item
        jsl $04D130
        jsl $01EA35
        rts 

;##########################################################

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
        rts
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
        rts
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
        rts

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
        rts
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
        sta !giving_item
        jsl $04D130
        rts

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
        rts

;##########################################################

give_1up:
        lda !give_1up
        beq .already_full
        dec 
        sta !give_1up
        lda #$00
        sta !giving_item
        lda $1FB4
        cmp #$09
        bcs .already_full
    .give
        inc $1FB4
        lda #$1A
        jsl $01802B
    .already_full
        rts

    print pc

    warnpc $2FFFE0

;########################################################################################

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
;org $00FCCE
;    jsl listener_mosquitus
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

org $0385F2
    jsr fix_map_heart_tank_indicators
org $0385F9
    jsr fix_map_heart_tank_indicators
org $038600
    jsr fix_map_heart_tank_indicators
org $038607
    jsr fix_map_heart_tank_indicators
org $03860E
    jsr fix_map_heart_tank_indicators
org $038615
    jsr fix_map_heart_tank_indicators
org $03861C
    jsr fix_map_heart_tank_indicators
org $038623
    jsr fix_map_heart_tank_indicators

org $03864F
    jsr fix_map_ride_chip_indicator
org $038656
    jsr fix_map_upgrade_sub_tank_indicator
org $03865D
    jsr fix_map_ride_chip_indicator
org $038664
    jsr fix_map_ride_chip_indicator
org $03866B
    jsr fix_map_upgrade_sub_tank_indicator
org $038672
    jsr fix_map_ride_chip_indicator
org $038679
    jsr fix_map_upgrade_sub_tank_indicator
org $038680
    jsr fix_map_upgrade_sub_tank_indicator

org $0386AC
    jsr fix_map_ride_chip_indicator
org $0386B3
    jsr fix_map_upgrade_sub_tank_indicator
org $0386BA
    jsr fix_map_ride_chip_indicator
org $0386C1
    jsr fix_map_ride_chip_indicator
org $0386C8
    jsr fix_map_upgrade_sub_tank_indicator
org $0386CF
    jsr fix_map_ride_chip_indicator
org $0386D6
    jsr fix_map_upgrade_sub_tank_indicator
org $0386DD
    jsr fix_map_upgrade_sub_tank_indicator

org $049080
    jsl fix_level_helmet_indicators
    nop 

org $03FC00
    fix_map_heart_tank_indicators:
        lda.l !heart_tanks_collected
        rts 
    fix_map_upgrade_sub_tank_indicator:
        lda.l !upgrades_collected
        rts 
    fix_map_ride_chip_indicator:
        lda.l !ride_chip_collected
        rts 

    fix_level_helmet_indicators:
        rep #$20
        lda $10
        cmp.w #!heart_tanks
        beq .heart_tank
        cmp.w #!ride_chip
        beq .ride_chip
        cmp.w #!upgrades
        bne .failsafe
    .upgrades
        sep #$20
        lda.l !upgrades_collected
        bra .return
    .heart_tank
        sep #$20
        lda.l !heart_tanks_collected
        bra .return
    .ride_chip
        sep #$20
        lda.l !ride_chip_collected
        bra .return
    .failsafe
        sep #$20
        lda ($10)
    .return
        sep #$20
        bit $000A
        rtl 

    ride_armor_better_menu:
        sta $35
        lda !ride_chip
        bit #$01
        beq +
        lda #$00
        sta $34
        rtl
    +   
        lda !ride_chip
        bit #$02
        beq +
        lda #$01
        sta $34
        rtl
    +   
        lda !ride_chip
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

org $04942C
    jsr make_player_not_get_stuck_after_shooting_a_pink_or_red_charge
    nop 

org $0494A9
    jsr make_player_not_get_stuck_after_shooting_a_pink_or_red_charge
    nop 

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
    
make_player_not_get_stuck_after_shooting_a_pink_or_red_charge:
        lda.l disable_charge_freeze
        beq .do_not_move
        lda $0A11
        and #$03
        beq .do_not_move
        jsr $8444
    .do_not_move
        lda $3B
        bit #$80
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

incsrc "text.asm"