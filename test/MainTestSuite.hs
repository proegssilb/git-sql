{-# LANGUAGE TemplateHaskell #-}
-- MainTestSuite.hs
--
-- Copyright 2014 David Bliss <david@algorithmicarmada.com>
--
-- See the LICENSE file provided in the source distribution. If none is
-- available, the license for this file is the BSD 3-Clause, available at:
--
--   http://choosealicense.com/licenses/bsd-3-clause/

module Main (
    main
) where

import Test.Tasty
import Test.Tasty.QuickCheck
import System.Exit

import qualified Data.Schema.Sql.ScriptParseTest as SPT (testGroup)
import qualified Data.Schema.Sql.SqlFetchTest as SFT (testGroup)

main = defaultMain tests

tests :: TestTree
tests =
    testGroup "All Tests" [
        SPT.testGroup,
        SFT.testGroup
    ]
