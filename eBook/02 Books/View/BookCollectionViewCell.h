//
//  BookCollectionViewCell.h
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface BookCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) BookModel *bookModel;

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@end
