//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2012-2014 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2014-07-02 16:52:21 +0100 (Wed, 02 Jul 2014) $
//
//      Revision            : $Revision: 283836 $
//
//      Release Information : CORTEXA53-r0p4-00rel1
//
//------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "benchmark.h"

static const uint8_t key[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                              0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff};

extern const uint8_t aes128_ebc_encrypt_input[][4096];
extern const uint8_t aes128_ebc_encrypt_ref_output[][4096];
extern uint8_t aes128_ebc_encrypt_output[][4096];

// Function prototypes for asm functions
extern void aes128_key_expand(const unsigned char *key_in, unsigned char *key_out);
extern void aes128_ebc_encrypt(const unsigned char *key, const unsigned char *in_data, unsigned char *out_data, unsigned int size);

int main()
{
  int bs;
  int i;
  int fail = 0;

  uint8_t kv[176];

  aes128_key_expand(key, kv);

  for (i = 0, bs = 16; bs <= 4096; i++, bs*=2) {
    uint32_t cmpres;

    aes128_ebc_encrypt(kv, aes128_ebc_encrypt_input[i], aes128_ebc_encrypt_output[i], bs);

    cmpres = (memcmp(aes128_ebc_encrypt_output[i], aes128_ebc_encrypt_ref_output[i], bs) != 0);

    aes128_ebc_encrypt(kv, aes128_ebc_encrypt_input[i], aes128_ebc_encrypt_output[i], bs);

    cmpres |= (memcmp(aes128_ebc_encrypt_output[i], aes128_ebc_encrypt_ref_output[i], bs) != 0);

    if (cmpres != 0)
      fail = 1;
  }

  // Print pass or fail message
  if (fail)
    printf("** TEST FAILED **\n");
  else
    printf("** TEST PASSED OK **\n");

  return EXIT_SUCCESS;
}

