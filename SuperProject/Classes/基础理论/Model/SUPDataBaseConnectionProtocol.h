

#import <Foundation/Foundation.h>



@protocol SUPDataBaseConnectionProtocol <NSObject>

@optional

- (void)suspend;

@required

- (void)start;

- (void)end;


@end
