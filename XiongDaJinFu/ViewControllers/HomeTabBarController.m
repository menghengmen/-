//
//  HomeTabBarController.m
//  GenesisIpad
//
//  Created by gary on 16/12/1.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "HomeTabBarController.h"
#import "masonry.h"
//#import "AppWindow.h"

#import <ifaddrs.h>
#import <arpa/inet.h>

#define KMarginSpace   10

@interface HomeTabBarController ()
{
    //    UIView *homeTabbarView;
    //    float screenwidth;
    UIImageView *imageView;
}
@end

@implementation HomeTabBarController
@synthesize homeTabbarView;

- (NSDictionary *)getIpAddresses {
    NSMutableDictionary* addresses = [[NSMutableDictionary alloc] init];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    
    @try {
        // retrieve the current interfaces - returns 0 on success
        NSInteger success = getifaddrs(&interfaces);
        //NSLog(@"%@, success=%d", NSStringFromSelector(_cmd), success);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Get NSString from C String
                    NSString* ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    NSString* address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                    NSString* mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
                    NSString* gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
                    NSDictionary *netAddress = @{};
                 //   DDLogInfo(@"ip地址   %@ -- %@  -- %@ -- %@", ifaName, address, mask, gateway);
                    //                    AXNetAddress* netAddress = [[AXNetAddress alloc] init];
                    //                    netAddress.name = ifaName;
                    //                    netAddress.address = address;
                    //                    netAddress.netmask = mask;
                    //                    netAddress.gateway = gateway;
                   // DDLogInfo(@"netAddress=%@", netAddress);
                    addresses[ifaName] = netAddress;
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
    }
    @catch (NSException *exception) {
        //        DDLogInfo(@"%@ Exception: %@", DEBUG_FUN, exception);
    }
    @finally {
        // Free memory
        freeifaddrs(interfaces);
    }
    return addresses;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)){
    //        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    //    }
}

