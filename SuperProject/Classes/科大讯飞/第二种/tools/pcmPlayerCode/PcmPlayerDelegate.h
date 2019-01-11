//
//  speechRecordDelegate.h
//  MSCDemo
//
//  Created by wangdan on 14-11-4.
//
//

#import <Foundation/Foundation.h>

@protocol PcmPlayerDelegate<NSObject>

@optional

//playback completion
-(void)onPlayCompleted;

@end
