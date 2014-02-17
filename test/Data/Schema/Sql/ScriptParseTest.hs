{-# LANGUAGE TemplateHaskell #-}

module Data.Schema.Sql.ScriptParseTest
where

import Test.QuickCheck
import Test.HUnit
import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit
import Test.Tasty.TH


import Data.Schema.Sql.TypeInstances
import Data.Schema.Sql.Types
import Data.Schema.Sql.ScriptParse

--- TESTS GO HERE  ---

--prop_ParsesTables :: [Char] -> Table -> Bool
--prop_ParsesTables script tbl =  parseScript script == tbl

case_BasicTableParse = do (Table (Name "asdf") [(Column "qwer" Integerdt), (Column "kjhj" Varchar)]) @=? parseScript "CREATE TABLE asdf (\n  qwer INTEGER,\n  kjhj VARCHAR\n)"

--- TESTS END HERE ---

testGroup = $(testGroupGenerator)
