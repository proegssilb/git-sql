{-# LANGUAGE TemplateHaskell #-}
-- SqlFetchTest.hs
--
-- Copyright 2014 David Bliss <david@algorithmicarmada.com>
--
-- See the LICENSE file provided in the source distribution. If none is
-- available, the license for this file is the BSD 3-Clause, available at:
--
--   http://choosealicense.com/licenses/bsd-3-clause/

module Data.Schema.Sql.SqlFetchTest
where

import Test.QuickCheck
import Test.HUnit
import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit
import Test.Tasty.TH

import Data.Schema.Sql.TypeInstances
import Data.Schema.Sql.Types
import Data.Schema.Sql.SqlFetch


case_FetchInformationSchemaTable = do
        conn <- connect "Phost=localhost user=postgres"
        Table (Name tblName) cols <- fetchTable conn "information_schema" "tables"
        "tables" @=? tblName
        length(cols) @=? 12


testGroup = $(testGroupGenerator)
