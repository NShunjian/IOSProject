//
//  HomePageVC.m
//  全靠浪
//
//  Created by Ben on 2017/4/15.
//  Copyright © 2017年 QQingiOSTeam. All rights reserved.
//

#import "HomePageVC.h"

static const NSUInteger kMaxQuestionTextLength = 200;
static const NSUInteger kMaxAddressTextLength = 50;
static NSString *kTextTooShortTipText = @"至少输入10个字";

@interface HomePageVC () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *textViewContentView;
@property (weak, nonatomic) IBOutlet UIView *textViewBackgroundView;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *placeHolderTextView;
@property (weak, nonatomic) IBOutlet UILabel *textViewTipLabel;
@property (weak, nonatomic) IBOutlet QQingSTTView *textViewSTTView;

@property (weak, nonatomic) IBOutlet UIView *textFieldContentView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) QQingSTTView *textFieldSTTView;

@end

@implementation HomePageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private methods

- (void)initUI {
    self.title = @"语音辅助输入";
    
    self.textViewBackgroundView.layer.borderWidth = 1;
    self.textViewBackgroundView.layer.borderColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1].CGColor;
    self.textViewBackgroundView.layer.cornerRadius = 3;
    
    self.placeHolderTextView.placeholder = @"输入您的问题，您的问题被专家回答后，如被其他用户付费收听，即可分成0.5元。";
//    self.placeHolderTextView.backgroundColor = [UIColor redColor];
    self.placeHolderTextView.placeholderType = PlaceholderType_Left;
    self.placeHolderTextView.textColor = [UIColor colorWithRed:48/255.0f green:48/255.0f blue:48/255.0f alpha:1];
    self.textViewSTTView.backgroundColor = [UIColor yellowColor];
    self.textViewSTTView.inputControl = self.placeHolderTextView;
    
    [self refreshTextViewTipLabel];
    
    UIView *leftBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
    leftBlankView.backgroundColor = [UIColor clearColor];
    self.addressTextField.leftView = leftBlankView;
    self.addressTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.textFieldSTTView = [[QQingSTTView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.textFieldSTTView.backgroundColor = [UIColor redColor];
    self.textFieldSTTView.inputControl = self.addressTextField;
    self.textFieldSTTView.hideBorder = YES;
    self.addressTextField.rightView = self.textFieldSTTView;
    self.addressTextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.addressTextField.layer.borderWidth = 1;
    self.addressTextField.layer.borderColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1].CGColor;
    self.addressTextField.layer.cornerRadius = 3;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.addressTextField];
    
//    [self.confirmButton stSolidGreenThematized];
    self.confirmButton.layer.cornerRadius = 5;
}

#pragma mark - UITextViewDelegate and related methods

- (BOOL)isTextBeyondLimit:(UITextView *)textView {
    NSString *lang = [[textView textInputMode] primaryLanguage];
    if ([lang hasPrefix:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (textView.text.length > (kMaxQuestionTextLength - 1)) {
                return YES;
            }
        }
    } else {
        if (textView.text.length > (kMaxQuestionTextLength - 1)) {
            return YES;
        }
    }
    
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *lang = [[textView textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang hasPrefix:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (textView.text.length > (kMaxQuestionTextLength - 1)) {
                textView.text = [textView.text substringToIndex:kMaxQuestionTextLength];
                
                [QQingUtils showToastWithText:@"超过最大字数限制"];
            }
            
            [self refreshTextViewTipLabel];
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (textView.text.length > (kMaxQuestionTextLength - 1)) {
            textView.text = [textView.text substringToIndex:kMaxQuestionTextLength];
            
            [QQingUtils showToastWithText:@"超过最大字数限制"];
        }
        
        [self refreshTextViewTipLabel];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self isTextBeyondLimit:textView] && [text length] > 0) {
        [QQingUtils showToastWithText:@"超过最大字数限制"];
        return NO;
    }
    
    return YES;
}

- (void)refreshTextViewTipLabel {
    if (self.placeHolderTextView.text.length < 10) {
        self.textViewTipLabel.text = kTextTooShortTipText;
    } else {
        self.textViewTipLabel.text = [NSString stringWithFormat:@"%tu/%tu", [self.placeHolderTextView.text length], kMaxQuestionTextLength];
    }
}

#pragma mark - UITextFieldDelegate and related methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSUInteger maxLength = kMaxAddressTextLength - self.addressTextField.text.length;//总字数不能超上限
    if ([toBeString length] > maxLength) {
        textField.text = [toBeString substringToIndex:maxLength];
        [QQingUtils showToastWithText:@"超过最大字数限制"];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidChange:(NSNotification *)obj {
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang hasPrefix:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxAddressTextLength) {
                NSRange originSelectedRange = [textField selectedRange];
                textField.text = [toBeString substringToIndex:kMaxAddressTextLength];
                if (originSelectedRange.location < textField.text.length) {
                    [textField setSelectedRange:NSMakeRange(originSelectedRange.location, 0)];
                }
                [QQingUtils showToastWithText:@"超过最大字数限制"];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxAddressTextLength) {
            NSRange originSelectedRange = [textField selectedRange];
            textField.text = [toBeString substringToIndex:kMaxAddressTextLength];
            if (originSelectedRange.location < textField.text.length) {
                [textField setSelectedRange:NSMakeRange(originSelectedRange.location, 0)];
            }
            [QQingUtils showToastWithText:@"超过最大字数限制"];
        }
    }
    
    if (self.addressTextField.text.length > 0) {
        self.confirmButton.enabled = YES;
    } else {
        self.confirmButton.enabled = NO;
    }
}

@end


