{-# LANGUAGE OverloadedStrings #-}

import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core

import Database.Persist.Postgresql
import Control.Monad.Logger (runStdoutLoggingT)

connStr = "dbname=proj host=localhost user=fulano password=123 port=5432"

main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do 
       runSqlPersistMPool (runMigration migrateAll) pool
       warp 8080 (App pool)