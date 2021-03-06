//
//  TIMModelWithStaticData.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMModelWithStaticData.h"

@implementation TIMModelWithStaticData

- (NSArray*)countryList{
    return @[
             @{@"id" : @"Австралия", @"title" : @"Австралия"},
             @{@"id" : @"Австрия", @"title" : @"Австрия"},
             @{@"id" : @"Азербайджан", @"title" : @"Азербайджан"},
             @{@"id" : @"Албания", @"title" : @"Албания"},
             @{@"id" : @"Алжир", @"title" : @"Алжир"},
             @{@"id" : @"Ангола", @"title" : @"Ангола"},
             @{@"id" : @"Андорра", @"title" : @"Андорра"},
             @{@"id" : @"Антигуа и Барбуда", @"title" : @"Антигуа и Барбуда"},
             @{@"id" : @"Аргентина", @"title" : @"Аргентина"},
             @{@"id" : @"Армения", @"title" : @"Армения"},
             @{@"id" : @"Афганистан", @"title" : @"Афганистан"},
             @{@"id" : @"Багамские Острова", @"title" : @"Багамские Острова"},
             @{@"id" : @"Бангладеш", @"title" : @"Бангладеш"},
             @{@"id" : @"Барбадос", @"title" : @"Барбадос"},
             @{@"id" : @"Бахрейн", @"title" : @"Бахрейн"},
             @{@"id" : @"by", @"title" : @"Беларусь"},
             @{@"id" : @"Белиз", @"title" : @"Белиз"},
             @{@"id" : @"Бельгия", @"title" : @"Бельгия"},
             @{@"id" : @"Бенин", @"title" : @"Бенин"},
             @{@"id" : @"Болгария", @"title" : @"Болгария"},
             @{@"id" : @"Боливия", @"title" : @"Боливия"},
             @{@"id" : @"Босния и Герцеговина", @"title" : @"Босния и Герцеговина"},
             @{@"id" : @"Ботсвана", @"title" : @"Ботсвана"},
             @{@"id" : @"Бразилия", @"title" : @"Бразилия"},
             @{@"id" : @"Бруней", @"title" : @"Бруней"},
             @{@"id" : @"Буркина-Фасо", @"title" : @"Буркина-Фасо"},
             @{@"id" : @"Бурунди", @"title" : @"Бурунди"},
             @{@"id" : @"Бутан", @"title" : @"Бутан"},
             @{@"id" : @"Вануату", @"title" : @"Вануату"},
             @{@"id" : @"Ватикан", @"title" : @"Ватикан"},
             @{@"id" : @"Великобритания", @"title" : @"Великобритания"},
             @{@"id" : @"Венгрия", @"title" : @"Венгрия"},
             @{@"id" : @"Венесуэла", @"title" : @"Венесуэла"},
             @{@"id" : @"Восточный Тимор", @"title" : @"Восточный Тимор"},
             @{@"id" : @"Вьетнам", @"title" : @"Вьетнам"},
             @{@"id" : @"Габон", @"title" : @"Габон"},
             @{@"id" : @"Гаити", @"title" : @"Гаити"},
             @{@"id" : @"Гайана", @"title" : @"Гайана"},
             @{@"id" : @"Гамбия", @"title" : @"Гамбия"},
             @{@"id" : @"Гана", @"title" : @"Гана"},
             @{@"id" : @"Гватемала", @"title" : @"Гватемала"},
             @{@"id" : @"Гвинея", @"title" : @"Гвинея"},
             @{@"id" : @"Гвинея-Бисау", @"title" : @"Гвинея-Бисау"},
             @{@"id" : @"Германия", @"title" : @"Германия"},
             @{@"id" : @"Гондурас", @"title" : @"Гондурас"},
             @{@"id" : @"Гренада", @"title" : @"Гренада"},
             @{@"id" : @"Греция", @"title" : @"Греция"},
             @{@"id" : @"Грузия", @"title" : @"Грузия"},
             @{@"id" : @"Дания", @"title" : @"Дания"},
             @{@"id" : @"Джибути", @"title" : @"Джибути"},
             @{@"id" : @"Доминика", @"title" : @"Доминика"},
             @{@"id" : @"Доминиканская Республика", @"title" : @"Доминиканская Республика"},
             @{@"id" : @"Египет", @"title" : @"Египет"},
             @{@"id" : @"Замбия", @"title" : @"Замбия"},
             @{@"id" : @"Зимбабве", @"title" : @"Зимбабве"},
             @{@"id" : @"Израиль", @"title" : @"Израиль"},
             @{@"id" : @"Индия", @"title" : @"Индия"},
             @{@"id" : @"Индонезия", @"title" : @"Индонезия"},
             @{@"id" : @"Иордания", @"title" : @"Иордания"},
             @{@"id" : @"Ирак", @"title" : @"Ирак"},
             @{@"id" : @"Иран", @"title" : @"Иран"},
             @{@"id" : @"Ирландия", @"title" : @"Ирландия"},
             @{@"id" : @"Исландия", @"title" : @"Исландия"},
             @{@"id" : @"Испания", @"title" : @"Испания"},
             @{@"id" : @"Италия", @"title" : @"Италия"},
             @{@"id" : @"Йемен", @"title" : @"Йемен"},
             @{@"id" : @"Кабо-Верде", @"title" : @"Кабо-Верде"},
             @{@"id" : @"Казахстан", @"title" : @"Казахстан"},
             @{@"id" : @"Камбоджа", @"title" : @"Камбоджа"},
             @{@"id" : @"Камерун", @"title" : @"Камерун"},
             @{@"id" : @"Канада", @"title" : @"Канада"},
             @{@"id" : @"Катар", @"title" : @"Катар"},
             @{@"id" : @"Кения", @"title" : @"Кения"},
             @{@"id" : @"Кипр", @"title" : @"Кипр"},
             @{@"id" : @"Киргизия", @"title" : @"Киргизия"},
             @{@"id" : @"Кирибати", @"title" : @"Кирибати"},
             @{@"id" : @"Китай", @"title" : @"Китай"},
             @{@"id" : @"Колумбия", @"title" : @"Колумбия"},
             @{@"id" : @"Коморские Острова", @"title" : @"Коморские Острова"},
             @{@"id" : @"Конго", @"title" : @"Конго"},
             @{@"id" : @"Демократическая Республика Конго", @"title" : @"Демократическая Республика Конго"},
             @{@"id" : @"КНДР", @"title" : @"КНДР"},
             @{@"id" : @"Южная Корея", @"title" : @"Южная Корея"},
             @{@"id" : @"Коста-Рика", @"title" : @"Коста-Рика"},
             @{@"id" : @"Кот-д’Ивуар", @"title" : @"Кот-д’Ивуар"},
             @{@"id" : @"Куба", @"title" : @"Куба"},
             @{@"id" : @"Кувейт", @"title" : @"Кувейт"},
             @{@"id" : @"Лаос", @"title" : @"Лаос"},
             @{@"id" : @"Латвия", @"title" : @"Латвия"},
             @{@"id" : @"Лесото", @"title" : @"Лесото"},
             @{@"id" : @"Либерия", @"title" : @"Либерия"},
             @{@"id" : @"Ливан", @"title" : @"Ливан"},
             @{@"id" : @"Ливия", @"title" : @"Ливия"},
             @{@"id" : @"Литва", @"title" : @"Литва"},
             @{@"id" : @"Лихтенштейн", @"title" : @"Лихтенштейн"},
             @{@"id" : @"Люксембург", @"title" : @"Люксембург"},
             @{@"id" : @"Маврикий", @"title" : @"Маврикий"},
             @{@"id" : @"Мавритания", @"title" : @"Мавритания"},
             @{@"id" : @"Мадагаскар", @"title" : @"Мадагаскар"},
             @{@"id" : @"Македония", @"title" : @"Македония"},
             @{@"id" : @"Малави", @"title" : @"Малави"},
             @{@"id" : @"Малайзия", @"title" : @"Малайзия"},
             @{@"id" : @"Мали", @"title" : @"Мали"},
             @{@"id" : @"Мальдивы", @"title" : @"Мальдивы"},
             @{@"id" : @"Мальта", @"title" : @"Мальта"},
             @{@"id" : @"Марокко", @"title" : @"Марокко"},
             @{@"id" : @"Маршалловы острова", @"title" : @"Маршалловы острова"},
             @{@"id" : @"Мексика", @"title" : @"Мексика"},
             @{@"id" : @"Мозамбик", @"title" : @"Мозамбик"},
             @{@"id" : @"Молдавия", @"title" : @"Молдавия"},
             @{@"id" : @"Монако", @"title" : @"Монако"},
             @{@"id" : @"Монголия", @"title" : @"Монголия"},
             @{@"id" : @"Мьянма", @"title" : @"Мьянма"},
             @{@"id" : @"Намибия", @"title" : @"Намибия"},
             @{@"id" : @"Науру", @"title" : @"Науру"},
             @{@"id" : @"Непал", @"title" : @"Непал"},
             @{@"id" : @"Нигер", @"title" : @"Нигер"},
             @{@"id" : @"Нигерия", @"title" : @"Нигерия"},
             @{@"id" : @"Нидерланды", @"title" : @"Нидерланды"},
             @{@"id" : @"Никарагуа", @"title" : @"Никарагуа"},
             @{@"id" : @"Новая Зеландия", @"title" : @"Новая Зеландия"},
             @{@"id" : @"Норвегия", @"title" : @"Норвегия"},
             @{@"id" : @"ОАЭ", @"title" : @"ОАЭ"},
             @{@"id" : @"Оман", @"title" : @"Оман"},
             @{@"id" : @"Пакистан", @"title" : @"Пакистан"},
             @{@"id" : @"Палау", @"title" : @"Палау"},
             @{@"id" : @"Государство Палестина", @"title" : @"Государство Палестина"},
             @{@"id" : @"Панама", @"title" : @"Панама"},
             @{@"id" : @"Папуа — Новая Гвинея", @"title" : @"Папуа — Новая Гвинея"},
             @{@"id" : @"Парагвай", @"title" : @"Парагвай"},
             @{@"id" : @"Перу", @"title" : @"Перу"},
             @{@"id" : @"Польша", @"title" : @"Польша"},
             @{@"id" : @"Португалия", @"title" : @"Португалия"},
             @{@"id" : @"ru", @"title" : @"Россия"},
             @{@"id" : @"Руанда", @"title" : @"Руанда"},
             @{@"id" : @"Румыния", @"title" : @"Румыния"},
             @{@"id" : @"Сальвадор", @"title" : @"Сальвадор"},
             @{@"id" : @"Самоа", @"title" : @"Самоа"},
             @{@"id" : @"Сан-Марино", @"title" : @"Сан-Марино"},
             @{@"id" : @"Сан-Томе и Принсипи", @"title" : @"Сан-Томе и Принсипи"},
             @{@"id" : @"Саудовская Аравия", @"title" : @"Саудовская Аравия"},
             @{@"id" : @"Свазиленд", @"title" : @"Свазиленд"},
             @{@"id" : @"Сейшелы", @"title" : @"Сейшелы"},
             @{@"id" : @"Сенегал", @"title" : @"Сенегал"},
             @{@"id" : @"Сент-Винсент и Гренадины", @"title" : @"Сент-Винсент и Гренадины"},
             @{@"id" : @"Сент-Китс и Невис", @"title" : @"Сент-Китс и Невис"},
             @{@"id" : @"Сент-Люсия", @"title" : @"Сент-Люсия"},
             @{@"id" : @"Сербия", @"title" : @"Сербия"},
             @{@"id" : @"Сингапур", @"title" : @"Сингапур"},
             @{@"id" : @"Сирия", @"title" : @"Сирия"},
             @{@"id" : @"Словакия", @"title" : @"Словакия"},
             @{@"id" : @"Словения", @"title" : @"Словения"},
             @{@"id" : @"США", @"title" : @"США"},
             @{@"id" : @"Соломоновы острова", @"title" : @"Соломоновы острова"},
             @{@"id" : @"Сомали", @"title" : @"Сомали"},
             @{@"id" : @"Судан", @"title" : @"Судан"},
             @{@"id" : @"Суринам", @"title" : @"Суринам"},
             @{@"id" : @"Сьерра-Леоне", @"title" : @"Сьерра-Леоне"},
             @{@"id" : @"Таджикистан", @"title" : @"Таджикистан"},
             @{@"id" : @"Таиланд", @"title" : @"Таиланд"},
             @{@"id" : @"Танзания", @"title" : @"Танзания"},
             @{@"id" : @"Того", @"title" : @"Того"},
             @{@"id" : @"Тонга", @"title" : @"Тонга"},
             @{@"id" : @"Тринидад и Тобаго", @"title" : @"Тринидад и Тобаго"},
             @{@"id" : @"Тувалу", @"title" : @"Тувалу"},
             @{@"id" : @"Тунис", @"title" : @"Тунис"},
             @{@"id" : @"Туркмения", @"title" : @"Туркмения"},
             @{@"id" : @"Турция", @"title" : @"Турция"},
             @{@"id" : @"Уганда", @"title" : @"Уганда"},
             @{@"id" : @"Узбекистан", @"title" : @"Узбекистан"},
             @{@"id" : @"ua", @"title" : @"Украина"},
             @{@"id" : @"Уругвай", @"title" : @"Уругвай"},
             @{@"id" : @"Федеративные Штаты Микронезии", @"title" : @"Федеративные Штаты Микронезии"},
             @{@"id" : @"Фиджи", @"title" : @"Фиджи"},
             @{@"id" : @"Филиппины", @"title" : @"Филиппины"},
             @{@"id" : @"Финляндия", @"title" : @"Финляндия"},
             @{@"id" : @"Франция", @"title" : @"Франция"},
             @{@"id" : @"Хорватия", @"title" : @"Хорватия"},
             @{@"id" : @"Центральноафриканская Республика", @"title" : @"Центральноафриканская Республика"},
             @{@"id" : @"Чад", @"title" : @"Чад"},
             @{@"id" : @"Черногория", @"title" : @"Черногория"},
             @{@"id" : @"Чехия", @"title" : @"Чехия"},
             @{@"id" : @"Чили", @"title" : @"Чили"},
             @{@"id" : @"Швейцария", @"title" : @"Швейцария"},
             @{@"id" : @"Швеция", @"title" : @"Швеция"},
             @{@"id" : @"Шри-Ланка", @"title" : @"Шри-Ланка"},
             @{@"id" : @"Эквадор", @"title" : @"Эквадор"},
             @{@"id" : @"Экваториальная Гвинея", @"title" : @"Экваториальная Гвинея"},
             @{@"id" : @"Эритрея", @"title" : @"Эритрея"},
             @{@"id" : @"Эстония", @"title" : @"Эстония"},
             @{@"id" : @"Эфиопия", @"title" : @"Эфиопия"},
             @{@"id" : @"ЮАР", @"title" : @"ЮАР"},
             @{@"id" : @"Южный Судан", @"title" : @"Южный Судан"},
             @{@"id" : @"Ямайка", @"title" : @"Ямайка"},
             @{@"id" : @"Япония", @"title" : @"Япония"}
             ];
}


