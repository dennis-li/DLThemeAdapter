//
//  ViewController.m
//  Example
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DLThemeTool.h"
#import "UIImageView+ThirdImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setup];
}

- (void) setup
{
    for (NSInteger i = 0; i < 7; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20+i*40, 50, 20, 20)];
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"%@",@(i)] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    [self setupLabel];
    
    [self setupButton];
    
    [self setupImageView];
}

- (void) setupLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 80, 30)];
    [self.view addSubview:label];
    
    //设置textColor
    NSArray *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor greenColor],[UIColor blueColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor magentaColor]];
    [label dl_setThemes:colors forKeyPath:DLThemeKeyPath(label.textColor)];
    
    //设置text
    NSArray *titles = @[@"title0",@"title1",@"title2",@"title3",@"title4",@"title5",@"title6"];
    [label dl_setThemes:titles forKeyPath:DLThemeKeyPath(label.text)];
}

- (void) setupButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150, 100, 120, 30)];
    
    //设置普通标题
    NSArray *normalTitles = @[@"普通0",@"普通1",@"普通2",@"普通3",@"普通4",@"普通5",@"普通6"];
    [button dl_setThemes:normalTitles forSelector:@selector(setTitle:forState:) withValue:UIControlStateNormal];
    
    //设置普通标题的颜色
    NSArray *normalColors = @[[[UIColor redColor] colorWithAlphaComponent:0.5],[[UIColor orangeColor] colorWithAlphaComponent:0.5],[[UIColor greenColor] colorWithAlphaComponent:0.5],[[UIColor blueColor] colorWithAlphaComponent:0.5],[[UIColor cyanColor]  colorWithAlphaComponent:0.5],[[UIColor yellowColor]  colorWithAlphaComponent:0.5],[[UIColor magentaColor]  colorWithAlphaComponent:0.5]];
    [button dl_setThemes:normalColors forSelector:@selector(setTitleColor:forState:) withValue:UIControlStateNormal];
    
    //设置选中按钮的标题
    NSArray *selectedTitles = @[@"选中0",@"选中1",@"选中2",@"选中3",@"选中4",@"选中5",@"选中6"];
    [button dl_setThemes:selectedTitles forSelector:@selector(setTitle:forState:) withValue:UIControlStateSelected];
    
    //设置选中按钮的标题的颜色
    NSArray *selectedColors = @[[UIColor magentaColor],[UIColor yellowColor],[UIColor blueColor],[UIColor cyanColor],[UIColor greenColor],[UIColor orangeColor],[UIColor redColor]];
    [button dl_setThemes:selectedColors forSelector:@selector(setTitleColor:forState:) withValue:UIControlStateSelected];
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:imageView];
    
    //设置text
    NSArray *images = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06"];
    
    //模拟第三方图片库加载图片方法，dl_setImageWithName类似于sd_setImageWithURL:
    [imageView dl_setThemes:images forSelector:@selector(dl_setImageWithName:)];
    
}

- (void) clickButton:(UIButton *) button
{
    button.selected = !button.isSelected;
}

- (void) click:(UIButton *) button
{
    NSInteger index = button.tag;
    
    //设置使用第几个主题
    [[NSUserDefaults standardUserDefaults] setObject:@(index) forKey:kDLThemeIdentifier];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDLThemeNotificationName object:nil userInfo:nil];
}


@end
