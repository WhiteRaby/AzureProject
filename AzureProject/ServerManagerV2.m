//
//  ServerManagerV2.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "ServerManagerV2.h"
#import "User+CoreDataClass.h"
#import "Bank+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import "Account+CoreDataClass.h"
#import "AppDelegate.h"

@interface ServerManagerV2 ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation ServerManagerV2

+ (ServerManagerV2*)sharedInstance {
    
    static ServerManagerV2 *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManagerV2 alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
        [self startData];
        
    }
    return self;
}

- (NSManagedObject*)createEntityWithEntityName:(NSString*)name {
    
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[self context]];
    return object;
}

- (void)save {
 
    NSError *error = nil;
    if ([[self context] save:&error] == NO) {
        //NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (void)getUsersWithCompletion:(CompletionBlock)completion {
    NSError *error = nil;

    NSArray *users = [self.context executeFetchRequest:[User fetchRequest] error:&error];
    NSLog(@"%@",error);
    completion(YES, users);
    
}

- (void)getUserWithLogin:(NSString*)login andPassword:(NSString*)password completion:(CompletionBlock)completion {

    NSFetchRequest *request = [User fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"login == %@ AND password == %@", login, password]];
    
    NSArray *users = [self.context executeFetchRequest:request error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([users count]) {
            completion(YES, [users firstObject]);
        } else {
            completion(NO, users);
        }
    });

}

- (void)getBanksCompletion:(CompletionBlock)completion {
    
    NSArray *banks = [self.context executeFetchRequest:[Bank fetchRequest] error:nil];
    
    banks = [banks sortedArrayUsingComparator:^NSComparisonResult(Bank *obj1, Bank *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(YES, banks);
    });
}

- (void)getOffersCompletion:(CompletionBlock)completion {
    
    NSArray *offers = [self.context executeFetchRequest:[Offer fetchRequest] error:nil];
    
    offers = [offers sortedArrayUsingComparator:^NSComparisonResult(Offer *obj1, Offer *obj2) {
        return [obj1.bank.name compare:obj2.bank.name];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(YES, offers);
    });

}

- (void)getAccountsWithUserLogin:(NSString*)login completion:(CompletionBlock)completion {
    
    
    NSFetchRequest *request = [Account fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"userLogin == %@", login]];
    
    NSArray *accounts = [self.context executeFetchRequest:request error:nil];
    
    accounts = [accounts sortedArrayUsingComparator:^NSComparisonResult(Account *obj1, Account *obj2) {
        return [obj1.startDate compare:obj2.startDate];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([accounts count]) {
            completion(YES, accounts);
        } else {
            completion(NO, accounts);
        }
    });
}

