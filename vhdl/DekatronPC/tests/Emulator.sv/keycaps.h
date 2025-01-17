#ifndef KEYS_VALUES
   #define KEYS_VALUES

typedef enum  {
    KEYBOARD_IRAM_KEY =  15,
    KEYBOARD_DRAM_KEY =  10,
    KEYBOARD_CIN_KEY =  5,
    KEYBOARD_COUT_KEY =  0,

    KEYBOARD_IP_KEY =   35,
    KEYBOARD_LOOP_KEY =  30,
    KEYBOARD_AP_KEY =   25,
    KEYBOARD_DATA_KEY =  20,

    KEYBOARD_0_KEY =    16,
    KEYBOARD_1_KEY =    17,
    KEYBOARD_2_KEY =    18,
    KEYBOARD_3_KEY =    19,
    KEYBOARD_4_KEY =    11,
    KEYBOARD_5_KEY =    12,
    KEYBOARD_6_KEY =    13,
    KEYBOARD_7_KEY =    14,
    KEYBOARD_8_KEY =    6,
    KEYBOARD_9_KEY =    7,
    KEYBOARD_A_KEY =    8,
    KEYBOARD_B_KEY =    9,
    KEYBOARD_C_KEY =    1,
    KEYBOARD_D_KEY =    2,
    KEYBOARD_E_KEY =    3,
    KEYBOARD_F_KEY =    4,

    KEYBOARD_INC_KEY =  36,
    KEYBOARD_DEC_KEY =  31,

    KEYBOARD_HALT_KEY =  26,
    KEYBOARD_STEP_KEY =  33,
    KEYBOARD_RUN_KEY =  28,

    KEYBOARD_ARROW_UP_KEY  =  27,
    KEYBOARD_ARROW_DOWN_KEY = 22,
    KEYBOARD_ARROW_LEFT_KEY = 21,
    KEYBOARD_ARROW_RIGHT_KEY = 23,

    KEYBOARD_HARD_RST =   37,
    KEYBOARD_SOFT_RST_KEY  = 38,

    KEYBOARD_NONAME_KEY =  32,

    KEYBOARD_NONEXIST_2 =  24,
    KEYBOARD_NONEXIST_3 =  29,
    KEYBOARD_NONEXIST_4 =  34
} EmulatorKey_t;

#endif
