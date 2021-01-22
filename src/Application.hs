{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core

import Add
import Home
import Pessoa
import BlogPost

import PessoaCadastro
import Pessoas
import PessoaRemove
import PessoaAtualiza


mkYesodDispatch "App" resourcesApp
