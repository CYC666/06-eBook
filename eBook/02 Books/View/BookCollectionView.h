//
//  BookCollectionView.h
//  eBook
//
//  Created by CYC on 16/4/29.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BookCollectionView : UICollectionView

@property (strong, nonatomic) NSArray *subBookModels;
@property (assign, nonatomic)NSInteger currentPage;     //当前页码

@end
