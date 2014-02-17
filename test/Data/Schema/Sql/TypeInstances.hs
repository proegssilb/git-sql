module Data.Schema.Sql.TypeInstances
where

import Test.QuickCheck
import Data.Char
import Control.Monad

import Data.Schema.Sql.Types

instance Arbitrary Name where
    arbitrary = liftM Name (sized letters)
        where   letters 0 = liftM ( :[] ) letter
                letters n = liftM2 (:) letter (letters (n-1))
                letter = oneof [choose ('A', 'Z'), choose ('a', 'z')]

instance Arbitrary Column where
    arbitrary = liftM2 Column arbitrary arbitrary

instance Arbitrary Datatype where
    arbitrary = oneof [return Varchar, return Chardt, return Integerdt, return Real, return Decimal, return Bit, return Bits]

instance Arbitrary Table where
    arbitrary = liftM2 Table arbitrary arbitrary

data TableScript = TableScript [Char] Table

instance Arbitrary TableScript where
    arbitrary = do
                    Name name <- arbitrary :: Gen Name
                    columnList <- sized cols'
                    let colsStr = foldl1 (\a b -> a ++ ",\n" ++ b) . map (\(cnm, ctp) -> "  " ++ cnm ++ " " ++ (show ctp)) $ columnList
                        tblCols = map (\(cnm, ctyp) -> Column cnm ctyp) columnList
                        tbl = Table (Name name) tblCols
                        scr = "CREATE TABLE " ++ name ++ " (\n" ++ colsStr ++ "\n)"
                        in return (TableScript scr tbl)
                where   cols' 0 = liftM (: []) genCol
                        cols' n = liftM2 (:) genCol (cols' (n-1))
                        genCol = (do {Name n <- arbitrary; t <- arbType; return (n, t)})
                        arbType = arbitrary :: Gen Datatype
