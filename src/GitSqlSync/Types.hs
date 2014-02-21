module GitSqlSync.Types where

import Data.Time.Clock

-- This record will get quite a bit bigger, and we need a way to refer
-- to individual fields.
data Config = Config
                {
                    lastSyncTimestamp :: UTCTime
                }
