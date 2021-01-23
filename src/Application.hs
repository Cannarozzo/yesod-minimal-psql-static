{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core

import Add
import Home

import Handler.BlogPost
import Handler.Pessoa.Pessoa
import Handler.Pessoa.PessoaCadastro
import Handler.Pessoa.Pessoas
import Handler.Pessoa.PessoaRemove
import Handler.Pessoa.PessoaAtualiza


mkYesodDispatch "App" resourcesApp