- (void)viewDidLoad
{
    //    [self getIpAddresses];
    [super viewDidLoad];
    //    screenwidth = [[UIScreen mainScreen] bounds].size.width;
    
    // Do any additional setup after loading the view from its nib.
    //self.viewControllers = [NSArray arrayWithObjects:homeVc, zhiboViewController, otherViewController, nil];
    self.tabBar.hidden = YES;
    self.selectedIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    homeTabbarView = [UIView new];
    // home tabbar
    homeTabbarView.backgroundColor = RGB(30.0f, 30.0f, 30.0f);
   
    homeTabbarView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    [self.view addSubview:homeTabbarView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [homeTabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(homeTabbarView.superview);
        make.width.equalTo(homeTabbarView.superview);
        make.height.equalTo(@49);
        make.bottom.equalTo(homeTabbarView.superview);
    }];
    CGFloat width , height;
    if (SCREENWIDTH > SCREENHEIGHT) {
        width = SCREENHEIGHT;
        height = SCREENWIDTH;
    } else {
        width = SCREENWIDTH;
        height = SCREENHEIGHT;
    }
    
    NSArray *defaultImageArray = @[@"首页ICON2.png", @"分类ICON2.png", @"searchVR@2x.png", @"购物车ICON2.png", @"我的ICON2.png"];
    NSArray * selectedImageArray = @[@"首页ICON1.png",@"分类ICON1.png", @"searchVR@2x.png", @"购物车ICON1.png",@"我的ICON1.png"];
    NSArray *labelArray = @[@"首页", @"分类", @"特惠频道", @"购物车", @"我的"];
    
    for (int i = 1; i < 6; i++) {
        
        UIView *subVs = [UIView new];
        //        subVs.backgroundColor = KRandomColor;
        [homeTabbarView addSubview:subVs];
        //        subVs.backgroundColor = KRandomColor;
        
        if (i < 3) {
            [subVs mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(subVs.superview).offset(((width-116/2 - KMarginSpace)/4)*(i-1));
                make.top.equalTo(subVs.superview).offset(0);
                make.height.equalTo(@(49));
                make.width.equalTo(@((width-116/2 - KMarginSpace)/4));
            }];
        } else if (i == 3) {
            [subVs mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(subVs.superview).offset(((width-116/2 - KMarginSpace)/4)*(i-1));
                make.bottom.equalTo(subVs.superview).offset(0);
                make.height.equalTo(@(116/2 + KMarginSpace));
                make.width.equalTo(@(116/2 + KMarginSpace));
            }];
        } else if (i > 3) {
            [subVs mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(subVs.superview).offset(((width-116/2 - KMarginSpace)/4)*(i-2) + 116/2);
                make.top.equalTo(subVs.superview).offset(0);
                make.height.equalTo(@(49));
                make.width.equalTo(@((width-116/2 - KMarginSpace)/4));
            }];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setImage:[UIImage imageNamed:defaultImageArray[i-1]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedImageArray[i-1]] forState:UIControlStateSelected];
        if (i == 3) {
            btn.selected = YES;
        }
        [subVs addSubview:btn];
        
        if (i != 3) {
            btn.imageEdgeInsets = UIEdgeInsetsMake(5,18,20,btn.titleLabel.bounds.size.width + 18);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            btn.titleEdgeInsets = UIEdgeInsetsMake(29, 0, 0, 0);
        } else {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        }
        
        if (i != 3) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(60));
                make.top.equalTo(btn.superview).offset(0);
                make.bottom.equalTo(btn.superview).offset(0);
                make.centerX.equalTo(btn.superview);
                
                //            make.left.equalTo(btn.superview).offset((ScreenWidth/4)*(i-1));
                //            make.top.equalTo(btn.superview).offset(0);
                //            make.height.equalTo(@(49));
                //            make.width.equalTo(@(ScreenWidth/4));
            }];
        } else if (i == 3) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn.superview).offset(0);
                //                make.width.equalTo(@(116/2));
                make.bottom.equalTo(btn.superview).offset(0);
                //                make.bottom.equalTo(btn.superview).offset(0);
                //                make.centerX.equalTo(btn.superview);
                //                make.width.equalTo(btn.superview);
                make.center.equalTo(btn.superview);
                //            make.left.equalTo(btn.superview).offset((ScreenWidth/4)*(i-1));
                //            make.top.equalTo(btn.superview).offset(0);
                //            make.height.equalTo(@(49));
                //            make.width.equalTo(@(ScreenWidth/4));
            }];
        }
        
        if (i == 3) {
            //            imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            //            [subVs addSubview:imageView];
            //            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.left.equalTo(imageView.superview).offset(-5);
            //                make.bottom.equalTo(imageView.superview).offset(5);
            //                make.width.equalTo(@(116/2 + 10));
            //                make.height.equalTo(@(116/2+10));
            ////                make.width.equalTo(imageView.superview);
            //            }];
            //            imageView.image = [UIImage imageNamed:@"searchVR@2x.png"];
            [btn setImage:[UIImage imageNamed:@"searchVRHighlight@2x.png"] forState:UIControlStateHighlighted];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        }
        
        // 文字
        UILabel *label = [UILabel new];
        NSString *labelStr = labelArray[i-1];
        label.text = labelStr;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10 + i;
        label.font = [UIFont systemFontOfSize:11];
        if (btn.selected == NO) {
            label.textColor = RGB(215, 215, 215);
        } else {
            label.textColor = RGB(240, 240, 241);
        }
        [subVs addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.superview).offset(0);
            make.top.equalTo(label.superview).offset(49 - 24+5);
            //            make.height.equalTo(@(49));
            make.bottom.equalTo(label.superview).offset(-5);
            make.width.equalTo(label.superview);
        }];
        
    }
    
    
  
    
    
    
    
    
   
}


#pragma mark -
-(void)makeEqualWidthInView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
{
    UIView *lastView;
    for (UIView *view in [containerView subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            if (lastView) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    //                    make.top.equalTo(containerView.mas_top).with.offset(5);
                    //                    make.left.equalTo(lastView.mas_right).offset(viewPadding);
                    //                    make.width.equalTo(lastView);
                    //                    make.height.equalTo(@24);
                    
                    make.top.equalTo(containerView.mas_top).with.offset(0);
                    make.left.equalTo(lastView.mas_right).offset(viewPadding);
                    make.width.equalTo(lastView);
                    make.height.equalTo(@49);
                }];
                
                //
                UIButton *viewBtn = (UIButton *)view;
                viewBtn.imageEdgeInsets = UIEdgeInsetsMake(5,18,20,viewBtn.titleLabel.bounds.size.width + 18);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
                viewBtn.titleEdgeInsets = UIEdgeInsetsMake(29, 0, 0, 0);
                //
            } else
            {
                //                NSLog(@"buttontag: %d",view.tag);
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    //                    make.top.equalTo(containerView.mas_top).with.offset(5);
                    //                    make.left.equalTo(containerView).offset(LRpadding);
                    //                 make.width.equalTo(@24);
                    //                    make.height.equalTo(@24);
                    
                    make.top.equalTo(containerView.mas_top).with.offset(0);
                    make.left.equalTo(containerView).offset(LRpadding);
                    make.width.equalTo(@60);
                    make.height.equalTo(@49);
                    
                }];
                //
                UIButton *viewBtn = (UIButton *)view;
                viewBtn.imageEdgeInsets = UIEdgeInsetsMake(5,18,20,viewBtn.titleLabel.bounds.size.width + 18);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
                //                viewBtn.titleEdgeInsets = UIEdgeInsetsMake(29, 0, 0, 0);
                //
            }
            lastView=view;
            
        }
        
    }
    
    //    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(containerView).offset(-LRpadding);
    //    }];
}

