//
//  DevelopmentDefine.h
//  EventDispatch
//
//  Created by redye.hu on 2017/11/7.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#ifndef DevelopmentDefine_h
#define DevelopmentDefine_h

//这里不能去掉，否则会影响线上环境
#if DEBUG

//如果定义此宏，则不会请求开关，直接展示贷款王界面
#define DEVELOP_LOAN_KING_SWITCH
//如果定义此宏，则使用本地ip.txt中的ip地址加载bundle
#define DEVELOP_REACT_NATIVE_SWITCH


//#undef __IPHONE_10_0
//#define __IPHONE_10_0    110000

//#undef __IPHONE_9_0
//#define __IPHONE_9_0    110000

#define function_call(message) console(NSStringFromSelector(_cmd), message)

//#define debug_console_alert

#ifndef debug_console_alert
#define console(title, content) NSLog(@"%@--%@", title, content)
#else
#define console(title, content) \
if (content.length>0) {\
UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];\
[pasteboard setString:content];\
}\
[[[UIAlertView alloc] initWithTitle:@"已复制到剪切板"\
message:[NSString stringWithFormat:@"%@--%@", title, content] delegate:nil\
cancelButtonTitle:@"确定" otherButtonTitles:nil] show]
#endif

#else

#define function_call(message)
#define console(title, content)

#endif


#endif /* DevelopmentDefine_h */
