//
//  ScoutStuckMonitor.m
//  Scout
//
//  Created by slyfy27 on 2021/7/16.
//

#import "ScoutStuckMonitor.h"

@interface ScoutStuckMonitor() {
    CFRunLoopObserverRef runLoopObserver;
    @public
    dispatch_semaphore_t seamphore;
    CFRunLoopActivity runloopActivity;
}

@end

@implementation ScoutStuckMonitor

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ScoutStuckMonitor alloc] init];
    });
    return instance;
}

- (void)start {
    ///  已经创建了observer，不重复创建
    if (runLoopObserver) {
        return;
    }
    seamphore = dispatch_semaphore_create(0);
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                              kCFRunLoopAllActivities,
                                              YES,
                                              0,
                                              &runLoopObserverCallBack,
                                              &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    //子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            
        }
    });
}

- (void)stop {
    
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer,CFRunLoopActivity activity, void *info) {
    ScoutStuckMonitor *monitor = (__bridge ScoutStuckMonitor*)info;
    monitor->runloopActivity = activity;
    dispatch_semaphore_signal(monitor->seamphore);
}

@end