-(void)makeWidthInView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
{
    UIView *lastView;
    for (UIView *view in [containerView subviews])
    {
        if([view isKindOfClass:[UILabel class]])
        {
            if (lastView) {
                //                NSLog(@"buttontag: %d",view.tag);
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(containerView.mas_top).with.offset(49 - 24 +5);
                    make.bottom.equalTo(containerView.mas_bottom).with.offset(-5);
                    
                    make.left.equalTo(lastView.mas_right).offset(viewPadding);
                    make.width.equalTo(lastView);
                }];
            }else
            {
                //                NSLog(@"buttontag: %d",view.tag);
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(containerView.mas_top).with.offset(49 - 24+5);
                    make.bottom.equalTo(containerView.mas_bottom).with.offset(-5);
                    make.left.equalTo(containerView).offset(LRpadding);
                    make.width.equalTo(@60);
                }];
            }
            lastView=view;
            
        }
        
    }
    
    //    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(containerView).offset(-LRpadding);
    //    }];
}


- (void)clickBtn:(id)sender
{
    imageView.image = [UIImage imageNamed:@""];
    UIButton * btn = (UIButton *)sender;
    [self resetButton];
    btn.selected = YES;
    switch (btn.tag) {
        case 1:// home
        {
            UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + 1];
            label.textColor = RGB(0, 0, 0);
            break;
        }
        case 2://
        {
            UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + 2];
            label.textColor = RGB(0, 0, 0);
            break;
        }
        case 3://
        {
            ////            CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
            ////            anima1.toValue = [NSNumber numberWithFloat:0.8f];
            ////            anima1.duration = 0.3f;
            ////            [imageView.layer addAnimation:anima1 forKey:@"scaleAnimation"];
            ////
            ////            double delayInSeconds = 0.3;
            ////            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            ////            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
           // GlobeObject *globeObject = [GlobeObject sharedInstance];
            //            if (![globeObject.sousuo isEqualToString:@"sousuo"]) {
            //                CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
            //                anima.toValue = [NSNumber numberWithFloat:1.1f];
            //                anima.duration = 0.2f;
            //                [imageView.layer addAnimation:anima forKey:@"scaleAnimation"];
            //            }
            //
            ////            });
            
            
            UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + 3];
            label.textColor = RGB(0, 0, 0);
            
            
           // globeObject.sousuo = @"sousuo";
            
            if (btn.state == UIControlStateHighlighted) {
                imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
                [btn addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageView.superview).offset(-5);
                    make.bottom.equalTo(imageView.superview).offset(5);
                    make.width.equalTo(@(116/2 + 10));
                    make.height.equalTo(@(116/2+10));
                    //                make.width.equalTo(imageView.superview);
                }];
                imageView.image = [UIImage imageNamed:@"searchVR@2x.png"];
                imageView.userInteractionEnabled = YES;
            }
            
            break;
        }
        case 4://
        {
            UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + 4];
            label.textColor = RGB(0, 0, 0);
            break;
        }
        case 5://
        {
            UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + 5];
            label.textColor = RGB(0, 0, 0);
        }
            break;
            
        default:
            break;
    }
    [super setSelectedIndex:btn.tag-1];
    
    
}

-(void)resetButton
{
    for (int i=1; i<6; i++) {
        UIButton * btn =(UIButton *)[homeTabbarView viewWithTag:i];
        btn.selected = NO;
    }
    
    for (int i = 1; i < 6; i++) {
        UILabel *label = (UILabel *)[homeTabbarView viewWithTag:10 + i];
        label.textColor = RGB(215, 215, 215);
    }
    
}
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //    screenwidth = [[UIScreen mainScreen] bounds].size.width;
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //    screenwidth = [[UIScreen mainScreen] bounds].size.width;
    
}


@end
