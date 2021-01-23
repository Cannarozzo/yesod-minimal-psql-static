{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE FlexibleContexts #-}

module Handler.Pessoa.PessoaAtualiza where

import Foundation
import Yesod.Core
import Yesod
import Control.Applicative
import Data.Text (Text)


getPessoaAtualizaR :: PessoaId -> Handler Html
getPessoaAtualizaR pid = do 
    pessoa <- runDB $ get404 pid
    let nome = (pessoaNome pessoa)
        sobrenome = (pessoaSobreNome pessoa)
        idade = (pessoaIdade pessoa)
        
    defaultLayout
        [whamlet| 
            <form acion=@{PessoaAtualizaR pid} method=post>
                Nome
                <input type=text name=nome value=#{nome}>
                <br>
                Sobre nome
                <input type=text name=sobrenome value=#{sobrenome}>
                <br>
                Idade
                <input type=number name=idade value=#{idade}>
                <br>
                <input type=submit value=alterar>
        |]


postPessoaAtualizaR :: PessoaId -> Handler Html
postPessoaAtualizaR pid =
    (runInputPost $ Pessoa 
                <$> ireq textField "nome" 
                <*> ireq textField "sobrenome" 
                <*> ireq intField "idade")                  >>= \ pessoaForm ->
    --primeira computacao: extrair dados do formulario e passar o resultado...(injetando a funcao)
    (runDB $ get404 pid)                                    >>= \ pessoaDadosAntigos ->
    --segunda computacao: acesso ao banco de dados para extrair os dados da pessoa antes da atualizacao
    (runDB $ update pid 
        [PessoaNome =. (pessoaNome pessoaForm),
         PessoaSobreNome =. (pessoaSobreNome pessoaForm), 
         PessoaIdade =. pessoaIdade pessoaForm ] )          >> 
    -- terceira computacao: acesso ao banco de dados para atualizar os dados da pessoa  
    defaultLayout 
        [whamlet|
            <p>
                Antes: #{show pessoaDadosAntigos}
            <p>
                Depois: #{show pessoaForm}
        |]
    -- ultima computacao: retorno do tipo Html (return)