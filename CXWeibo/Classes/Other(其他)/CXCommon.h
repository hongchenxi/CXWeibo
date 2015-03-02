//0.账号相关
#define CXAppkey @"824965798"
#define CXAppSecret @"b5dd2c233ffa313d7dfadea27c55b6b1"
#define CXRedirect_uri @"www.baidu.com"
#define CXLoginUrl [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",CXAppkey,CXRedirect_uri]

// 1.判断是否为iOS7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 2.获得RGB颜色
#define CXColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//3.自定义Log
#ifdef DEBUG
#define CXLog(...)NSLog(__VA_ARGS__)
#else
#define CXLog(...)
#endif

//4.微博cell上面的属性
/** 昵称的字体 */
#define CXStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define CXRetweetStatusNameFont CXStatusNameFont
/** 时间字体 */
#define CXStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源字体 */
#define CXStatusSourceFont CXStatusTimeFont
/** 正文字体 */
#define CXStatusContentFont [UIFont systemFontOfSize:13]
/** 转发微博正文的字体 */
#define CXRetweetStatusContentFont CXStatusContentFont

/**表格的边框宽度*/
#define CXStatusTableBorder 5
/**cell边框宽度*/
#define CXStatusCellBoreder 10

//5.微博cell内部相册
#define CXPhotoW 70
#define CXPhotoH 70
#define CXphotoMargin 10

//通知
#define CXNotificationCenter [NSNotificationCenter defaultCenter]

#define CXUserDefaults [NSUserDefaults standardUserDefaults]
#define CXGlobalBg IWColor(232, 233, 232)
