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
import Database.HDBC
import Database.HDBC.PostgreSQL

fetchTable ::Connection -> String -> String -> IO Table
fetchTable conn schema name = do 
  tblDesc <- describeTable conn name
  return $ Table (Name name) (map (\(nm, coldesc) -> Column nm Varchar) tblDesc)

-- |Obtains a connection to any supported DB. P(ostgres) is the only prefix
--  available at the moment.
connect :: String -> IO Connection
connect ('P':connstr) = connectPostgreSQL connstr

