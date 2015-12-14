//
//  LHCPopTableViewController.m
//  hakka
//
//  Created by Li-Hsuan Chen on 2015/09/24.
//  Copyright © 2015 Li-Hsuan Chen. All rights reserved.
//

#import "LHCPopTableViewController.h"

@interface LHCPopTableViewController ()

@property (nonatomic, strong) UIView *recognizerView;
@property (nonatomic, strong) UIGestureRecognizer *tapGestureRecognizer;

@end

@implementation LHCPopTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recognizerView = [[UIView alloc] init];
    self.recognizerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.recognizerView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.layer.cornerRadius = 3.f;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void *)self];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView:)];
    [self.recognizerView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.recognizerView.frame = self.view.frame;
    [self resizeTableViewWithContentSize:self.tableView.contentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.recognizerView removeGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context != (__bridge void *)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self resizeTableViewWithContentSize:[change[@"new"] CGSizeValue]];
    }
}

#pragma mark - UI Helpers

- (void)didTapOnView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resizeTableViewWithContentSize:(CGSize)contentSize
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat margin = 30.f;
        CGFloat statusBarHeight = 20.f;
        
        CGFloat availableContentHeight = CGRectGetHeight(self.view.bounds) - margin * 2 - statusBarHeight;
        CGFloat availableContentWidth = CGRectGetWidth(self.view.bounds) - margin * 2;
        
        CGRect tableViewFrame = self.tableView.frame;
        CGSize tableViewSize = contentSize;
        
        if (tableViewSize.height >= availableContentHeight) {
            self.tableView.scrollEnabled = YES;
            tableViewSize = CGSizeMake(availableContentWidth, availableContentHeight);
        } else {
            self.tableView.scrollEnabled = NO;
            tableViewSize = CGSizeMake(availableContentWidth, tableViewSize.height);
        }
        
        tableViewFrame.origin.x = availableContentWidth / 2 - tableViewSize.width / 2 + margin;
        tableViewFrame.origin.y = availableContentHeight / 2 - tableViewSize.height / 2 + margin + statusBarHeight;
        
        tableViewFrame.size = tableViewSize;
        self.tableView.frame = tableViewFrame;
        
        [self.view bringSubviewToFront:self.tableView];
    });
}

@end
