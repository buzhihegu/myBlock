//
//  ViewController.m
//  myBlock
//
//  Created by mch on 15/8/31.
//  Copyright (c) 2015年 mch. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"


@interface ViewController (){
    UIWindow *keyWin;
    UIButton *lotteryBtn,*accountBtn;

}
@property (nonatomic, strong) NSArray *photoItemArray;
@property(strong,nonatomic)UIView *payMethodBgView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LOG_METHOD;
    
    
    _photoItemArray = @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    button.frame = CGRectMake(100, 100, 50, 50);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)click
{
    [self setQueueBarrier];


//    NSLog(@"点击事件%@",self.photoItemArray);
    
  /*
    keyWin = [[UIApplication sharedApplication] keyWindow];
    _payMethodBgView = [[UIView alloc] initWithFrame:keyWin.bounds];
    _payMethodBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [keyWin addSubview:_payMethodBgView];
    
    float btnHeight = 40;
    float cViewHeight = 230-btnHeight;
    float cViewWidth = 250;
    float cViewTop = (ScreenHeight-cViewHeight)/2;
    float cViewLeft = (ScreenWidth-cViewWidth)/2;
    
    UIView *cWhiteView = [[UIView alloc] initWithFrame:CGRectMake(cViewLeft, cViewTop, cViewWidth, cViewHeight)];
    cWhiteView.backgroundColor=[UIColor whiteColor];
    [_payMethodBgView addSubview:cWhiteView];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-cViewLeft-26, cViewTop-52, 26, 52)];
    [_payMethodBgView addSubview:closeBtn];
    [closeBtn setImage:[UIImage imageNamed:@"lottey_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePayView) forControlEvents:UIControlEventTouchUpInside];
    [keyWin bringSubviewToFront:_payMethodBgView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cViewWidth, 45)];
    topLabel.text=@"支付";
    topLabel.font=[UIFont systemFontOfSize:17];
    topLabel.textAlignment=NSTextAlignmentCenter;
    topLabel.textColor=HEXCOLOR(0xfd6744);
    [cWhiteView addSubview:topLabel];
    
    lotteryBtn=[[UIButton alloc] initWithFrame:CGRectMake(30, 45+10, cViewWidth-20, btnHeight)];
*/

    
}
-(void)closePayView{
    _payMethodBgView.hidden=YES;
}
//dispatch_barrier_async 作用是在并行队列中，等待前面两个操作并行操作完成
//dispatch_barrier_sync和dispatch_barrier_async的共同点：
//1、都会等待在它前面插入队列的任务（1、2、3）先执行完
//2、都会等待他们自己的任务（0）执行完再执行后面的任务（4、5、6）
//
//dispatch_barrier_sync和dispatch_barrier_async的不共同点：
//在将任务插入到queue的时候，dispatch_barrier_sync需要等待自己的任务（0）结束之后才会继续程序，然后插入被写在它后面的任务（4、5、6），然后执行后面的任务
//而dispatch_barrier_async将自己的任务（0）插入到queue之后，不会等待自己的任务结束，它会继续把后面的任务（4、5、6）插入到queue
//
//所以，dispatch_barrier_async的不等待（异步）特性体现在将任务插入队列的过程，它的等待特性体现在任务真正执行的过程。
-(void)setQueueBarrier{
    dispatch_queue_t currQueue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(currQueue, ^{
        NSLog(@"dispatch-1");
    });
    dispatch_async(currQueue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(currQueue, ^{
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(currQueue, ^{
        NSLog(@"dispatch-3");
    });
    dispatch_async(currQueue, ^{
        NSLog(@"dispatch-4");
    });
}
//在dispatch_queue中所有的任务执行完成后在做别的操作，在串行队列中，可以把操作放到最后一个任务执行完后继续，但是在并行队列中用dispatch_group
-(void)setqueue{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"dispatch -1");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"dispatch -2");
    });
    dispatch_group_notify(dispatchGroup, dispatchQueue, ^{
        NSLog(@"end ");
    });
    
}
//同步执行
-(void)setQueuesycn{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:10];
        NSLog(@"3");
    });
    NSLog(@"4");
}
//异步执行
-(void)setQueueAsync{
    dispatch_queue_t currQueue = dispatch_queue_create("my.curr.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(currQueue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:5];
        NSLog(@"3");
    });
    NSLog(@"4");
}


/**
 
 //（1）定义无参无返回值的Block
 void (^printBlock)() = ^(){
 printf("no number\n");
 };
 //    printBlock();
 //    printBlock(9);
 
 int mutiplier = 7;
 //（3）定义名为myBlock的代码块，返回值类型为int
 int (^myBlock)(int) = ^(int num){
 return num*mutiplier;
 };
 //使用定义的myBlock
 int newMutiplier = myBlock(3);
 printf("newMutiplier is %d\n",myBlock(3));
 
 
 
 //定义在-viewDidLoad方法外部
 //（2）定义一个有参数，没有返回值的Block
 //void (^printNumBlock)(int) = ^(int num){
 //    printf("int number is %d",num);
 //};
 
 */



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
