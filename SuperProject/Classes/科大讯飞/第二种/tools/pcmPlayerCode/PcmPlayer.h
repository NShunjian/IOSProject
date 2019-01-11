//
//  pcmPlayer.h
//  MSCDemo
//
//  Created by wangdan on 14-11-4.
//
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>

@interface PcmPlayer : NSObject<AVAudioPlayerDelegate>

/**
 * initialize player and set the loacl path of audio file
 *
 * path   the loacl path of audio file
 * sample sample rate of audio，only for 8000 and 16000
 **/
-(id)initWithFilePath:(NSString *)path sampleRate:(long)sample;

/**
 * initialize player and set audio data
 *
 * data   audio data
 * sample sample rate of audio，only for 8000 and 16000
 **/
-(id)initWithData:(NSData *)data sampleRate:(long)sample;

/**
 start playing
 ****/
- (void)play;

/**
 stop playing
 **/
- (void)stop;

/**
 whether or not it's playing
 ****/
@property (nonatomic,assign) BOOL isPlaying;

@end
