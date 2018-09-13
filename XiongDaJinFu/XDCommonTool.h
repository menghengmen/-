//
//  XDCommonTool.h
//  XiongDaJinFu
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDCommonTool : NSObject


+ (void)goToMain;

/**
 *  正则表达式检验手机号
 */
+ (BOOL)checkTel:(NSString *)str;

/**
 *  保存BOOL型数据到UserDefault
 */
+ (void)saveToUserDefaultWithBool:(BOOL)value key:(NSString *)key;

/**
 *  从UserDefault读取BOOL型数据
 */
+ (BOOL)readBoolFromUserDefaultWithKey:(NSString *)key;

/**
 *  保存NSString型数据到UserDefault
 */
+ (void)saveToUserDefaultWithString:(NSString *)value key:(NSString *)key;

/**
 *  从UserDefault读取NSString型数据
 */
+ (NSString *)readStringFromUserDefaultWithKey:(NSString *)key;

/**
 *  保存dictionary型数据到UserDefault
 */
+ (void)saveToUserDefaultWithDic:(NSDictionary *)value key:(NSString *)key;

/**
 *  从UserDefault读取dictionary型数据
 */
+ (NSArray *)readDicFromUserDefaultWithKey:(NSString *)key;

/**
 *  删除某个存储的元素
 */
+ (void)removeIdForKey:(NSString *)key;


/**
 *  根据相应信息弹出一个AlertView，适合点击按钮后不采取其他操作的情况
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sure;

/**
 *  判断是否登录
 */
+ (BOOL)isLogin;

/**
 *  tabBar高度
 */
+ (CGFloat)tabBarHeight;

/**
 *  拼接URL
 */

+ (NSString *)getURLStringWithString:(NSString *)aString;

/**
 * 改变时间格式
 */
+(NSString *)getDateFormatterWithDate:(NSDate *)date;
+(NSString *)changeDate:(NSDate *)date withFormatter:(NSString *)format;
+(NSDate *)getNow;
+(NSString*)getFromDateString:(NSString *)string withStringFormatter:(NSString *)format andchangeFormat:(NSString *)aimFormat;


/*提示*/
+(void)alertWithMessage:(NSString *)message;

/*获取模型中某一字段的数组*/
+(NSMutableArray *)getArrayWithKey:(NSString *)key fromArray:(NSMutableArray *)array;


+(void)showMessage:(NSString *)message inView:(UIView *)view;


//md5加密字符串
+ (NSString *)md5:(NSString *)str;
+(NSString*) escapedStringAll:(NSString*)unescaped;

+(float)fileSizeAtPath:(NSString *)path;
//计算目录大小

+(float)folderSizeAtPath:(NSString *)path;//清理缓存文件

//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。

//清楚缓存
+(void)clearCache:(NSString *)path;
//判断网络状态
+ (void)reachability;

/****************************一些常用控件的封装************************/
//一般自定义btn
+ (UIButton *)newButtonWithType:(UIButtonType)type normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action;
//纯色btn
+ (UIButton *)newButtonWithType:(UIButtonType)type target:(id)target action:(SEL)action;
//带Frame的button
+ (UIButton *)newButtonWithType:(UIButtonType)type  frame:(CGRect)frame normalImage:(NSString *)imageName  buttonTitle:(NSString*)btnTitle target:(id)target action:(SEL)action;
+(UIImageView *)newImageViewWithName:(NSString *)imageName;

+ (UITextField *)newTextFieldWithStyle:(UITextBorderStyle)style   withPlaceHolder:(NSString *)placeHolderStr;
+(UILabel *)newlabelWithTextColor:(UIColor*)color withTitle:(NSString*)title  fontSize:(CGFloat)theSize;

+(CGSize)getSizeWithString:(NSString*)str with:(UIFont*)font withSize:(CGSize)size;


@end
