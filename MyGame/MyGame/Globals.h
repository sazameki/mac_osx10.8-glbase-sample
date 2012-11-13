//
//  Globals.h
//  MyGame
//
//  Created by numata on 2012/11/13.
//  Copyright (c) 2012 Sazameki and Satoshi Numata, Ph.D. All rights reserved.
//

#ifndef __GLOBALS_H__
#define __GLOBALS_H__


extern volatile bool    gIsAppFinished;

#define GM_COLOR_BUFFER_SIZE        32
#define GM_ALPHA_BUFFER_SIZE        8
#define GM_DEPTH_BUFFER_SIZE        24

// Use MSAA (0/1)
#define GM_USES_MSAA                1

// Sample Size (1/2/4/8/9/16)
#define GM_SAMPLE_SIZE              4

// Use Super-Sampling (0/1)
#define GM_USES_MSAA_SUPERSAMPLE    0

// Use Alpha Sampling (0/1)
#define GM_USES_MSAA_ALPHA          0

#endif  //#ifndef __GLOBALS_H__

