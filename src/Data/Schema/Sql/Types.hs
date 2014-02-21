-- Types.hs
--
-- Copyright 2014 David Bliss <david@algorithmicarmada.com>
--
-- See the LICENSE file provided in the source distribution. If none is
-- available, the license for this file is the BSD 3-Clause, available at:
--
--   http://choosealicense.com/licenses/bsd-3-clause/
module Data.Schema.Sql.Types
where

newtype Name = Name [Char] deriving (Show, Eq)

data Datatype = Varchar | Chardt | Integerdt | Real | Decimal | Bit | Bits deriving (Show, Eq)

data Column = Column String Datatype deriving (Show, Eq)

data Table = Table Name [Column] deriving (Show, Eq)

data CreateStmt = CreateTable (Table) | Seq [CreateStmt] deriving Show
