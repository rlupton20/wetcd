{-# LANGUAGE OverloadedStrings #-}
module Main where

import Config

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run, defaultSettings, setPort)

import Data.DHT.Etcd

import qualified Data.ByteString.Char8 as B
import Data.Text
-- Temp
import Data.String

main :: IO ()
main = do
       withConfig "/config/testConf.yaml" $ \conf -> do
         let etcdNode = etcd (address.backend $ conf)
         run (port.server $ conf) $ authenticator (query etcdNode)

-- |query forwards a request to etcd
query :: Etcd -> Application
query etcdNode req respond = do
  let headers = requestHeaders req
      path = B.unpack $ rawPathInfo req
  res <- getRaw etcdNode path
  respond $ responseLBS status200 [] $ fromString (res ++ show headers)


-- | authenticator is a piece of middleware that restricts which
-- part of the key space an individual user is allowed to see.
-- It is a stub at the moment, and just passes all requests and
-- responses through.
authenticator :: Middleware
authenticator = id

-- bool reject action $ permitted fingerprint request

newtype Fingerprint = Fingerprint Text deriving (Eq)

permitted :: Fingerprint -> Request -> Bool
permitted = undefined
