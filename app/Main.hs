{-# LANGUAGE OverloadedStrings #-}
module Main where

import Config

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp

import Data.DHT.Etcd

import qualified Data.ByteString.Char8 as B

-- Temp
import Data.String

main :: IO ()
main = do
       withConfig "testConf.yaml" $ \conf -> do
         putStrLn $ show conf
         let etcdNode = etcd (address.backend $ conf)
         run (port.server $ conf) $ authenticator (query etcdNode)
       

-- |query forwards a request to etcd
query :: Etcd -> Application
query etcdNode req respond = do
  let path = B.unpack $ rawPathInfo req
  res <- getRaw etcdNode path
  respond $ responseLBS status200 [] $ fromString res


-- | authenticator is a piece of middleware that restricts which
-- part of the key space an individual user is allowed to see.
-- It is a stub at the moment, and just passes all requests and
-- responses through.
authenticator :: Middleware
authenticator = id
