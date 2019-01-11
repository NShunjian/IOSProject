//
//  pcmPlayer.m
//  MSCDemo
//
//  Created by wangdan on 14-11-4.
//
//

#import "PcmPlayer.h"

typedef struct Wavehead
{
    /****RIFF WAVE CHUNK*/
    unsigned char a[4];     //Four bytes: 'R','I','F','F'
    long int b;             //Size of Chunk
    unsigned char c[4];     //Four bytes: 'W','A','V','E'
    /****RIFF WAVE CHUNK*/
    /****Format CHUNK*/
    unsigned char d[4];     //Four bytes: 'f','m','t',''
    long int e;             //16: no additional information，18: additional information；
    short int f;            //encoding mode，default,0x0001;
    short int g;            //channel，1:mono，2:stereo;
    int h;                  //sample rate;
    unsigned int i;         //bytes per second;
    short int j;            //bytes per sample;
    short int k;            //bitDepth
    /****Format CHUNK*/
    /***Data Chunk**/
    unsigned char p[4];     //Four bytes: 'd','a','t','a'
    long int q;             //length of audio data, not include WAV head
} WaveHead;//Structure of WAV head


@interface PcmPlayer ()

@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSMutableData *pcmData;
@property (nonatomic,strong) NSTimer *timer;

@end


@implementation PcmPlayer




-(id)initWithFilePath:(NSString *)path sampleRate:(long)sample
{
    self = [super init];
    
    if (self) {
        NSData *audioData = [NSData dataWithContentsOfFile:path];
        [self writeWaveHead:audioData sampleRate:sample];
        NSLog(@"nihao");
    }
    return self;
}

-(id)initWithData:(NSData *)data sampleRate:(long)sample
{
    if (data == nil) {
        return nil;
    }
    self = [super init];
    if (self) {
        [self writeWaveHead:data sampleRate:sample];
        NSLog(@"nihao");
    }
    return self;
    
}


/**
 *
 *  write WAV head for audio data
 *
 */
- (void)writeWaveHead:(NSData *)audioData sampleRate:(long)sampleRate{
    Byte waveHead[44];
    waveHead[0] = 'R';
    waveHead[1] = 'I';
    waveHead[2] = 'F';
    waveHead[3] = 'F';
    
    long totalDatalength = [audioData length] + 44;
    waveHead[4] = (Byte)(totalDatalength & 0xff);
    waveHead[5] = (Byte)((totalDatalength >> 8) & 0xff);
    waveHead[6] = (Byte)((totalDatalength >> 16) & 0xff);
    waveHead[7] = (Byte)((totalDatalength >> 24) & 0xff);
    
    waveHead[8] = 'W';
    waveHead[9] = 'A';
    waveHead[10] = 'V';
    waveHead[11] = 'E';
    
    waveHead[12] = 'f';
    waveHead[13] = 'm';
    waveHead[14] = 't';
    waveHead[15] = ' ';
    
    waveHead[16] = 16;  //size of 'fmt '
    waveHead[17] = 0;
    waveHead[18] = 0;
    waveHead[19] = 0;
    
    waveHead[20] = 1;   //format
    waveHead[21] = 0;
    
    waveHead[22] = 1;   //chanel
    waveHead[23] = 0;
    
    waveHead[24] = (Byte)(sampleRate & 0xff);
    waveHead[25] = (Byte)((sampleRate >> 8) & 0xff);
    waveHead[26] = (Byte)((sampleRate >> 16) & 0xff);
    waveHead[27] = (Byte)((sampleRate >> 24) & 0xff);
    
    long byteRate = sampleRate * 2 * (16 >> 3);;
    waveHead[28] = (Byte)(byteRate & 0xff);
    waveHead[29] = (Byte)((byteRate >> 8) & 0xff);
    waveHead[30] = (Byte)((byteRate >> 16) & 0xff);
    waveHead[31] = (Byte)((byteRate >> 24) & 0xff);
    
    waveHead[32] = 2*(16 >> 3);
    waveHead[33] = 0;
    
    waveHead[34] = 16;
    waveHead[35] = 0;
    
    waveHead[36] = 'd';
    waveHead[37] = 'a';
    waveHead[38] = 't';
    waveHead[39] = 'a';
    
    long totalAudiolength = [audioData length];
    
    waveHead[40] = (Byte)(totalAudiolength & 0xff);
    waveHead[41] = (Byte)((totalAudiolength >> 8) & 0xff);
    waveHead[42] = (Byte)((totalAudiolength >> 16) & 0xff);
    waveHead[43] = (Byte)((totalAudiolength >> 24) & 0xff);
    
    self.pcmData = [[NSMutableData alloc]initWithBytes:&waveHead length:sizeof(waveHead)];
    [self.pcmData appendData:audioData];
    
    NSError *err = nil;
    self.player = [[AVAudioPlayer alloc]initWithData:self.pcmData error:&err];
    if (err)
    {
        NSLog(@"%@",err.localizedDescription);
    }
    self.player.delegate = self;
    [self.player prepareToPlay];
    
}

- (void)play
{
    
    if (self.isPlaying)
    {
        NSLog(@"pcmPlayer isPlaying");
        return;
    }
    self.isPlaying = YES;
    
    self.player.volume=1;
    if ([self.pcmData length] > 44)
    {
        self.player.meteringEnabled = YES;
        NSLog(@"Audio Duration:%f",self.player.duration);
        
        BOOL ret = [self.player play];
        NSLog(@"play ret=%d",ret);
    }
    else
    {
        self.isPlaying = NO;
        NSLog(@"empty audio data");
    }
    
}

- (void)stop
{
    if (self.isPlaying) {
        self.isPlaying = NO;
        [self.player stop];
        self.player.currentTime = 0;
    }
}


#pragma mark speechRecordDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"in pcmPlayer audioPlayerDidFinishPlaying");
    self.isPlaying=NO;
}


@end
