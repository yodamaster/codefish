object dbConns: TdbConns
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 65
  Width = 165
  object dbConnect: TADOConnection
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object dbQuery: TADOQuery
    Connection = dbConnect
    Parameters = <>
    Left = 96
    Top = 8
  end
end