- (void)startData {

    if ([[self.context executeFetchRequest:[Bank fetchRequest] error:nil] count] != 0) {
        return;
    }

    
    
    // ТУТ ТЕБЕ НАДО ДОБАВИТЬ ДАННЫЕ
    
    
    Bank *bank1 = [Bank create];
    bank1.name = @"Беларусь банк";
    bank1.info = @"ОАО «АСБ Беларусбанк» в течение многих лет является неотъемлемой частью банковской системы страны, важнейшей составляющей ее стабильности. Банк объединяет в себе огромный профессиональный опыт и богатые традиции, имеет репутацию надежного партнера. Беларусбанк был и остается надежной опорой белорусской экономики. Как крупнейшее кредитно-финансовое учреждение республики активно участвует в реализации государственных программ, инвестиционных проектов, осуществляет кредитование важнейших отраслей промышленного и сельскохозяйственного производства, социальной сферы. Приоритетным направлением деятельности банка остается обслуживание населения. Практически каждая белорусская семья пользуется услугами банка. Миллионы людей доверяют ему свои сбережения. Бесспорным преимуществом остаются широкая филиальная сеть и доступность банковских услуг.\nТелефон: 147, +375 17 218 84 31\nФакс: +375 17 226 47 50\nпр-т Дзержинского, 18, 220089, г.Минск";
    
    Bank *bank2 = [Bank create];
    bank2.name = @"Альфа банк";
    bank2.info = @"Входит в «Альфа-Групп» ЗАО «Альфа-Банк» (Беларусь) создан на основе консолидации активов двух белорусских банков и входит в структуру Консорциума «Альфа-Групп» - одного из крупнейших частных финансово-промышленных консорциумов в России на территории СНГ. Консорциуму «Альфа-Групп» принадлежит 99,88% акций ЗАО «Альфа-Банк Альфа-Банк (Беларусь) является универсальным банком и по величине активов, кредитного портфеля, средств клиентов, нормативного капитала входит в первую «десятку» крупнейших белорусских банков. Уставный фонд Банка составляет 56 648 830,95 BYN.\nТелефон: +375 (44, 29, 25)733-33-32\nул. Мясникова, 70";
    
    
    Bank *bank3 = [Bank create];
    bank3.name = @"Идея банк";
    bank3.info = @"ЗАО «Идея Банк» является одним из ведущих белорусских банков, работающих на рынке с 2004 года. Идея Банк входит в состав крупного восточноевропейского финансового холдинга Getin Holding, имеющего богатый опыт работы на рынке банковских и страховых услуг, финансового консалтинга. Под брендом «Idea Bank» работают банки в Польше, Украине, России и Беларуси.За 10-летний опыт существования банка была выстроена эффективная система его функционирования, также определены фирменные черты предлагаемых продуктов: оптимальные тарифы, высокое качество, скорость обслуживания, точное соответствие заявленным условиям и индивидуальный подход к каждому клиенту.\nул. З. Бядули, 11\nТелефон: (+375-29) 699-11-80 \n(+375-17) 229-96-42 \n(+375-17) 229-96-45";
    
    Bank *bank4 = [Bank create];
    bank4.name = @"Белагропромбанк";
    bank4.info = @"Юридический адрес:\nпр-т. Жукова 3, г. Минск, 220036\nБИК 153001964\nS.W.I.F.T. BAPBBY2X\nУНП 100693551\nGIIN-номер по FATCA: XBRR38.99999.SL.112\nКорреспондентский счет в Национальном банке Республики Беларусь:\n№ 3200009640011, код 042\nТелефон/факс: +375 (17) 218 57 14\nТелекс: 25 21 13\nТелефон Контакт-центра:136; \n+375 (17) 218 57 77 ; \n+375(29) 198 57 77 (velcom); \n+375(29) 888 57 77 (МТС); \n+375(25) 999 57 77 (Life :);\nВремя работы Контакт-центра:\nрабочие дни - 8.00-20.00;\nвыходные и праздничные дни - 8.00-18.00";
    
    Bank *bank5 = [Bank create];
    bank5.name = @"БелВЭБ банк";
    bank5.info = @"Открытое акционерное общество «Белвнешэкономбанк» (ОАО 'Банк БелВЭБ')- универсальный кредитно-финансовый институт, занимающий ведущие позиции среди коммерческих банков Республики Беларусь в области международных расчетов, валютных операций и обслуживании внешнеэкономической деятельности государства и клиентов, имеющий многолетний опыт работы и признанную репутацию на зарубежном и внутреннем валютных рынках.Открытое акционерное общество «Белвнешэкономбанк» зарегистрировано Национальным банком Республики Беларусь 12 декабря 1991 г., регистрационный номер 24.Регистрационный номер в Едином государственном регистре юридических лиц и индивидуальных предпринимателей — 100010078. Местонахождение — г. Минск, пр-т Победителей, 29\nтел. (+375 17) 215 61 15.";
    
    Bank *bank6 = [Bank create];
    bank6.name = @"БНБ-банк";
    bank6.info = @"Мы предоставляем нашим клиентам полный спектр финансовых услуг.\nЮридическим лицам мы предлагаем: услуги по расчетно-кассовому обслуживанию, кредитование, депозиты, операции с банковскими карточками, операции с документарными аккредитивами и т.д.\nЧастные лица смогут получить у нас весь комплекс услуг по текущим счетам, денежным переводам, вкладам, кредитам, банковским пластиковым карточкам, интернет-банкингу и т.д.\nТелефон: +375 17 309 7 309.";
    
    Bank *bank7 = [Bank create];
    bank7.name = @"Москва-Минск банк";
    bank7.info = @"Открытое акционерное общество «Банк Москва-Минск» осуществляет свою деятельность как правопреемник Унитарного предприятия «Иностранный банк «Москва-Минск», зарегистрированного постановлением Правления Национального банка Республики Беларусь от 7 апреля 2000г. №9.2 в Едином государственном регистре юридических лиц и индивидуальных предпринимателей за № 807000002.\nТелефон: +375 (17) 237 97 97,186";
    
    Bank *bank8 = [Bank create];
    bank8.name = @"РРБ банк";
    bank8.info = @"РРБ-Банк – современный европейский банк, приоритетная задача которого удовлетворять потребности экономически активной части населения и бизнеса в банковских услугах и сервисах, способствуя воплощению в жизнь устремлений клиентов и повышению их финансового комфорта.\nНаши ценности:\nПрофессионализм. Наши клиенты могут рассчитывать на высокое качество банковских услуг, предоставляемых командой профессионалов.\nНадежность. Мы постоянно контролируем внутренние и внешние экономические риски, гарантируя надежность нашим клиентам.\nОткрытость. Наши клиенты могут нам доверять. Мы прозрачны, понятны, открыты для конструктивного сотрудничества и приветствуем инновации.\nОбслуживание клиентов. Мы заботимся и уважаем наших клиентов, помогая им воплотить свои устремления и мечты.\nТелефон: +375 (17) 30602-02,226 - Velcom, MTC, Life";
    
    Bank *bank9 = [Bank create];
    bank9.name = @"БПС-Сбербанк";
    bank9.info = @"220005, г. Минск, бульвар имени Мулявина, 6\nРежим работы контакт-центра:\nКруглосуточно\nТелефон*\nв стационарной и мобильных сетях\n148\n5-148-148\nТелефон\nдля международных звонков\n+375 (29) 5-148-148\nФакс	+375(17) 210-03-42\nТелекс	252410AVAL BY\nВеб-сайт	www.bps-sberbank.by\nE-mail	inbox@bps-sberbank.by\nРеквизиты\nПолное наименование\nОткрытое акционерное общество «БПС-Сбербанк»\nСокращенное наименование\nОАО «БПС-Сбербанк»\nБИК	153001369\nS.W.I.F.T.	BPSBBY2X\nОКПО	00040583\nУНП	100219673\nОКОНХ	96120";
    
    Bank *bank10 = [Bank create];
    bank10.name = @"Белинвестбанк";
    bank10.info = @"Основой создания открытого акционерного общества «Белорусский банк развития и реконструкции «Белинвестбанк» стало образование 15 апреля 1992 года Белорусского акционерного коммерческого банка реконструкции и развития «Белбизнесбанк» путем слияния 4-х коммерческих банков «Минскбизнесбанк», «Жилкомбанк», «Могобанк» и «Гроднокомбанк».\n19 июля 2001 года состоялось совместное Собрание акционеров ОАО «Белбизнесбанк» и ОАО «Белорусский банк развития», на котором было принято решение об утверждении договора о слиянии двух банков. Собрание акционеров определило название банка как открытое акционерное общество «Белорусский банк развития и реконструкции «Белинвестбанк», утвердило Устав, избрало членов и председателей Наблюдательного совета и Ревизионной комиссии. 3 сентября 2001 года Национальный банк Республики Беларусь зарегистрировал Устав нового банка, который стал правопреемником прав и обязанностей ОАО «Белбизнесбанк» и ОАО «Белорусский банк развития» и продолжил свою деятельность под брендом ОАО «Белинвестбанк».\nОАО «Белинвестбанк» – один из крупнейших универсальных банков Республики Беларусь, доля государственной формы собственности в уставном фонде которого составляет 99,08%. Банк ориентирован на обслуживание физических и юридических лиц различных форм собственности и направлений деятельности, осуществляет все виды банковских операций и оказывает услуги в соответствии с законодательством Республики Беларусь.\nОАО «Белинвестбанк» широко представлен во всех регионах страны благодаря развитой региональной сети, которая включает 150 точек продаж. Банк обслуживает более 30 000 юридических лиц и индивидуальных предпринимателей и около 1 000 000 частных клиентов.\nОАО «Белинвестбанк» обслуживает кредитные линии иностранных инвесторов, ведет активную работу по развитию сотрудничества с крупными предприятиями и предприятиями малого и среднего бизнеса.\nСодействуя реализации внешнеторговых проектов своих клиентов, банк активно сотрудничает с рядом иностранных экспортных кредитных агентств, имеет обширные корреспондентские связи с крупнейшими зарубежными финансовыми институтами, осуществляет все формы международных расчетов, принятых в мировой практике, и обеспечивает расчетное обслуживание внешнеторговых операций клиентов по всей территории СНГ, Европы и США.\nВ мае 2015 года подписан Меморандум о взаимопонимании между правительством Республики Беларусь и ЕБРР в отношении приватизации ОАО «Белинвестбанк». ОАО «Белинвестбанк» осуществляется кредитование малого и среднего бизнеса, в том числе в рамках заключенных соглашений с ЕБРР, ОАО «Банк развития Республики Беларусь».\nЕжегодно на протяжении 18 лет проводится аудит финансовой отчетности банка по международным стандартам финансовой отчетности. С 2006 года оценку деятельности банка проводит одно из ведущих международных рейтинговых агентств «Fitch Ratings».\nОказание информационной помощи физическим лицам по тел.: \n146, (017) 239-02-39";
    
    Bank *bank11 = [Bank create];
    bank11.name = @"БТА банк";
    bank11.info = @"Белорусский БТА Банк сегодня – динамично развивающийся банк для бизнеса.\nБТА Банк успешно работает на рынке Республики Беларусь и представлен развитой региональной сетью, которая включает Головной офис в Минске, 4 региональных центра банковских услуг в Бресте, Могилеве, Витебске, Гомеле и два  дополнительных офиса в  столице, 4 пункта обмена валют, 20 банкоматов.\nБТА Банк предлагает широкий комплекс банковских услуг для бизнеса и частных лиц.\nОсновной фокус в развитии бизнеса и позиционирования банка направлен на сегмент малого и среднего бизнеса, работы с частными клиентами, а также экспортно-импортных операций между Республикой Беларусь и Республикой Казахстан.\nСогласно данной Стратегии основными приоритетами белорусского БТА Банка являются: динамичный рост клиентской базы, активное развитие региональной сети, рост объемов кредитования и ресурсной базы, чистых активов банка за счет увеличения прибыли и Уставного фонда. Помимо этого, значительное внимание будет уделяться усилению риск-менеджмента, корпоративного управления и внутреннего контроля в банке, внедрение прогрессивных банковских IT технологий в бизнес-процессах и предоставлении услуг через Интернет.\nВидение БТА Банка на ближайшие 5 лет -  стать лучшим банком для малого и среднего бизнеса в Беларуси с сильной клиентской базой и эффективной сетью продаж, подняться в рейтинге банков по размеру активов и кредитного портфеля как минимум на 10 позиций выше текущего, обеспечить обслуживание международных платежей в размере 50% от всей суммы товарооборота между Беларусью и Казахстаном, а также соответствовать международным стандартам эффективности ведения бизнеса и корпоративного управления.\nМиссия БТА Банка - содействовать экономическому росту Республики Беларусь, росту благосостояния населения и принимать активное участие в развитии торгово-экономических отношений между Республикой Беларусь и Республикой Казахстан, а так же другими странами СНГ.\nТелефон: +375(17) 334 54 32";
    
    Bank *bank12 = [Bank create];
    bank12.name = @"Паритетбанк";
    bank12.info = @"Юридический статус – Открытое акционерное общество.\nПолное и сокращенное наименование на русском, белорусском и английском языках:\nОткрытое акционерное общество «Паритетбанк» (ОАО «Паритетбанк»);\nАдкрытае акцыянернае таварыства «Парытэтбанк» (ААТ «Парытэтбанк»);\nOpen joint-stock company «Paritetbank» (OJSC «Paritetbank»)\nДата регистрации – 15 мая 1991 года Национальным банком Республики Беларусь зарегистрирован коммерческий банк «Поиск». 5 мая 2004 года банк «Поиск» был переименован в ОАО «Паритетбанк».\nРеквизиты банка:\nЮридический адрес: 220002, г. Минск, ул. Киселева, 61а\nТелефон: 171\nS.W.I.F.T. – POISBY2X\nЭлектронная почта: info@paritetbank.by\nУчетный номер плательщика (УНП) – 100233809\nКорреспондентский счет в Национальном банке Республики Беларусь – 3200007820019\nРегистрационный номер в Едином государственном регистре юридических лиц и индивидуальных предпринимателей – 100233809";
    
    
    
    
    
    Offer *offer1 = [Offer create];
    offer1.name = @"Альфа-Весна";
    offer1.currency = @"BYN";
    offer1.interestRate = 12;
    offer1.startFunds = 50;
    offer1.capitalize = @"Monthly";
    offer1.period = @"3 Month"; // Сука разберись что это значит
    
    Offer *offer2 = [Offer create];
    offer2.name = @"Интернет-депозит";
    offer2.currency = @"ALL";
    offer2.interestRate = 17.1;
    offer2.startFunds = 100;
    offer2.capitalize = @"Monthly";
    offer2.period = @"6Month";
    
    Offer *offer3 = [Offer create];
    offer3.name = @"Особенный 24 плюс";
    offer3.currency = @"BYN";
    offer3.interestRate = 17.5;
    offer3.startFunds = 20;
    offer3.capitalize = @"Monthly";
    offer3.period = @"6 Month";
    
    Offer *offer4= [Offer create];
    offer4.name = @"Многоумножаемые вклады";
    offer4.currency = @"BYN";
    offer4.interestRate = 16;
    offer4.startFunds = 20;
    offer4.capitalize = @"Monthly";
    offer4.period = @">2 Months";
    
    Offer *offer5 = [Offer create];
    offer5.name = @"25 лет вместе";
    offer5.currency = @"ALL";
    offer5.interestRate = 16;
    offer5.startFunds = 100;
    offer5.capitalize = @"Monthly";
    offer5.period = @">3 Months";
    
    Offer *offer6 = [Offer create];
    offer6.name = @"Выдатны";
    offer6.currency = @"ALL";
    offer6.interestRate = 15;
    offer6.startFunds = 100;
    offer6.capitalize = @"Monthly";
    offer6.period = @"6 Months";
    
    Offer *offer7 = [Offer create];
    offer7.name = @"Пенсионно-накопительный";
    offer7.currency = @"ALL";
    offer7.interestRate = 15;
    offer7.startFunds = 100;
    offer7.capitalize = @"Monthly";
    offer7.period = @">1 Month";
    
    Offer *offer8 = [Offer create];
    offer8.name = @"Особенный 9 плюс";
    offer8.currency = @"BYN";
    offer8.interestRate = 15;
    offer8.startFunds = 20;
    offer8.capitalize = @"Monthly";
    offer8.period = @"6 Months";
    
    Offer *offer9 = [Offer create];
    offer9.name = @"Верное решение";
    offer9.currency = @"ALL";
    offer9.interestRate = 14.2;
    offer9.startFunds = 100;
    offer9.capitalize = @"Monthly";
    offer9.period = @"6 Months";
    
    Offer *offer10 = [Offer create];
    offer10.name = @"Интрнет депозит Тренд";
    offer10.currency = @"ALL";
    offer10.interestRate = 14;
    offer10.startFunds = 100;
    offer10.capitalize = @"Monthly";
    offer10.period = @"6 Months";
    
    Offer *offer11 = [Offer create];
    offer11.name = @"Оптимальный";
    offer11.currency = @"ALL";
    offer11.interestRate = 14;
    offer11.startFunds = 50;
    offer11.capitalize = @"Monthly";
    offer11.period = @">3 Months";
    
    Offer *offer12 = [Offer create];
    offer12.name = @"Выдатны-вэб";
    offer12.currency = @"ALL";
    offer12.interestRate = 14;
    offer12.startFunds = 50;
    offer12.capitalize = @"Monthly";
    offer12.period = @"6 Months";
    
    Offer *offer13 = [Offer create];
    offer13.name = @"Особенный 6 плюс";
    offer13.currency = @"BYN";
    offer13.interestRate = 14;
    offer13.startFunds = 20;
    offer13.capitalize = @"Monthly";
    offer13.period = @"6 Months";
    
    Offer *offer14 = [Offer create];
    offer14.name = @"Универсальный";
    offer14.currency = @"ALL";
    offer14.interestRate = 14;
    offer14.startFunds = 100;
    offer14.capitalize = @"Monthly";
    offer14.period = @"6 Months";
    
    Offer *offer15 = [Offer create];
    offer15.name = @"Комфорт 6 плюс";
    offer15.currency = @"BYN";
    offer15.interestRate = 13.5;
    offer15.startFunds = 20;
    offer15.capitalize = @"Monthly";
    offer15.period = @"6 Months";
    
    Offer *offer16 = [Offer create];
    offer16.name = @"Альфа Прайм";
    offer16.currency = @"ALL";
    offer16.interestRate = 13;
    offer16.startFunds = 100;
    offer16.capitalize = @"Monthly";
    offer16.period = @"6 Months";
    
    Offer *offer17 = [Offer create];
    offer17.name = @"Прогрессивный";
    offer17.currency = @"ALL";
    offer17.interestRate = 13;
    offer17.startFunds = 50;
    offer17.capitalize = @"Monthly";
    offer17.period = @"6 Months";
    
    Offer *offer18 = [Offer create];
    offer18.name = @"Весомый";
    offer18.currency = @"ALL";
    offer18.interestRate = 12.5;
    offer18.startFunds = 5;
    offer18.capitalize = @"Monthly";
    offer18.period = @"6 Months";
    
    Offer *offer19 = [Offer create];
    offer19.name = @"Классик";
    offer19.currency = @"ALL";
    offer19.interestRate = 12;
    offer19.startFunds = 100;
    offer19.capitalize = @"Monthly";
    offer19.period = @"6 Months";
    
    Offer *offer20 = [Offer create];
    offer20.name = @"Национальный";
    offer20.currency = @"BYN";
    offer20.interestRate = 12;
    offer20.startFunds = 1;
    offer20.capitalize = @"Monthly";
    offer20.period = @"6 Months";
    
    Offer *offer21 = [Offer create];
    offer21.name = @"Сохраняй онлайн";
    offer21.currency = @"ALL";
    offer21.interestRate = 11.6;
    offer21.startFunds = 50;
    offer21.capitalize = @"Monthly";
    offer21.period = @">3 Months";
    
    Offer *offer22 = [Offer create];
    offer22.name = @"Особенный 6";
    offer22.currency = @"BYN";
    offer22.interestRate = 11.5;
    offer22.startFunds = 20;
    offer22.capitalize = @"Monthly";
    offer22.period = @"6 Months";
    
    Offer *offer23 = [Offer create];
    offer23.name = @"Срочный";
    offer23.currency = @"BYN";
    offer23.interestRate = 11.5;
    offer23.startFunds = 1;
    offer23.capitalize = @"Monthly";
    offer23.period = @">6 Months";
    
    Offer *offer24 = [Offer create];
    offer24.name = @"Верное решение";
    offer24.currency = @"ALL";
    offer24.interestRate = 11.2;
    offer24.startFunds = 100;
    offer24.capitalize = @"Monthly";
    offer24.period = @"6 Months";
    
    Offer *offer25 = [Offer create];
    offer25.name = @"Открытие";
    offer25.currency = @"ALL";
    offer25.interestRate = 11;
    offer25.startFunds = 100;
    offer25.capitalize = @"Monthly";
    offer25.period = @"6 Months";
    
    Offer *offer26 = [Offer create];
    offer26.name = @"Комфорт 6";
    offer26.currency = @"BYN";
    offer26.interestRate = 11;
    offer26.startFunds = 20;
    offer26.capitalize = @"Monthly";
    offer26.period = @">3 Months";
    
    Offer *offer27 = [Offer create];
    offer27.name = @"Срочный 2";
    offer27.currency = @"ALL";
    offer27.interestRate = 11;
    offer27.startFunds = 5;
    offer27.capitalize = @"Monthly";
    offer27.period = @">3 Months";
    
    Offer *offer28 = [Offer create];
    offer28.name = @"В прямом эфире 6";
    offer28.currency = @"BYN";
    offer28.interestRate = 10.9;
    offer28.startFunds = 20;
    offer28.capitalize = @"Monthly";
    offer28.period = @"6 Months";
    
    Offer *offer29 = [Offer create];
    offer29.name = @"Сохраняй";
    offer29.currency = @"ALL";
    offer29.interestRate = 10.5;
    offer29.startFunds = 100;
    offer29.capitalize = @"Monthly";
    offer29.period = @">3 Months";
    
    Offer *offer30 = [Offer create];
    offer30.name = @"Сохраняй 2";
    offer30.currency = @"ALL";
    offer30.interestRate = 10;
    offer30.startFunds = 100;
    offer30.capitalize = @"Monthly";
    offer30.period = @">3 Months";
    
    Offer *offer31 = [Offer create];
    offer31.name = @"Универсальный";
    offer31.currency = @"ALL";
    offer31.interestRate = 10;
    offer31.startFunds = 100;
    offer31.capitalize = @"Monthly";
    offer31.period = @"6 Months";
    
    Offer *offer32 = [Offer create];
    offer32.name = @"Стабильный доход";
    offer32.currency = @"ALL";
    offer32.interestRate = 9;
    offer32.startFunds = 100;
    offer32.capitalize = @"Monthly";
    offer32.period = @">3 Months";
    
    Offer *offer33 = [Offer create];
    offer33.name = @"Интернет-вклад";
    offer33.currency = @"ALL";
    offer33.interestRate = 11;
    offer33.startFunds = 100;
    offer33.capitalize = @"Monthly";
    offer33.period = @"6 Months";
    
    
    
    
    
    [bank1 addOffersObject:offer2];
    [bank2 addOffersObject:offer1];
    [bank3 addOffersObject:offer3];
    [bank2 addOffersObject:offer4];
    [bank4 addOffersObject:offer5];
    [bank5 addOffersObject:offer6];
    [bank5 addOffersObject:offer7];
    [bank3 addOffersObject:offer8];
    [bank6 addOffersObject:offer9];
    [bank1 addOffersObject:offer10];
    [bank7 addOffersObject:offer11];
    [bank5 addOffersObject:offer12];
    [bank3 addOffersObject:offer13];
    [bank5 addOffersObject:offer14];
    [bank3 addOffersObject:offer15];
    [bank2 addOffersObject:offer16];
    [bank7 addOffersObject:offer17];
    [bank7 addOffersObject:offer18];
    [bank1 addOffersObject:offer19];
    [bank8 addOffersObject:offer20];
    [bank9 addOffersObject:offer21];
    [bank3 addOffersObject:offer22];
    [bank10 addOffersObject:offer23];
    [bank6 addOffersObject:offer24];
    [bank11 addOffersObject:offer25];
    [bank3 addOffersObject:offer26];
    [bank10 addOffersObject:offer27];
    [bank3 addOffersObject:offer28];
    [bank9 addOffersObject:offer29];
    [bank9 addOffersObject:offer30];
    [bank5 addOffersObject:offer31];
    [bank12 addOffersObject:offer32];
    [bank5 addOffersObject:offer33];

    [self save];
}




@end
