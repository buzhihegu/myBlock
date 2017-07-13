//
//  Header.h
//  myBlock
//
//  Created by mch on 15/9/1.
//  Copyright (c) 2015年 mch. All rights reserved.
//

#ifndef myBlock_Header_h
#define myBlock_Header_h

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define HEXCOLOR(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]


// 调试模式
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...);
#define LOG_METHOD;
#endif

#endif
