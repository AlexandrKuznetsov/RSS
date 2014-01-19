//
//  TIMLocalUserInfo.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLocalUserInfo.h"

@implementation TIMLocalUserInfo

static TIMLocalUserInfo *sharedInstance = nil;

+ (TIMLocalUserInfo *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super alloc] init];
    });
    return sharedInstance;
}

- (BOOL)readUserFromUserDefaults {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"]) {
        self.user = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]];
        return YES;
    } else {
        self.user = [[NSMutableDictionary alloc] init];
        return NO;
    }
}

- (void)saveUserInfoInUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:self.user forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)createUserDirectoryForPhotos {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *nameString = @"User";
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:nameString];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
        return dataPath;
    }
    else {
        return nil;
    }
}

- (NSString *)saveImage:(UIImage *)image withName:(NSString *)name {
    NSString* imagePath = [[self createUserDirectoryForPhotos] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    NSData* data = UIImagePNGRepresentation(image);
    if (data) {
        if ([data writeToFile:imagePath atomically:YES]) {
            return imagePath;
        } else {
            return nil;
        }
    }
    else
        return nil;
}

#pragma mark - Setters 

- (void)setName:(NSString *)name {
    _name = name;
    [self.user setObject:name forKey:@"name"];
}

- (void)setSurname:(NSString *)surname {
    _surname = surname;
    [self.user setObject:surname forKey:@"surname"];
}

- (void)setBirthday:(NSString *)birthday {
    _birthday = birthday;
    [self.user setObject:birthday forKey:@"birthday"];
}

- (void)setGender:(NSString *)gender {
    _gender = gender;
    [self.user setObject:gender forKey:@"gender"];
}

- (void)setDefaultLanguage:(NSString *)defaultLanguage {
    _defaultLanguage = defaultLanguage;
    [self.user setObject:defaultLanguage forKey:@"defaultLanguage"];
}

- (void)setCountry:(NSDictionary *)country {
    _country = country;
    [self.user setObject:country forKey:@"country"];
}

- (void)setCity:(NSString *)city {
    _city = city;
    [self.user setObject:city forKey:@"city"];
}

- (void)setInterests:(NSString *)interests {
    _interests = interests;
    [self.user setObject:interests forKey:@"interests"];
}

- (void)setProfession:(NSString *)profession {
    _profession = profession;
    [self.user setObject:profession forKey:@"profession"];
}

- (void)setAboutMe:(NSString *)aboutMe {
    _aboutMe = aboutMe;
    [self.user setObject:aboutMe forKey:@"aboutMe"];
}

- (void)setUserPhoto:(UIImage *)userPhoto {
    _userPhoto = userPhoto;
    [self.user setObject:[self saveImage:userPhoto withName:@"avatar"] forKey:@"avatar"];
}

@end
