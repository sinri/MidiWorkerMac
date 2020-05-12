//
//  MidiWorkerMacTests.m
//  MidiWorkerMacTests
//
//  Created by Sinri Edogawa on 2020/5/12.
//  Copyright © 2020 Sinri Edogawa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MidiWorkerMac/MidiWorkerMac.h>

@interface MidiWorkerMacTests : XCTestCase

@property MidiWorker * worker;

@end

@implementation MidiWorkerMacTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _worker=[[MidiWorker alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _worker=nil;
    NSLog(@"tear down!");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //Default Settings
    //Name
    [_worker setName:@"选本129首"];
    //Tempo
    [_worker setTempo:0x078300];
    //Time Signature
    [_worker setTimeSignatureNumerator:4];
    [_worker setTimeSignatureDenominator:2];
    [_worker setTimeSignatureMetronome:24];
    [_worker setTimeSignature32ndCount:8];
    //Key Signature
    [_worker setKeySignature:Major_C];
    
    MidiTrace * mt=[[MidiTrace alloc]init];
    
    NSString * numberedNotes=@"1=C \
    3 3 4 5 | 5 4 3 2 | 1 1 2 3 | 3. 2_ 2- | \
    3 3 4 5 | 5 4 3 2 | 1 1 2 3 | 2. 1_ 1- | \
    2 2 3 1 | 2 3_ 4_ 3 1 | 2 3_ 4_ 3 2 | 1 2 -5- | \
    3 3 4 5 | 5 4 3 2 | 1 1 2 3 | 2. 1_ 1- | \
    |: 1 3 5 1 :||";
    [mt setNoteArray:[[MidiNote MidiNoteArrayMakerForChannel:0 NumberedMusicialNotation:numberedNotes]mutableCopy]];

    [_worker.traceArray addObject:mt];
    
    
    NSData * filedata=[_worker buildMidiFileData];
    
    NSLog(@"FileData START");
    NSLog(@"%@",filedata);
    NSLog(@"FileData END");
    
    NSString*musicDirPath=[NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString*musicFilePath=[NSString stringWithFormat:@"%@/test.mid",musicDirPath];
    BOOL done=[filedata writeToFile:musicFilePath atomically:YES];
    NSLog(@"written=%d",done);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSLog(@"i do not know what to do");
    }];
}

@end
