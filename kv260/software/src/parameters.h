/*
FILENAME: parameters.h
AUTHOR: Greg Taylor     CREATION DATE: 12 Aug 2019

DESCRIPTION:

CHANGE HISTORY:
12 Aug 2019		Greg Taylor
	Initial version

MIT License

Copyright (c) 2019 Greg Taylor <gtaylor@sonic.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
#ifndef SRC_PARAMETERS_H_
#define SRC_PARAMETERS_H_

#define ULTRA96 0
#define KV260   1
#define ME_XU6_ST1 2

#if !defined(BOARD)
#error "BOARD not defined"
//#define BOARD			KV260 // set to ULTRA96 or KV260 or ME_XU6_ST1
#endif


#define VM_1080 0
#define VM_720P 1
#define VM_480P 2
#define VM_4K 3

#if !defined(APP_VIDEO_MODE)
#define APP_VIDEO_MODE		VM_1080
#endif

#define VIDEO_COLUMNS	1920
#define VIDEO_ROWS		1080

#endif /* SRC_PARAMETERS_H_ */
