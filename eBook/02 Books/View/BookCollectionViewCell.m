//
//  BookCollectionViewCell.m
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "BookCollectionViewCell.h"

@implementation BookCollectionViewCell


- (void)setBookModel:(BookModel *)bookModel {
    _bookModel = bookModel;
    //给封面设置图片
    _bookImageView.image = [UIImage imageNamed:_bookModel.image];
}



@end
