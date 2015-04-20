
//
//  HJHTalkingViewController.m
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHTalkingViewController.h"
#import "HJHMessageBean.h"

#define kDefaultToolbarHeight 42
#define kIOS7 0

@interface HJHTalkingViewController ()
@property (strong, nonatomic) EMConversation *conversation;//会话管理者
@property (assign, nonatomic) NSInteger messageCount;
@property (strong, nonatomic) NSMutableArray *messageArray;
@property (strong, nonatomic) HJHMessageTableViewController *mTabelView;
@property (strong, nonatomic) NSString *talkingFormStringName;
@property (strong, nonatomic) NSString *talkingToStringName;

@end

@implementation HJHTalkingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
        //根据接收者的username获取当前会话的管理者
        HJHCurrentUser *user = [HJHCurrentUser sharedManager];
        if (user) {
            if ([user._userNickName4 isEqualToString:@"张俊"]) {
                self.talkingFormStringName = @"zhangjun";
            }else if([user._userNickName4 isEqualToString:@"李丽"]){
                self.talkingFormStringName = @"lili";
            }else if ([user._userNickName4 isEqualToString:@"陈虎"]){
                self.talkingFormStringName = @"chenhu";
            }else if ([user._userNickName4 isEqualToString:@"Chris Mo"]){
                self.talkingFormStringName = @"ChrisMo";
            }
        }
        _conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.talkingFormStringName isGroup:NO];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self addRigthBtn];
    [self.rigthBtn setTitle:@"群成员" forState:UIControlStateNormal];
    self.rigthBtn.frame = CGRectMake(249, 19, 70, 50);
    [self.rigthBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.talkingToName isEqualToString:@"张俊"]) {
        self.talkingToStringName = @"zhangjun";
    }else if([self.talkingToName isEqualToString:@"李丽"]){
        self.talkingToStringName = @"lili";
    }else if ([self.talkingToName isEqualToString:@"陈虎"]){
        self.talkingToStringName = @"chenhu";
    }else if ([self.talkingToName isEqualToString:@"Chris Mo"]){
        self.talkingToStringName = @"ChrisMo";
    }
    
    self.headNavView.titleLabel.text = self.talkingToName;
    self.messageCount = 0;
    self.messageArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self loginInTadkView];
    [self setDelegate];
    [self setMainTableView];
    [self showKeyboard];
    // Do any additional setup after loading the view.
}

-(void)setDelegate{
#warning 以下两行代码必须写，注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)didUpdateBuddyGroupList:(NSArray *)buddyGroupList{
    
}

-(void)loginInTadkView{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.talkingFormStringName
                                                        password:[NSString stringWithFormat:@"123456"]
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (error) {
             NSLog(@"登录失败");
         }else {
             NSLog(@"登录成功");
         }
     } onQueue:nil];
}

-(void)setMainTableView{
    self.mTabelView = [[HJHMessageTableViewController alloc]init];
    self.mTabelView.talkingToImage = self.taklingToImage;
    self.mTabelView.talkingToName = self.talkingToName;
    self.mTabelView.messageArray = self.messageArray;
    CGRect r = self.mTabelView.tableView.frame;
    r.origin.y = 60;
    r.size.height -= 77;
    self.mTabelView.tableView.frame = r;
    
    NSLog(@"%f",self.mTabelView.tableView.frame.size.height);
    [self.view addSubview:self.mTabelView.tableView];
    [self.view sendSubviewToBack:self.mTabelView.tableView];
    
    //初始化数据 接受数据
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.talkingFormStringName isGroup:NO];
    NSArray *messages = [conversation loadAllMessages];
    NSLog(@"+_+%@",messages);
    for (NSDictionary *dic in messages) {
        NSArray *talkMessageBodyArray = [DictionaryStringTool stringFromDictionary:dic forKey:@"messageBodies"];
        for (EMTextMessageBody *talkMessageBody in talkMessageBodyArray) {
            NSLog(@"hello +_+_+_%@,%@,%@",talkMessageBody.message.to,self.talkingToStringName,talkMessageBody.message.from);
            if ([talkMessageBody.message.to isEqualToString:self.talkingToStringName]) {
                NSString *taklMessage = talkMessageBody.text;
                HJHMessageBean *mBean = [[HJHMessageBean alloc]init];
                mBean.messageText = taklMessage;
                if ([talkMessageBody.message.from isEqualToString:self.talkingFormStringName]) {
                    mBean.isMyMessage = YES;
                }else{
                    mBean.isMyMessage = NO;
                }
                [self.messageArray addObject:mBean];
            }else if([talkMessageBody.message.from isEqualToString:self.talkingToStringName]){
                NSString *taklMessage = talkMessageBody.text;
                HJHMessageBean *mBean = [[HJHMessageBean alloc]init];
                mBean.messageText = taklMessage;
                if ([talkMessageBody.message.from isEqualToString:self.talkingFormStringName]) {
                    mBean.isMyMessage = YES;
                }else{
                    mBean.isMyMessage = NO;
                }
                [self.messageArray addObject:mBean];
            }
        }
    }
    [self.mTabelView.tableView reloadData];
}

