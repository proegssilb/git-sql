-- ScriptParse.hs
--
-- Copyright 2014 David Bliss <david@algorithmicarmada.com>
--
-- See the LICENSE file provided in the source distribution. If none is
-- available, the license for this file is the BSD 3-Clause, available at:
--
--   http://choosealicense.com/licenses/bsd-3-clause/

module Data.Schema.Sql.ScriptParse
where

import Data.Schema.Sql.Types as SqlTypes
import Control.Applicative((<*))
import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Expr
import Text.Parsec.Token
import Text.Parsec.Language

sqlDef = emptyDef{  identStart = letter,
                    identLetter = letter,
                    reservedNames = ["create", "table", "varchar", "char", "integer", "real", "decimal", "bit", "bits"],
                    caseSensitive = False
                 }

TokenParser {   parens = t_parens,
                identifier = t_identifier,
                reserved = t_reserved,
                commaSep1 = t_commaSep1,
                whiteSpace = t_whiteSpace,
                semiSep1 = t_semiSep1
            } = makeTokenParser sqlDef

sqlparser :: Parser [CreateStmt]
sqlparser = t_whiteSpace >> stmtsparser <* eof
    where   stmtsparser :: Parser [CreateStmt]
            stmtsparser = (t_semiSep1 stmt)
            stmt :: Parser CreateStmt
            stmt = do
                        t_reserved "CREATE"
                        t_reserved "TABLE"
                        name <- t_identifier
                        cols <- t_parens (t_commaSep1 colspec)
                        return (CreateTable $ Table (Name name) cols)
            colspec :: Parser SqlTypes.Column
            colspec = do
                        t_whiteSpace
                        name <- t_identifier
                        typ <- parseDatatype
                        return (Column name typ)
            parseDatatype :: Parser SqlTypes.Datatype
            parseDatatype =
                do {t_reserved "varchar"; return Varchar;}
                <|> do {t_reserved "char"; return Chardt;}
                <|> do {t_reserved "integer"; return Integerdt;}
                <|> do {t_reserved "real"; return Real;}
                <|> do {t_reserved "decimal"; return Decimal;}
                <|> do {t_reserved "bit"; return Bit;}
                <|> do {t_reserved "bits"; return Bits;}

parseScript :: String -> Table
parseScript inp = case parse sqlparser "" inp of
                    Left err -> Table (Name "") []
                    Right stlst -> table where CreateTable table = stlst !! 0
