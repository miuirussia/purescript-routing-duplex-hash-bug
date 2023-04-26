module Test.RouterSpec where

import Prelude hiding ((/))

import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Routing.Duplex (RouteDuplex', end, parse, root, hash)
import Routing.Duplex.Generic (noArgs, sum)
import Routing.Duplex.Generic.Syntax ((/))
import Routing.Duplex.Parser (RouteError)

import Test.Spec (Spec, describe, describeOnly, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describeOnly "Routing.Duplex" do
  describe "parseRoute" do
    it "should match routes" do
      (parseRoute "/") `shouldEqual` (Right Root)
      (parseRoute "/settings") `shouldEqual` (Right Settings)
      (parseRoute "/settings#hash") `shouldEqual` (Right (SettingsWithHash "hash")) -- Error: (Right Settings) ≠ (Right (SettingsWithHash "hash"))

routes :: RouteDuplex' Routes
routes =
  root $ end $ sum
    { "Root": noArgs
    , "Settings": "settings" / noArgs
    , "SettingsWithHash": "settings" / hash
    }

parseRoute :: String -> Either RouteError Routes
parseRoute = parse routes

data Routes
  = Root
  | Settings
  | SettingsWithHash String

derive instance Eq Routes
derive instance Generic Routes _
instance Show Routes where
  show = genericShow

