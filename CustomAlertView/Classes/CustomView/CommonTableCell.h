//
//  CommonTableCell.h
//  ewsports
//
//  Created by ywy on 2017/4/11.
//  Copyright © 2017年 ywy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FieldType) {
    FieldTypeDefault = 0, // 右边没内容
    FieldTypeText, // 右边展示
    FieldTypeEdit, // textField
    FieldTypeSwitch,
    FieldTypeSwitchCustom,
};
@interface CustomFieldInfo : NSObject
@property (assign, nonatomic) NSInteger fieldId;
@property (assign) FieldType dataType;
@property (nonatomic, copy) NSString *iconImg;
@property (copy,nonatomic) NSString* title;
@property (copy,nonatomic) NSString* value;
@property (nonatomic, assign) BOOL hasArrow;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, assign) BOOL selectState;
@property (strong,nonatomic) id data;
@property (nonatomic, strong) id extendData;

@property (copy,nonatomic) NSString* placeholder;
@property (assign, nonatomic) UIKeyboardType type;
@property (strong, nonatomic) UIColor *placeholderColor;
@property (strong, nonatomic) UIColor *textColor;
@property (assign, nonatomic) NSInteger extendNum;
@property (assign, nonatomic) UITextFieldViewMode clearModel;
@property (assign, nonatomic) NSInteger textMaxLength;

// yes不能使用 NO能使用
@property (nonatomic, assign) BOOL disEnable;


// switch的图片
@property(nonatomic, copy) NSString *onImage;
@property(nonatomic, copy) NSString *offImage;

+ (CustomFieldInfo *)getFieldInfoWithField:(NSInteger)fieldId inDataArray:(NSArray *)array;
@end

@interface FieldCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *valueTextField;
@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) CustomFieldInfo *fi;

@property (nonatomic,copy)  void (^didSwitchChanged)(BOOL state);
@property (nonatomic,copy)  void (^didTextChanged)(FieldCell *cell, NSString *changeStr);

+ (instancetype)fieldCellWithTableView:(UITableView *)tableView;
- (void)updateCell:(CustomFieldInfo *)info;
+(CGFloat)getHeight;
@end
