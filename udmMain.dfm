object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 704
  Top = 401
  Height = 137
  Width = 328
  object sqlconDB: TSQLConnection
    DriverName = 'Oracle'
    GetDriverFunc = 'getSQLDriverORACLE'
    LibraryName = 'dbexpora.dll'
    Params.Strings = (
      'BlobSize=-1'
      'DataBase=ora722'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=password'
      'Oracle TransIsolation=ReadCommited'
      'User_Name=user')
    VendorLib = 'OCI.DLL'
    Left = 22
    Top = 12
  end
  object sqlqryTemp: TSQLQuery
    NoMetadata = True
    SQLConnection = sqlconDB
    Params = <>
    Left = 84
    Top = 12
  end
  object sqlqryTemp2: TSQLQuery
    NoMetadata = True
    SQLConnection = sqlconDB
    Params = <>
    Left = 147
    Top = 12
  end
  object sqldsTemp: TSQLDataSet
    SQLConnection = sqlconDB
    Params = <>
    Left = 210
    Top = 12
  end
end
