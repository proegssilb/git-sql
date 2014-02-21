-- SqlFetch.hs
--
-- Copyright 2014 David Bliss <david@algorithmicarmada.com>
--
-- See the LICENSE file provided in the source distribution. If none is
-- available, the license for this file is the BSD 3-Clause, available at:
--
--   http://choosealicense.com/licenses/bsd-3-clause/

module Data.Schema.Sql.SqlFetch where

import Data.Schema.Sql.Types

fetchTable :: String -> String -> IO Table
fetchTable schema name = do {return $ Table (Name "tables") [Column "bar" Varchar]}
