unit BaseLocalEmpresaController;

interface

uses generics.Collections, system.sysutils,  system.JSON, rest.json, rest.types,
     untPrincipal, unitConfiguracoes, BaseLocalEmpresaVO, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;

Type TBaseLocalEmpresaController = class

   public
      Class Function retornarDadosEmpresa: TBaseLocalEmpresaVO;
      class Procedure GravarEmpresa(empresa: TBaseLocalEmpresaVO);
      class Procedure AlterarEmpresa(empresa: TBaseLocalEmpresaVO);

end;

implementation

{ TBaseLocalEmpresaController }

class procedure TBaseLocalEmpresaController.AlterarEmpresa(empresa: TBaseLocalEmpresaVO);
Var query: TFDQuery;
Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' UPDATE empresa SET cnpj = :cnpj, ');
      query.SQL.Add('                    razao_social = :razao_social, ');
      query.SQL.Add('                    fantasia = :fantasia, ');
      query.SQL.Add('                    fone = :fone, ');
      query.SQL.Add('                    celular = :celular, ');
      query.SQL.Add('                    email = :email, ');
      query.SQL.Add('                    site = :site, ');
      query.SQL.Add('                    IE = :IE, ');
      query.SQL.Add('                    CODIGO_CIDADE = :CODIGO_CIDADE, ');
      query.SQL.Add('                    LOGRADOURO = :LOGRADOURO, ');
      query.SQL.Add('                    NUMERO = :NUMERO, ');
      query.SQL.Add('                    COMPLEMENTO = :COMPLEMENTO, ');
      query.SQL.Add('                    BAIRRO = :BAIRRO, ');
      query.SQL.Add('                    CIDADE = :CIDADE, ');
      query.SQL.Add('                    UF = :UF, ');
      query.SQL.Add('                    CODIGO_UF = :CODIGO_UF, ');
      query.SQL.Add('                    CEP = :CEP, ');
      query.SQL.Add('                    TIPO_REGIME = :TIPO_REGIME ');
      query.SQL.Add('  WHERE id = :id ');

      query.Params.ParamByName('cnpj').AsString         := empresa.CNPJ;
      query.Params.ParamByName('razao_social').AsString := empresa.RAZAO_SOCIAL;
      query.Params.ParamByName('fantasia').AsString     := empresa.FANTASIA;
      query.Params.ParamByName('fone').AsString         := empresa.FONE;
      query.Params.ParamByName('celular').AsString      := empresa.CELULAR;
      query.Params.ParamByName('email').AsString        := empresa.EMAIL;
      query.Params.ParamByName('site').AsString         := empresa.SITE;
      query.Params.ParamByName('id').AsInteger          := empresa.ID;
      query.Params.ParamByName('IE').AsString             := empresa.IE;
      query.Params.ParamByName('CODIGO_CIDADE').AsInteger := empresa.CODIGO_CIDADE;
      query.Params.ParamByName('LOGRADOURO').AsString     := empresa.LOGRADOURO;
      query.Params.ParamByName('NUMERO').AsString         := empresa.NUMERO;
      query.Params.ParamByName('COMPLEMENTO').AsString    := empresa.COMPLEMENTO;
      query.Params.ParamByName('BAIRRO').AsString         := empresa.BAIRRO;
      query.Params.ParamByName('CIDADE').AsString         := empresa.CIDADE;
      query.Params.ParamByName('UF').AsString             := empresa.UF;
      query.Params.ParamByName('CODIGO_UF').AsInteger     := empresa.CODIGO_UF;
      query.Params.ParamByName('CEP').AsString            := empresa.CEP;
      query.Params.ParamByName('TIPO_REGIME').AsInteger   := empresa.TIPO_REGIME;

      Try

         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         frmPrincipal.qryEmpresa.Refresh;
         prcMsgInf('Registro alterado com sucesso.');

      Except

         frmPrincipal.ConexaoLocal.Rollback;
         frmPrincipal.qryEmpresa.Refresh;
         prcMsgErro('Falha ao alterar o registro.');

      End;


   Finally

      FreeAndNil(query);

   End;

end;