- (NSArray *)privacyArray {
    return @[@"все", @"только я", @"только друзья"];
}

- (NSArray *)languageArray {
    return @[@"English", @"Русский"];
}

- (NSArray *)genderArray {
    return @[@"Мужской", @"Женский"];
}

- (NSArray *)notificationsArray {
    return @[@"Выключены", @"Ежедневно", @"Сразу"];
}

- (NSArray *)searchArray {
    return @[@"По карте", @"По имени"];
}

- (NSArray *)synchronizeArray {
    return @[@"По требованию", @"В режиме онлайн"];
}

- (NSString *)formatInterestsString:(NSInteger)count {
    NSString *countString = [NSString stringWithFormat:@"%ld", (long)count];
    NSString *lastChar = [countString substringFromIndex:[countString length] - 1];
    if ([lastChar isEqualToString:@"1"]) {
        return [NSString stringWithFormat:@"%ld интерес",count];
    } else if (([lastChar isEqualToString:@"2"]) || ([lastChar isEqualToString:@"3"]) || ([lastChar isEqualToString:@"4"])) {
        return [NSString stringWithFormat:@"%ld интереса",count];
    } else {
        return [NSString stringWithFormat:@"%ld интересов",count];
    }
}

- (NSDictionary*)formatInterestsDictionaryFromString:(NSString*)interests{
    NSMutableDictionary* interestsDictionary = [[NSMutableDictionary alloc] init];
    if (interests || interests.length > 0) {
        NSArray* interestsArray = [interests componentsSeparatedByString:@"|"];
        [interestsDictionary setObject:interestsArray forKey:@"array"];
        NSString* interestsLabelString;
        if (interestsArray.count == 1 && [[interestsArray lastObject] isEqualToString:@""]) {
            interestsLabelString = @"";
        } else {
            interestsLabelString = [self formatInterestsString:interestsArray.count];
        }
        [interestsDictionary setObject:interestsLabelString forKey:@"string"];
    }
    return interestsDictionary;
}

- (NSMutableDictionary*)getCounryDictWithCountryName:(NSString*)name{
    NSPredicate* countryPredicate = [NSPredicate predicateWithFormat:@"title = %@", name];
    NSArray* countryArray = [[self countryList]
                             filteredArrayUsingPredicate:countryPredicate];
    NSMutableDictionary* countyDictionary = [[countryArray lastObject] mutableCopy];
    return countyDictionary;
}

@end
