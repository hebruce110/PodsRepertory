//
//  VViewController.m
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VViewController.h"
#import "Webservice_Header.h"

#define kUploadImageMaxBytes 300000  //300kb

@interface VViewController ()

@end

@implementation VViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)getVerifyCode
{
    [VWebService getRequestAction:kAPIAccoutGetVerifyCode
                        parameter:@{@"username": @"zengxiaojuan",@"password": @"123456"}
                    callbackBlock:^(id result, BOOL status, NSError *error) {
                        HYLog(@"%@",result);
                    }];
}

- (IBAction)uploadAction:(id)sender
{
    
    [VWebService postRequestUrl:@"http://10.1.1.172/uploadfiles.php"
                         action:nil
                      parameter:nil
                     uploadFile:[self multipartFormDataBlock]
                       progress:[self uploadProgressBlock]
                  callbackBlock:^(id result, BOOL status, NSError *error) {
                      if (status) {
                          HYLog(@"%@",result);
                      }else{
                          HYLog(@"%@",error.localizedDescription);
                      }
    }];
}

//设置上传文件的block
- (VRequestMultipartFormDataBlock)multipartFormDataBlock
{
    return  ^(id<AFMultipartFormData> formData){
        UIImage *uploadImage = Image(@"demo.jpg");
        if (uploadImage) {
            NSData *data =  [UIImage compressImageData:uploadImage initCompression:1.0 maxSize:kUploadImageMaxBytes]; //压缩图片，max 300k
            [formData appendPartWithFileData:data name:@"upfile" fileName:@"upfile.jpg" mimeType:@"image/jpeg"];
        }
    };
}

//上传progress回调的block，可以在这里更新进度条
- (VRequestUploadProgressBlock)uploadProgressBlock
{
    return ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        CGFloat percent = totalBytesWritten/(float)totalBytesExpectedToWrite;
        HYLog(@"%f",percent);
    };
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