class procedure TBaseLocalEmpresaController.GravarEmpresa(empresa: TBaseLocalEmpresaVO);
Var query: TFDQuery;
Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' INSERT INTO empresa ');
      query.SQL.Add(' (  ');

      query.SQL.Add(' cnpj, razao_social, fantasia, fone, celular, email, site, ');
      query.SQL.Add(' IE, CODIGO_CIDADE, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ');
      query.SQL.Add(' UF, CODIGO_UF, CEP, TIPO_REGIME ');
      query.SQL.Add(' )  ');

      query.SQL.Add(' VALUES  ');

      query.SQL.Add(' (  ');
      query.SQL.Add(' :cnpj, :razao_social, :fantasia, :fone, :celular, :email, :site, ');
      query.SQL.Add(' :IE, :CODIGO_CIDADE, :LOGRADOURO, :NUMERO, :COMPLEMENTO, :BAIRRO, :CIDADE, ');
      query.SQL.Add(' :UF, :CODIGO_UF, :CEP, :TIPO_REGIME ');

      query.SQL.Add(' )  ');

      query.Params.ParamByName('cnpj').AsString           := empresa.CNPJ;
      query.Params.ParamByName('razao_social').AsString   := empresa.RAZAO_SOCIAL;
      query.Params.ParamByName('fantasia').AsString       := empresa.FANTASIA;
      query.Params.ParamByName('fone').AsString           := empresa.FONE;
      query.Params.ParamByName('celular').AsString        := empresa.CELULAR;
      query.Params.ParamByName('email').AsString          := empresa.EMAIL;
      query.Params.ParamByName('site').AsString           := empresa.SITE;
      query.Params.ParamByName('IE').AsString             := empresa.IE;
      query.Params.ParamByName('CODIGO_CIDADE').AsInteger := empresa.CODIGO_CIDADE;
      query.Params.ParamByName('LOGRADOURO').AsString     := empresa.LOGRADOURO;
      query.Params.ParamByName('NUMERO').AsString         := empresa.NUMERO;
      query.Params.ParamByName('COMPLEMENTO').AsString    := empresa.COMPLEMENTO;
      query.Params.ParamByName('BAIRRO').AsString         := empresa.BAIRRO;
      query.Params.ParamByName('CIDADE').AsString         := empresa.CIDADE;
      query.Params.ParamByName('UF').AsString             := empresa.UF;
      query.Params.ParamByName('CODIGO_UF').AsInteger     := empresa.CODIGO_UF;
      query.Params.ParamByName('CEP').AsString            := empresa.CEP;
      query.Params.ParamByName('TIPO_REGIME').AsInteger   := empresa.TIPO_REGIME;

      Try

         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         frmPrincipal.qryEmpresa.Refresh;
         prcMsgInf('Registro inserido com sucesso.');

      Except

         frmPrincipal.ConexaoLocal.Rollback;
         frmPrincipal.qryEmpresa.Refresh;
         prcMsgErro('Falha ao inserir o registro.');

      End;


   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalEmpresaController.retornarDadosEmpresa: TBaseLocalEmpresaVO;
Var query: TFDQuery;
    empresa: TBaseLocalEmpresaVO;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM empresa ');
      query.open;

      empresa := TBaseLocalEmpresaVO.Create;

      if Not(query.IsEmpty) then Begin

         empresa.ID           := query.FieldByName('id').AsInteger;
         empresa.CNPJ         := query.FieldByName('CNPJ').Asstring;
         empresa.RAZAO_SOCIAL := query.FieldByName('RAZAO_SOCIAL').Asstring;
         empresa.FANTASIA     := query.FieldByName('FANTASIA').Asstring;
         empresa.FONE         := query.FieldByName('FONE').Asstring;
         empresa.CELULAR      := query.FieldByName('CELULAR').Asstring;
         empresa.EMAIL        := query.FieldByName('EMAIL').Asstring;
         empresa.SITE         := query.FieldByName('SITE').Asstring;
         empresa.BASE_LOCAL   := query.FieldByName('BASE_LOCAL').Asstring;

         Result := empresa;

      End;

   Finally

      FreeAndNil(query);

   End;

end;

end.
