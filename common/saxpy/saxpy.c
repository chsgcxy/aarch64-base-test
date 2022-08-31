//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2011-2014 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2014-07-25 09:52:11 +0100 (Fri, 25 Jul 2014) $
//
//      Revision            : $Revision: 285788 $
//
//      Release Information : CORTEXA53-r0p4-00rel1
//
//------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include "benchmark.h"

// Parameters and variables
#define NLOOPS 10 // should be more than enough to get to stationary state
#define ARRAY_SIZE 208
float x[ARRAY_SIZE] __attribute__((aligned (16)));
float y[ARRAY_SIZE] __attribute__((aligned (16)));
float null_a;
float null_b;

// Saxpy asm loop function prototype.
// This loop is defined in the AArch32/AArch64-specific directories.
extern saxpy_asm(int N, float a[], float b[], float constant);

// Initialize data array
setup() {
  int index;
  // Want to get those 2 hex numbers into the float variables
  // without a int->float conversion. Got to use pointers to
  // prevent C from casting to float.
  const unsigned int int_const_a = 0x51523DC9;
  const unsigned int int_const_b = 0x0A4C2AD3;
  const float float_const_a = *((float *) &int_const_a);
  const float float_const_b = *((float *) &int_const_b);
  for (index = 0; index < ARRAY_SIZE; index++) {
    // Note: be careful of data type promotion here, and loss of accuracy,
    // as we are storing integers into float variables.
    x[index] = float_const_a;
    y[index] = float_const_b;
  }
  null_a = float_const_a;
  null_b = float_const_b;
}

// Main test loop
main() {
  int index;

  // Want to get those 2 hex numbers into the float variables
  // without a int->float conversion. Got to use pointers to
  // prevent C from casting to float.
  const unsigned int int_const_c = 0xC94DAD43;
  const unsigned int int_const_d = 0x48DD73F1;
  const float float_const_c = *((float *) &int_const_c);
  const float float_const_d = *((float *) &int_const_d);

  // Initialize variables
  setup();

  // Start statistics capture here
  MAINSTART
  BENCHSTART
  for(index = 0; index < NLOOPS; index++) {
    float constant;
    LOOPSTART
    // Alternate the constant on each pass
    constant = (index & 0x1) ? float_const_c : float_const_d;  
    saxpy_asm(ARRAY_SIZE, x, y, constant);
    LOOPEND
  }
  // End statistics capture
  BENCHFINISHED
  MAINEND

  return EXIT_SUCCESS;
}
