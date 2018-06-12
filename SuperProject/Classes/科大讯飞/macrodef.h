//
//  def.h
//  QQing
//
//  Created by 李杰 on 1/26/15.
//
//

#ifndef QQing_def_h
#define QQing_def_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#undef  FA_EXTERN
#define FA_EXTERN    extern __attribute__((visibility ("default")))

/*!
 * @function Singleton GCD Macro
 */
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif

#undef DEF_SINGLETON_GCD
#define DEF_SINGLETON_GCD SINGLETON_GCD

#undef DEC_SINGLETON
#define DEC_SINGLETON(classname) + (classname *)shared##classname;

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#undef	singleton
#define singleton( __class ) \
property (nonatomic, readonly) __class * sharedInstance; \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	def_singleton
#define def_singleton( __class ) \
dynamic sharedInstance; \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __strong id __singleton__ = nil; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#define RUNLOOP_RUN_FOR_A_WHILE \
{ \
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
}

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//系统版本
#define SYSTEM_VERSION  [[UIDevice currentDevice].systemVersion doubleValue]

// Log
#if DEBUG

#   define QQLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#   define debugCode( __code_fragment ) { __code_fragment }

#else

#   define QQLog( s, ... )

#   define debugCode( __code_fragment )

#endif

// RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r, g, b, 1.0f)

// 通用异常定制
#define kExceptionName @"qqing exception"

#define kExceptionReasonNotImplemented  @"interface not implemented"
#define kExceptionReasonFunctionWrong   @"function incrrect"

#define __RAISE_NOT_IMPLEMENT_EXCEPTION [[NSException exceptionWithName:kExceptionName\
                                        reason:kExceptionReasonNotImplemented \
                                        userInfo:nil] raise]; // 接口未实现

#define __RAISE_NOT_FUNCTION_EXCEPTION  [[NSException exceptionWithName:kExceptionName\
                                        reason:kExceptionReasonFunctionWrong \
                                        userInfo:nil] raise]; // 功能点不对

// 转到字符串
#undef  STR // 默认为 转对象，所以不命名为: STRING_FOR_OBJECT
#define STR( _obj_ )  [NSString stringWithFormat:@"%@", _obj_]

#undef  MSTR // mutable string
#define MSTR( _obj_ ) ((NSMutableString *)[[NSString stringWithFormat:@"%@", _obj_] mutableCopy])

// 仅仅是标记
#define ___INPUT  // Params input
#define ___OUTPUT // Params output
#define ___RESPONSE
#define ___REQUEST
#define ___(note)

// 默认目录
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_CACHE       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// fixme: Should have domain\formatErrorDesc\filename\filelinenum
#undef ENC_ERROR
#define ENC_ERROR(pp_error, error_desc) {\
*pp_error = [NSError errorWithDomain:@"IngErrorDomain" code:-1L userInfo:\
[NSDictionary dictionaryWithObjectsAndKeys:\
error_desc, NSLocalizedDescriptionKey,\
NULL]];\
}

// 枚举、错误码：
// Notice: 最新的相关于文字提示的，ErrorDefinition
// Notice: 偏模块化的：property
#undef __enum_start
#define __enum_start(type, name) typedef NS_ENUM(type, name) {

#undef __enum_end
#define __enum_end };

/**
 *
 *  设备类型宏判断，提供给需要在不同机型的设备上的布局调整
 *
 */
#define QQIPHONE_4_4S               (([UIScreen width] == 320) && ([UIScreen height] == 480))
#define QQIPHONE_5_5C_5S            (([UIScreen width] == 320) && ([UIScreen height] == 568))
#define QQIPHONEBELOW_6             ([UIScreen width] == 320)
#define QQIPHONE_6                  ([UIScreen width] == 375)
#define QQIPHONE_6P                 ([UIScreen width] == 414)

// 特殊数值

#undef UNDEFINED_STRING
#define UNDEFINED_STRING @"未定义"

#undef UNSELECTED_STRING
#define UNSELECTED_STRING @"请选择"

#undef ADDRESS_STRING_FOR_LIVE
#define ADDRESS_STRING_FOR_LIVE @"通过在线授课工具授课"

#undef YuanSymbolStr
#define YuanSymbolStr @"￥"

#undef INVALID_INT32
#define INVALID_INT32 INT32_MAX

#undef INVALID_INT64
#define INVALID_INT64 INT64_MAX

#undef INVALID_FLOAT
#define INVALID_FLOAT MAXFLOAT

#undef INVALID_BOOL
#define INVALID_BOOL NO

#undef MIN_FLOAT
#define MIN_FLOAT 0.000001f

// 特定的字符串

// 中文
#define yyyy                @"yyyy"
#define yyyyMM              @"yyyy年MM月"
#define yyyyMMdd            @"yyyy年MM月dd日"
#define MMdd                @"MM月dd日"

#define kNotificationShareSuccessAndGetShareFeedBackAmount             @"kNotificationShareSuccessAndGetShareFeedBackAmount"          //分享成功后获取到优惠金额

// 短横分割线
#define yyyy_MM_dd          @"yyyy-MM-dd"

// 警告处理方案
#define IgnorePerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0);


#endif
