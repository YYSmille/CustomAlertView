//
//  CommonTableCell.m
//  ewsports
//
//  Created by ywy on 2017/4/11.
//  Copyright © 2017年 ywy. All rights reserved.
//
#define FONT_WITH_SIZE(x)       [UIFont systemFontOfSize:x]

#define SCALE_WIDTH_EX(ref_w, ref_h, h) (ref_w * h / ref_h)
#define SCALE_HEIGHT_EX(ref_w, ref_h, w) (ref_h * w / ref_w)
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#import "CommonTableCell.h"
#import <Masonry/Masonry.h>
@implementation CustomFieldInfo

+ (CustomFieldInfo *)getFieldInfoWithField:(NSInteger)fieldId inDataArray:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        for (id item in array) {
            if ([item isKindOfClass:[NSArray class]]) {
                CustomFieldInfo *info = [self getFieldInfoWithField:fieldId inDataArray:item];
                if (info != nil && info.fieldId == fieldId) {
                    return info;
                }
            }
            
            if ([item isKindOfClass:[CustomFieldInfo class]]) {
                CustomFieldInfo *info = item;
                if (info.fieldId == fieldId) {
                    return info;
                }
            }
        }
    }
    
    return nil;
}
@end

@implementation FieldCell
{
    UILabel* _titleLabel;
    UISwitch* _switch;
    UIButton *_switchBtn;
    
    UIImageView* _arrowImageView;
    UIImageView *_iconImgView;
}

