unit BaseLocalParametrosController;

interface

uses generics.Collections, system.sysutils,  system.JSON, rest.json, rest.types,
     untPrincipal, unitConfiguracoes, BaseLocalParametrosVO, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;

Type TBaseLocalParametrosController = class

   public
      Class Function retornarParametros: TBaseLocalParametrosVO;
      class Procedure GravarParametros(config: TBaseLocalParametrosVO);
      class Procedure AlterarParametros(config: TBaseLocalParametrosVO);


end;

implementation

{ TBaseLocalParametrosController }

class procedure TBaseLocalParametrosController.AlterarParametros(config: TBaseLocalParametrosVO);
begin

end;

class procedure TBaseLocalParametrosController.GravarParametros(config: TBaseLocalParametrosVO);
Var query: TFDQuery;
    parametro: TBaseLocalParametrosVO;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' UPDATE configuracoes SET caixa = :caixa, ');
      query.SQL.Add('                          base_local = :base, ');
      query.SQL.Add('                          tipo_desconto_pedido = :tipo_desconto_pedido, ');
      query.SQL.Add('                          CERTIFICADO_DIGITAL = :CERTIFICADO_DIGITAL, ');
      query.SQL.Add('                          CERTIFICADO = :CERTIFICADO, ');
      query.SQL.Add('                          ID_CSC_NFCE = :ID_CSC_NFCE, ');
      query.SQL.Add('                          CSC_NFCE = :CSC_NFCE, ');
      query.SQL.Add('                          NUMERO_NFCE = :NUMERO_NFCE, ');
      query.SQL.Add('                          SERIE_NFCE = :SERIE_NFCE, ');
      query.SQL.Add('                          FORMA_EMISSAO = :FORMA_EMISSAO, ');
      query.SQL.Add('                          TIPO_AMBIENTE = :TIPO_AMBIENTE  ');
      query.SQL.Add('  WHERE id = 1 ');
      query.Params.ParamByName('caixa').AsString                 := config.CAIXA;
      query.Params.ParamByName('base').AsString                  := config.BASE_LOCAL;
      query.Params.ParamByName('tipo_desconto_pedido').AsString  := config.tipo_desconto_pedido;

      query.Params.ParamByName('CERTIFICADO').AsString          := config.CERTIFICADO_DIGITAL;
      query.Params.ParamByName('CERTIFICADO_DIGITAL').AsString  := config.CERTIFICADO_DIGITAL;
      query.Params.ParamByName('ID_CSC_NFCE').AsString          := config.ID_CSC_NFCE;
      query.Params.ParamByName('CSC_NFCE').AsString             := config.CSC_NFCE;
      query.Params.ParamByName('NUMERO_NFCE').AsInteger         := config.NUMERO_NFCE;
      query.Params.ParamByName('SERIE_NFCE').AsInteger          := config.SERIE_NFCE;
      query.Params.ParamByName('FORMA_EMISSAO').AsString        := config.FORMA_EMISSAO;
      query.Params.ParamByName('TIPO_AMBIENTE').AsString        := config.TIPO_AMBIENTE;

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         prcMsgInf('Registro salvo com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         prcMsgInf('Falha ao salvar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalParametrosController.retornarParametros: TBaseLocalParametrosVO;
Var query: TFDQuery;
    parametro: TBaseLocalParametrosVO;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM configuracoes ');
      query.open;

      parametro := TBaseLocalParametrosVO.Create;

      if Not(query.IsEmpty) then Begin

         parametro.ID                   := query.FieldByName('id').AsInteger;
         parametro.BASE_LOCAL           := query.FieldByName('BASE_LOCAL').Asstring;
         parametro.TIPO_DESCONTO_PEDIDO := query.FieldByName('TIPO_DESCONTO_PEDIDO').Asstring;

      End;

      Result := parametro;

   Finally

      FreeAndNil(query);

   End;

end;
end.
