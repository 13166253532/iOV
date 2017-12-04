//
//  HTCitiesListInfo.m
//  HiTeacher
//
//  Created by dmshi on 16/5/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "HTCitiesListInfo.h"

@implementation HTCitiesListInfo

@end

@implementation NSObject (PrintCitiesListSQL)
+(NSString*)getCitiesListSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
        {
            if(property.length>0)
            {
                [table_pars appendFormat:@"(%ld)",(long)property.length];
            }
        }
        if(property.isNotNull)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
        }
        if(property.isUnique)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
        }
        if(property.checkValue)
        {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
        }
        if(property.defaultValue)
        {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
        }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
        }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}

@end