-(void)sendMessageBtnClick:(NSString*)message{
    self.messageCount++;
    [self sendMessage:message];
}

-(void)sendMessage:(NSString*)messageContent{
    EMChatText *text = [[EMChatText alloc] initWithText:messageContent];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:text];
    EMMessage *retureMsg = [[EMMessage alloc] initWithReceiver:self.talkingToStringName bodies:[NSArray arrayWithObject:body]];
    retureMsg.requireEncryption = NO;
    retureMsg.isGroup = NO;
    
    EMMessage *message = [[EaseMob sharedInstance].chatManager asyncSendMessage:retureMsg progress:nil];
    NSLog(@"%@",message);
    
    //通过会话管理者获取已收发消息
//    NSArray *chats = [_conversation loadNumbersOfMessages:10 before:[_conversation latestMessage].timestamp + 1];
    //NSLog(@"%@",chats);
//    for (int i = chats.count - self.messageCount; i<chats.count; i++) {
//        EMMessage *emsg = [chats objectAtIndex:i];
//        //NSLog(@"%@",dic);
//        NSLog(@"%@",emsg.messageBodies);
//        EMTextMessageBody *textMsg = [emsg.messageBodies objectAtIndex:0];
//        NSLog(@"%@",textMsg.text);
//        [self.messageArray addObject:textMsg.text];
//    }
//    EMMessage *emsg = [chats lastObject];
//    NSLog(@"%@",emsg.messageBodies);
//    EMTextMessageBody *textMsg = [emsg.messageBodies lastObject];
//    NSLog(@"%@",textMsg.text);
    HJHMessageBean *mBean = [[HJHMessageBean alloc]init];
    mBean.messageText = messageContent;
    mBean.isMyMessage = YES;
    [self.messageArray addObject:mBean];
    [self.mTabelView.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘栏目弹出
#pragma mark - keyboard
-(void)showKeyboard{
    // NSLog(@"%@",InputToolbarView);
    if (InputToolbarView == nil) {
        InputToolbarView = [[UIInputToolbarViewController2 alloc]init];
        InputToolbarView.changeBarShowY = 573;
        [self addChildViewController:InputToolbarView];
        
        //InputToolbarView.mineNewComment = self.mineNewComment;
        InputToolbarView.delegate2 = self;
        InputToolbarView.delegate3 = self;
        if (!iOS7) {
            InputToolbarView.view.frame = CGRectMake(0, 573 - 20 - kIOS7 - kDefaultToolbarHeight, 320, kDefaultToolbarHeight);
        }else{
            InputToolbarView.view.frame = CGRectMake(0, 573 - kIOS7 - kDefaultToolbarHeight, 320, kDefaultToolbarHeight);
        }
        if (!iPhone5) {
            CGRect r = InputToolbarView.view.frame;
            r.size.height -= 130;
            InputToolbarView.view.frame = r;
        }
        InputToolbarView.showBarHide = YES;
        [InputToolbarView.view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:InputToolbarView.view];
        //付值放在addsubview后面
        //NSLog(@"%@",self.mineNewComment);
//        if (self.mineNewComment == nil) {
//            self.InputToolbarView.inputToolbar.textView.placeholder = @"发表评论";
//        }else{
//            self.InputToolbarView.inputToolbar.textView.placeholder = [NSString stringWithFormat:@"回复：",self.mineNewComment];
//        }
    }
}

-(void)postMessage:(NSString *)message{
    [self sendMessageBtnClick:message];
}

#pragma mark - IChatManagerDelegate
-(void)didReceiveMessage:(EMMessage *)message{
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.talkingFormStringName isGroup:NO];
    EMMessage *messages = [conversation loadMessage:message.messageId];
    NSLog(@"+_+_%@",messages.messageBodies);
    EMTextMessageBody *messageBody = [messages.messageBodies lastObject];
    HJHMessageBean *mBean = [[HJHMessageBean alloc]init];
    mBean.messageText = messageBody.text;
    if ([message.from isEqualToString:self.talkingFormStringName]) {
        mBean.isMyMessage = YES;
    }
    [self.messageArray addObject:mBean];
    [self.mTabelView.tableView reloadData];
    
    
}

-(void)keyboardShow{
    CGRect r = self.mTabelView.tableView.frame;
    r.origin.y = -215 + 60;
    self.mTabelView.tableView.frame = r;
}

-(void)keyboardHide{
    CGRect r = self.mTabelView.tableView.frame;
    r.origin.y = 60;
    self.mTabelView.tableView.frame = r;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
