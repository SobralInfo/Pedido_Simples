unit BaseLocalClientesController;

interface

uses generics.Collections, system.sysutils,  system.JSON, rest.json, rest.types,
     untPrincipal, unitConfiguracoes, BaseLocalClientesVO, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;

Type TBaseLocalClientesController = class

   class Function RetornarClientePorID(id: integer): TBaseLocalClientesVO;
   class Function RetornarClientePorCPF(CPF: String): TBaseLocalClientesVO;
   class Function RetornarUFporID(id: integer): String;
   class Procedure AlterarCliente(cliente: TBaseLocalClientesVO);
   class Procedure GravarCliente(cliente: TBaseLocalClientesVO);

end;

implementation

{ TBaseLocalClientesController }

class procedure TBaseLocalClientesController.AlterarCliente(cliente: TBaseLocalClientesVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' UPDATE CLIENTES SET STATUS = :STATUS, ');
      query.SQL.Add('                     CPF_CNPJ = :CPF_CNPJ, ');
      query.SQL.Add('                     NOME = :NOME, ');
      query.SQL.Add('                     LOGRADOURO = :LOGRADOURO, ');
      query.SQL.Add('                     NUMERO = :NUMERO, ');
      query.SQL.Add('                     COMPLEMENTO = :COMPLEMENTO, ');
      query.SQL.Add('                     BAIRRO = :BAIRRO, ');
      query.SQL.Add('                     CIDADE = :CIDADE, ');
      query.SQL.Add('                     CONTATO = :CONTATO, ');
      query.SQL.Add('                     fone_fixo = :fone_fixo, ');
      query.SQL.Add('                     celular = :celular, ');
      query.SQL.Add('                     referencia = :referencia ');
      query.SQL.Add('  WHERE id = :id ');

      query.Params.ParamByName('status').AsString      := Trim(cliente.STATUS);
      query.Params.ParamByName('CPF_CNPJ').AsString    := Trim(cliente.CPF_CNPJ);
      query.Params.ParamByName('NOME').AsString        := Trim(cliente.NOME);
      query.Params.ParamByName('LOGRADOURO').AsString  := Trim(cliente.LOGRADOURO);
      query.Params.ParamByName('NUMERO').AsString      := Trim(cliente.NUMERO);
      query.Params.ParamByName('COMPLEMENTO').AsString := Trim(cliente.COMPLEMENTO);
      query.Params.ParamByName('BAIRRO').AsString      := Trim(cliente.BAIRRO);
      query.Params.ParamByName('CIDADE').AsInteger     := cliente.CIDADE;
      query.Params.ParamByName('CONTATO').AsString     := Trim(cliente.CONTATO);
      query.Params.ParamByName('id').AsInteger         := cliente.id;
      query.Params.ParamByName('fone_fixo').AsString   := Trim(cliente.fone_fixo);
      query.Params.ParamByName('celular').AsString     := Trim(cliente.celular);
      query.Params.ParamByName('referencia').AsString  := Trim(cliente.referencia);

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryClientes.Refresh;
         Except
            frmPrincipal.qryClientes.Close;
            frmPrincipal.qryClientes.Open;
         End;
         prcMsgInf('Registro alterado com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryClientes.Refresh;
         Except
            frmPrincipal.qryClientes.Close;
            frmPrincipal.qryClientes.Open;
         End;
         prcMsgErro('N�o foi poss�vel alterar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;


class procedure TBaseLocalClientesController.GravarCliente(cliente: TBaseLocalClientesVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' INSERT INTO CLIENTES ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' STATUS, CPF_CNPJ, NOME, LOGRADOURO, NUMERO, ');
      query.SQL.Add(' COMPLEMENTO, BAIRRO, CIDADE, CONTATO, fone_fixo, celular, referencia ');
      query.SQL.Add(' ) ');
      query.SQL.Add(' VALUES ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' :STATUS, :CPF_CNPJ, :NOME, :LOGRADOURO, :NUMERO, ');
      query.SQL.Add(' :COMPLEMENTO, :BAIRRO, :CIDADE, :CONTATO, :fone_fixo, :celular, :referencia ');
      query.SQL.Add(' ) ');

      query.Params.ParamByName('status').AsString      := Trim(cliente.STATUS);
      query.Params.ParamByName('CPF_CNPJ').AsString    := Trim(cliente.CPF_CNPJ);
      query.Params.ParamByName('NOME').AsString        := Trim(cliente.NOME);
      query.Params.ParamByName('LOGRADOURO').AsString  := Trim(cliente.LOGRADOURO);
      query.Params.ParamByName('NUMERO').AsString      := Trim(cliente.NUMERO);
      query.Params.ParamByName('COMPLEMENTO').AsString := Trim(cliente.COMPLEMENTO);
      query.Params.ParamByName('BAIRRO').AsString      := Trim(cliente.BAIRRO);
      query.Params.ParamByName('CIDADE').AsInteger     := cliente.CIDADE;
      query.Params.ParamByName('CONTATO').AsString     := Trim(cliente.CONTATO);
      query.Params.ParamByName('fone_fixo').AsString   := Trim(cliente.fone_fixo);
      query.Params.ParamByName('celular').AsString     := Trim(cliente.celular);
      query.Params.ParamByName('referencia').AsString  := Trim(cliente.referencia);

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryClientes.Refresh;
         Except
            frmPrincipal.qryClientes.Close;
            frmPrincipal.qryClientes.Open;
         End;
         if cliente.fidelidade <> 'S' then
            prcMsgInf('Registro inserido com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryClientes.Refresh;
         Except
            frmPrincipal.qryClientes.Close;
            frmPrincipal.qryClientes.Open;
         End;
         prcMsgErro('N�o foi poss�vel gravar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalClientesController.RetornarClientePorCPF(CPF: String): TBaseLocalClientesVO;
Var query: TFDQuery;
    cliente: TBaseLocalClientesVO;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM CLIENTES WHERE CPF_CNPJ = '+QuotedStr(cpf));
      query.open;

      cliente := TBaseLocalClientesVO.Create;

      if Not(query.IsEmpty) then Begin

         cliente.id          := query.FieldByName('id').AsInteger;
         cliente.nome        := Trim(query.FieldByName('nome').AsString);
         cliente.cpf_cnpj    := Trim(query.FieldByName('cpf_cnpj').AsString);
         cliente.logradouro  := Trim(query.FieldByName('logradouro').AsString);
         cliente.numero      := Trim(query.FieldByName('numero').AsString);
         cliente.complemento := Trim(query.FieldByName('complemento').AsString);
         cliente.bairro      := Trim(query.FieldByName('bairro').AsString);
         cliente.referencia  := Trim(query.FieldByName('referencia').AsString);

      End;

      Result := cliente;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalClientesController.RetornarClientePorID(id: integer): TBaseLocalClientesVO;
Var query: TFDQuery;
    cliente: TBaseLocalClientesVO;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM CLIENTES WHERE id = '+id.ToString);
      query.open;

      cliente := TBaseLocalClientesVO.Create;

      if Not(query.IsEmpty) then Begin

         cliente.id          := query.FieldByName('id').AsInteger;
         cliente.nome        := Trim(query.FieldByName('nome').AsString);
         cliente.cpf_cnpj    := Trim(query.FieldByName('cpf_cnpj').AsString);
         cliente.logradouro  := Trim(query.FieldByName('logradouro').AsString);
         cliente.numero      := Trim(query.FieldByName('numero').AsString);
         cliente.complemento := Trim(query.FieldByName('complemento').AsString);
         cliente.bairro      := Trim(query.FieldByName('bairro').AsString);
         cliente.referencia  := Trim(query.FieldByName('referencia').AsString);

      End;

      Result := cliente;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalClientesController.RetornarUFporID(id: integer): String;
Var query: TFDQuery;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' select uf_sigla from cidade where cid_codigo = '+QuotedStr(id.ToString));
      query.open;

      if Not(query.IsEmpty) then
         Result := Trim(query.FieldByName('uf_sigla').AsString);

   Finally

      FreeAndNil(query);

   End;

end;

end.
