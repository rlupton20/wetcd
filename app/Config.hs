{-# LANGUAGE OverloadedStrings #-}
module Config where

import Data.Yaml
import Control.Applicative

import Control.Monad.IO.Class

data WetcdConfig = WetcdConfig { server :: ServerConfig
                               , backend :: BackendConfig } deriving (Show)

data ServerConfig = ServerConfig { port :: Int } deriving (Show)

data BackendConfig = BackendConfig { db :: String
                                   , address :: String } deriving (Show)


instance FromJSON WetcdConfig where
  parseJSON (Object v) = WetcdConfig <$> v .: "server" <*> v .: "backend"

instance FromJSON ServerConfig where
  parseJSON (Object v) = ServerConfig <$> v .: "port"
  parseJSON _ = empty

instance FromJSON BackendConfig where
  parseJSON (Object v) = BackendConfig <$> v .: "db" <*> v .: "address"
  parseJSON _ = empty

loadConfigFromFile :: String -> IO (Either ParseException WetcdConfig)
loadConfigFromFile = decodeFileEither

withConfig :: (MonadIO m) =>  String -> (WetcdConfig -> m a) -> m a
withConfig file action = do
  pconfig <- liftIO $ loadConfigFromFile file
  either (fail.show) action pconfig
