module Data.Schema.Sql.Types
where

newtype Name = Name [Char] deriving (Show, Eq)

data Datatype = Varchar | Chardt | Integerdt | Real | Decimal | Bit | Bits deriving (Show, Eq)

data Column = Column String Datatype deriving (Show, Eq)

data Table = Table Name [Column] deriving (Show, Eq)

data CreateStmt = CreateTable (Table) | Seq [CreateStmt] deriving Show
