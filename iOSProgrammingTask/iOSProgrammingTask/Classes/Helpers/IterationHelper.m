//
//  IterationHelper.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IterationHelper.h"
#import "Additions.h"

@implementation IterationHelper

@synthesize book = _book;

#pragma mark - set attribute values to textfield

-(void)authorValuetoTextField
{
    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString appendFormat:@"%@, %@", author.surname, author.firstName];
    }
}

-(void)publisherValuetoTextField
{
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString appendFormat:@"%@", publisher.name];
    }
}

-(void)ReviewValuetoTextField
{
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString appendFormat:@"%@, %@", review.rating];
    }
}


#pragma mark - set empty string text to attributes

-(void)emptyStringtoAuthor
{
    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString stringByAppendingFormat:@""];
    }
}

-(void)emptyStringtoPublisher
{
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString stringByAppendingFormat:@""];;
    }
}

-(void)emptyStringtoReview
{
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString stringByAppendingFormat:@""];
    }
}

#pragma mark - set TextfieldValues to attributes

//-(void)textFieldValuetoAuthor
//    {
//    NSMutableSet *authorSet = [NSMutableSet set];
//    NSArray *authorArray = [self.book.authors allObjects];
//    for (Author *author in authorArray) {
//        [authorSet addObject:self.authorsValue.text];
//    }
//}
//
//
//-(void)textFieldValuetoPublisher
//{
//    NSMutableSet *publisherSet = [NSMutableSet set];
//    NSArray *publisherArray = [self.book.publishers allObjects];
//    for (Publisher *publisher in publisherArray) {
//        [publisherSet addObject:self.publisherValue.text];
//    }
//}
//
//
//-(void)textFieldValuetoReview
//{
//    NSMutableSet *reviewSet = [NSMutableSet set];
//    NSArray *reviewArray = [self.book.reviews allObjects];
//    for (Review *review in reviewArray) {
//        [reviewSet addObject:self.reviewValue.text];
//    }
//}

@end