+ (instancetype)fieldCellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseIdentifier = @"FieldCell";
    FieldCell* cell = (FieldCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if( cell == nil )
    {
        cell = [[FieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 头像
        float x, y, w ,h;
//        x = 15.f;
//        y = 0;
//        w = h = 22.f;
//        y = ([FieldCell getHeight] - h) * .5f;
        _iconImgView = [[UIImageView alloc] init];
//        _iconImgView.frame = CGRectMake(x, y, w, h);
        [self.contentView addSubview:_iconImgView];
        [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.offset(15);
        }];
        // 标题
//        x += w + 8.f;
//        h = [FieldCell getHeight];
//        y = ([FieldCell getHeight] - h) * .5f;
//        w = 200.f;
        UILabel* label;
//        label = [[UILabel alloc] initWithFrame:CGRectMake(x ,y, w , h)];
        label = [[UILabel alloc] init];
        label.text = @"";
        label.font = FONT_WITH_SIZE(15.f);
        label.backgroundColor = [UIColor clearColor];
//        label.textColor = CustomCellTextColor;
        label.textColor = [UIColor grayColor];
        [self.contentView addSubview:label];
//        CGSize sz = [MyUtils calcTextSizeWithSingleLineLabel:label];
//        w = sz.width + 2;
//        label.frame = CGRectMake(x, y, w, h);
        _titleLabel = label;
        
        // 箭头
        UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
        [self.contentView addSubview:imgView];
        _arrowImageView = imgView;
        h = imgView.frame.size.height;
        w = imgView.frame.size.width;
        x = SCREEN_WIDTH - w - 15.f;
        y = ([FieldCell getHeight] - h) / 2.f;
        imgView.frame = CGRectMake(x, y, w, h);
        
//        y = _titleLabel.frame.origin.y;
//        h = _titleLabel.frame.size.height;
        
//        UITextField* tf = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
        UITextField* tf = [[UITextField alloc] init];
        tf.textColor = [UIColor blackColor];
        tf.font = FONT_WITH_SIZE(15);
        tf.textAlignment = NSTextAlignmentRight;
        
        //    [tf setValue:MAIN_THEME_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        tf.returnKeyType = UIReturnKeyDone;
        tf.hidden = YES;
        tf.clearButtonMode = UITextFieldViewModeNever;
        tf.delegate = self;
        [self.contentView addSubview:tf];
        _valueTextField = tf;
        
//        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        label = [[UILabel alloc] init];
        label.text = @"";
        label.font = FONT_WITH_SIZE(15);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        _valueLabel = label;
        
        h = 20;
        w = SCALE_WIDTH_EX(104, 58, h);
        x = SCREEN_WIDTH - w - 15;
        y = ([FieldCell getHeight] - h ) / 2;
        
        _switch = [[UISwitch alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _switch.hidden = YES;
        [_switch addTarget:self action:@selector(on_btn_switch:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_switch];
        
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchBtn.hidden = YES;
        [_switchBtn addTarget:self action:@selector(on_custom_switch:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_switchBtn];
        [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15.f);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];

        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor grayColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.right.bottom.equalTo(self.contentView);
            make.height.offset(0.5);
        }];
    }
    return self;
}

- (void)updateCell:(CustomFieldInfo *)info
{
    _fi = info;
    CGFloat x, y, w, h;
    if (info.hasIcon)
    {
        _iconImgView.hidden = NO;
        y = 0;
        w = h = 22.f;
//        y = ([FieldCell getHeight] - h) * .5f;
        x = 15.f;
        [_iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.offset(x);
        }];
//        _iconImgView.frame = CGRectMake(x, y, w, h);
        _iconImgView.image = [UIImage imageNamed:info.iconImg];
        x += w + 8.f;
    }
    else
    {
        _iconImgView.hidden = YES;
        x = 15.f;
    }
    
    
    _titleLabel.text = info.title;
    CGSize sz = [_titleLabel.text sizeWithFont:_titleLabel.font forWidth:CGFLOAT_MAX lineBreakMode:NSLineBreakByTruncatingTail];
    w = sz.width;
    h = sz.height;
    y = ([FieldCell getHeight] - h) *.5f;
    _titleLabel.frame = CGRectMake(x, y, w, h);

    x += w + 5.f;
    
//    if (info.valueFont) {
//        _valueLabel.font = info.valueFont;
//        _valueTextField.font = info.valueFont;
//    }
    
    CGFloat right = _arrowImageView.frame.origin.x - 5.f;
    if( !info.hasArrow )
        right = SCREEN_WIDTH - 10.f;
    
    if( !info.hasArrow || info.dataType == FieldTypeSwitch)
        _arrowImageView.hidden = YES;
    else
        _arrowImageView.hidden = NO;
    
    if (info.dataType == FieldTypeEdit)
    {
        w = right - x;
        if (w < 50.f) w = 50.f;
        h = [FieldCell getHeight];
        y = 0;
        _valueTextField.frame = CGRectMake(x, y, w, h);
        
        _valueTextField.keyboardType = info.type;
        _valueTextField.text = info.value;
        _valueTextField.placeholder = info.placeholder;
        if (info.textColor)
        {
            _valueTextField.textColor = info.textColor;
        }
        
        if (info.placeholderColor)
        {
            [_valueTextField setValue:info.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        }
        _valueTextField.userInteractionEnabled = !info.disEnable;

        _valueTextField.hidden = NO;
        _valueLabel.hidden = YES;
        _switchBtn.hidden = YES;
        
        if (info.clearModel)
        {
            _valueTextField.clearButtonMode = info.clearModel;
        }
        else
            _valueTextField.clearButtonMode = UITextFieldViewModeNever;

        
        _valueLabel.hidden = YES;
        _switch.hidden = YES;
    }
    else if (info.dataType == FieldTypeSwitch)
    {
        right = SCREEN_WIDTH;//_arrowImageView.frame.origin.x;
        _arrowImageView.hidden = YES;
        
        _valueLabel.hidden = YES;
        _valueTextField.hidden = YES;
        _switch.hidden = NO;
        _switchBtn.hidden = YES;
        _switch.userInteractionEnabled = !info.disEnable;

        CGRect rc = _switch.frame;
        rc.origin.x = right - 10 - rc.size.width;
        rc.origin.y = ([FieldCell getHeight] - rc.size.height) / 2;
        _switch.frame = rc;
        
        
        if( info.data && [info.data intValue] != 0 )
            _switch.on = YES;
        else
            _switch.on = NO;
    }
    else if (info.dataType == FieldTypeSwitchCustom)
    {
        right = SCREEN_WIDTH;//_arrowImageView.frame.origin.x;
        _arrowImageView.hidden = YES;
        
        _valueLabel.hidden = YES;
        _valueTextField.hidden = YES;
        _switch.hidden = YES;
        _switchBtn.hidden = NO;
        
        if( info.data && [info.data intValue] != 0 )
            _switchBtn.selected = YES;
        else
            _switchBtn.selected = NO;
        
        _switchBtn.userInteractionEnabled = !info.disEnable;
    
        if (info.onImage.length)
        {
            [_switchBtn setImage:[UIImage imageNamed:info.offImage] forState:UIControlStateNormal];
            [_switchBtn setImage:[UIImage imageNamed:info.onImage] forState:UIControlStateSelected];
            [_switchBtn setImage:[UIImage imageNamed:info.onImage] forState:UIControlStateHighlighted];
        }

    }
    else if (info.dataType == FieldTypeText)
    {
        _valueTextField.hidden = YES;
        _switch.hidden = YES;
        _valueLabel.hidden = NO;
        _switchBtn.hidden = YES;

        w = right - x;
        if (w < 50.f) w = 50.f;
        h = [FieldCell getHeight];
        y = 0;
        _valueLabel.frame = CGRectMake(x, y, w, h);
        
        if( [info.value length] == 0 )
        {
            _valueLabel.text = info.placeholder;
        }
        else
        {
            _valueLabel.text = info.value;
        }
        
        if (info.textColor)
        {
            _valueLabel.textColor = info.textColor;
        }
    }
    else
    {
        _valueTextField.hidden = YES;
        _switch.hidden = YES;
        _valueLabel.hidden = YES;
        _switchBtn.hidden = YES;
    }

}

-(void)on_btn_switch:(UISwitch*)sw
{
    if( self.didSwitchChanged)
    {
        self.didSwitchChanged(sw.on);
    }
}

-(void)on_custom_switch:(UIButton*)btn
{
    btn.selected = !btn.selected;
    if( self.didSwitchChanged)
    {
        self.didSwitchChanged(btn.selected);
    }
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didTextChanged)
    {
        self.didTextChanged(self, textField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@"\n"]) {
        //按会车可以改变
        return YES;
    }

    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.didTextChanged)
    {
        self.didTextChanged(self, toBeString);
    }

    if (_fi.textMaxLength > 0)
    {
//        NSLog(@"字符长度%zd", [DataTool getStringLengthToInt:toBeString]);
//        if ([DataTool getStringLengthToInt:toBeString] > _fi.textMaxLength) {
//            return NO;
//        }
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

+ (CGFloat)getHeight
{
    return 75.f;
}

@end
