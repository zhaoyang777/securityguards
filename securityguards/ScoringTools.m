//
//  ScoringTools.m
//  securityguards
//
//  Created by Zhao yang on 8/18/14.
//  Copyright (c) 2014 hentre. All rights reserved.
//

#import "ScoringTools.h"
#import "Sensor.h"

@implementation ScoringTools

+ (NSNumber *)scoringForUnit:(Unit *)unit {
    if(unit == nil) return nil;
    float score = 0.f;
    
    /*
     *  range of sensor data value is [ >=1 && <= 6]
     */
    float pm25Score = 0.f;
    float vocScore = 0.f;
    float cameraScore = 0.f;
    float bodyDetectorScore = 0.f;
    float smokeDetectorScore = 0.f;
    
    for(Sensor *sensor in unit.sensors) {
        if(sensor.isPM25Sensor) {
            pm25Score = (6 - sensor.data.value) * 7.f;
            if(pm25Score > 35.f) pm25Score = 35.f;
        } else if(sensor.isVOCSensor) {
            vocScore = (6 - sensor.data.value) * 3.f;
            if(vocScore > 15.f) vocScore = 15.f;
        }
    }
    
    for(Device *device in unit.devices) {
        if(device.isCamera && device.isOnline) {
            cameraScore = 15.f;
        } else if(device.isBodyDetector) {
            if(device.isOnline) {
                if(device.isLowBattery && bodyDetectorScore < 5.f) {
                    bodyDetectorScore = 5.f;
                } else {
                    bodyDetectorScore = 10.f;
                }
            }
        } else if(device.isSmokeDetector) {
            if(device.isOnline) {
                if(device.isLowBattery && smokeDetectorScore < 5.f) {
                    smokeDetectorScore = 5.f;
                } else {
                    smokeDetectorScore = 15.f;
                }
            }
        }
    }
    
    score = pm25Score + vocScore + cameraScore + bodyDetectorScore + smokeDetectorScore;
    if(score > 90.f) score = 90.f;

#ifdef DEBUG
    NSLog(@"Score [pm25=%.0f, voc=%.0f, camera=%.0f, body_detector=%.0f, smoke_detector=%.0f]",
            pm25Score, vocScore, cameraScore, bodyDetectorScore, smokeDetectorScore);
#endif
    
    return [NSNumber numberWithFloat:score];
}

+ (float)rankingForScore:(float)score {
    if(score < 50) return 0.3f;
    if(score >= 50 && score < 60) return 0.6f;
    if(score >= 60 && score < 70) return 0.7f;
    if(score >= 70 && score < 80) return 0.8f;
    if(score >= 90.f) return 0.95f;
    return 0.f;
}

@end
