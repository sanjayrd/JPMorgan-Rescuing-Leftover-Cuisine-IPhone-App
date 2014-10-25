//
//  AnnotationDelegate.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/25/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationDelegate : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}







@end
