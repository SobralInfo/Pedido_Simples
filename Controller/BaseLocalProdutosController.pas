unit BaseLocalProdutosController;

interface

uses generics.Collections, system.sysutils,  system.JSON, rest.json, rest.types,
     untPrincipal, unitConfiguracoes, BaseLocalProdutosVO, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;

Type
   TBaseLocalProdutosController = class

      class Procedure AlterarProduto(produto: TBaseLocalProdutosVO);
      class Procedure GravarProduto(produto: TBaseLocalProdutosVO);
      class Function SaberSeImprimirCozinha(id: integer): Boolean;


   end;

implementation

{ TBaseLocalProdutosController }

class procedure TBaseLocalProdutosController.AlterarProduto(produto: TBaseLocalProdutosVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' UPDATE produtos SET STATUS = :STATUS, ');
      query.SQL.Add('                     DESCRICAO = :DESCRICAO, ');
      query.SQL.Add('                     QTDE_ESTOQUE = :QTDE_ESTOQUE, ');
      query.SQL.Add('                     REFERENCIA = :REFERENCIA, ');
      query.SQL.Add('                     ID_UNIDADE = :ID_UNIDADE, ');
      query.SQL.Add('                     CODIGO_BARRAS = :CODIGO_BARRAS, ');
      query.SQL.Add('                     VALOR_UNITARIO = :VALOR_UNITARIO, ');
      query.SQL.Add('                     IMPRIMIR_COZINHA = :IMPRIMIR_COZINHA, ');
      query.SQL.Add('                     cest = :cest, ');
      query.SQL.Add('                     CST_CSOSN = :CST_CSOSN, ');
      query.SQL.Add('                     CST_PIS = :CST_PIS, ');
      query.SQL.Add('                     CST_COFINS = :CST_COFINS, ');
      query.SQL.Add('                     TAXA_PIS = :TAXA_PIS, ');
      query.SQL.Add('                     TAXA_COFINS = :TAXA_COFINS, ');
      query.SQL.Add('                     TAXA_ICMS = :TAXA_ICMS, ');
      query.SQL.Add('                     ORIGEM = :ORIGEM, ');
      query.SQL.Add('                     NCM = :NCM, ');
      query.SQL.Add('                     CFOP = :CFOP, ');
      query.SQL.Add('                     FISCAL = :FISCAL ');
      query.SQL.Add('  WHERE id = :id ');

      query.Params.ParamByName('status').AsString           := Trim(produto.STATUS);
      query.Params.ParamByName('DESCRICAO').AsString        := Trim(produto.DESCRICAO);
      query.Params.ParamByName('QTDE_ESTOQUE').AsFloat      := produto.QTDE_ESTOQUE;
      query.Params.ParamByName('REFERENCIA').AsString       := Trim(produto.REFERENCIA);
      query.Params.ParamByName('ID_UNIDADE').AsInteger      := produto.ID_UNIDADE;
      query.Params.ParamByName('CODIGO_BARRAS').AsString    := Trim(produto.CODIGO_BARRAS);
      query.Params.ParamByName('VALOR_UNITARIO').AsFloat    := produto.VALOR_UNITARIO;
      query.Params.ParamByName('ID').AsInteger              := produto.ID;
      query.Params.ParamByName('IMPRIMIR_COZINHA').AsString := Trim(produto.ImprimirCozinha);

      query.Params.ParamByName('cest').AsString             := Trim(produto.cest);
      query.Params.ParamByName('CST_CSOSN').AsString        := Trim(produto.CST_CSOSN);
      query.Params.ParamByName('CST_PIS').AsString          := Trim(produto.CST_PIS);
      query.Params.ParamByName('CST_COFINS').AsString       := Trim(produto.CST_COFINS);
      query.Params.ParamByName('TAXA_PIS').AsFloat          := produto.TAXA_PIS;
      query.Params.ParamByName('TAXA_COFINS').AsFloat       := produto.TAXA_COFINS;
      query.Params.ParamByName('TAXA_ICMS').AsFloat         := produto.TAXA_ICMS;
      query.Params.ParamByName('ORIGEM').AsInteger          := produto.ORIGEM;
      query.Params.ParamByName('NCM').AsString              := Trim(produto.NCM);
      query.Params.ParamByName('CFOP').AsString             := Trim(produto.CFOP);
      query.Params.ParamByName('FISCAL').AsString           := produto.fiscal;

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryProdutos.Refresh;
         Except
            frmPrincipal.qryProdutos.Close;
            frmPrincipal.qryProdutos.Open;
         End;
         prcMsgInf('Registro alterado com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryProdutos.Refresh;
         Except
            frmPrincipal.qryProdutos.Close;
            frmPrincipal.qryProdutos.Open;
         End;
         prcMsgErro('Não foi possível alterar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class procedure TBaseLocalProdutosController.GravarProduto(produto: TBaseLocalProdutosVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' INSERT INTO produtos ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' STATUS, DESCRICAO, QTDE_ESTOQUE, REFERENCIA, ');
      query.SQL.Add(' ID_UNIDADE, CODIGO_BARRAS, VALOR_UNITARIO, IMPRIMIR_COZINHA, ');
      query.SQL.Add(' cest, CST_CSOSN, CST_PIS, CST_COFINS, TAXA_PIS, TAXA_COFINS, ');
      query.SQL.Add(' TAXA_ICMS, ORIGEM, NCM, CFOP, FISCAL ');
      query.SQL.Add(' )  ');
      query.SQL.Add(' VALUES  ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' :STATUS, :DESCRICAO, :QTDE_ESTOQUE, :REFERENCIA, ');
      query.SQL.Add(' :ID_UNIDADE, :CODIGO_BARRAS, :VALOR_UNITARIO, :IMPRIMIR_COZINHA, ');
      query.SQL.Add(' :cest, :CST_CSOSN, :CST_PIS, :CST_COFINS, :TAXA_PIS, :TAXA_COFINS, ');
      query.SQL.Add(' :TAXA_ICMS, :ORIGEM, :NCM, :CFOP, :FISCAL ');
      query.SQL.Add(' )  ');

      query.Params.ParamByName('status').AsString           := Trim(produto.STATUS);
      query.Params.ParamByName('DESCRICAO').AsString        := Trim(produto.DESCRICAO);
      query.Params.ParamByName('QTDE_ESTOQUE').AsFloat      := produto.QTDE_ESTOQUE;
      query.Params.ParamByName('REFERENCIA').AsString       := Trim(produto.REFERENCIA);
      query.Params.ParamByName('ID_UNIDADE').AsInteger      := produto.ID_UNIDADE;
      query.Params.ParamByName('CODIGO_BARRAS').AsString    := Trim(produto.CODIGO_BARRAS);
      query.Params.ParamByName('VALOR_UNITARIO').AsFloat    := produto.VALOR_UNITARIO;
      query.Params.ParamByName('IMPRIMIR_COZINHA').AsString := Trim(produto.ImprimirCozinha);

      query.Params.ParamByName('cest').AsString             := Trim(produto.cest);
      query.Params.ParamByName('CST_CSOSN').AsString        := Trim(produto.CST_CSOSN);
      query.Params.ParamByName('CST_PIS').AsString          := Trim(produto.CST_PIS);
      query.Params.ParamByName('CST_COFINS').AsString       := Trim(produto.CST_COFINS);
      query.Params.ParamByName('TAXA_PIS').AsFloat          := produto.TAXA_PIS;
      query.Params.ParamByName('TAXA_COFINS').AsFloat       := produto.TAXA_COFINS;
      query.Params.ParamByName('TAXA_ICMS').AsFloat         := produto.TAXA_ICMS;
      query.Params.ParamByName('ORIGEM').AsInteger          := produto.ORIGEM;
      query.Params.ParamByName('NCM').AsString              := Trim(produto.NCM);
      query.Params.ParamByName('CFOP').AsString             := Trim(produto.CFOP);
      query.Params.ParamByName('FISCAL').AsString           := produto.fiscal;

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryProdutos.Refresh;
         Except
            frmPrincipal.qryProdutos.Close;
            frmPrincipal.qryProdutos.Open;
         End;
         prcMsgInf('Registro inserido com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryProdutos.Refresh;
         Except
            frmPrincipal.qryProdutos.Close;
            frmPrincipal.qryProdutos.Open;
         End;
         prcMsgErro('Não foi possível gravar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalProdutosController.SaberSeImprimirCozinha(id: integer): Boolean;
var query: TFDQuery;
begin

   Try

      Result := False;

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT imprimir_cozinha FROM produtos WHERE id = '+id.ToString);
      query.Open;

      if query.FieldByName('imprimir_cozinha').AsString = 'S' then
         Result := True;

   Finally

      FreeAndNil(query);

   End;

end;

end.
