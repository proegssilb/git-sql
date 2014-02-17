{-# LANGUAGE TemplateHaskell #-}

module Main (
    main
) where

import Test.Tasty
import Test.Tasty.QuickCheck
import System.Exit

import qualified Data.Schema.Sql.ScriptParseTest as SPT (testGroup)

main = defaultMain tests

tests :: TestTree
tests =
    testGroup "All Tests" [
        SPT.testGroup
    ]
