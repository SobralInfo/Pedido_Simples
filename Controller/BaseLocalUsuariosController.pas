unit BaseLocalUsuariosController;

interface

uses generics.Collections, system.sysutils,  system.JSON, rest.json, rest.types,
     unitConfiguracoes, BaseLocalUsuariosVO, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client;

Type TBaseLocalUsuariosController = class

   public
      Class Function ValidarUsuario(user: TBaseLocalUsuariosVO): TBaseLocalUsuariosVO;
      class Procedure GravarUsuario(user: TBaseLocalUsuariosVO);
      class Procedure AlterarUsuario(user: TBaseLocalUsuariosVO);
      class Function VerificarSeUsuarioExiste(cpf: string): Boolean;
      class Function VerificarPermissao(idUser: integer; campo: String): Boolean;

end;

implementation

uses untPrincipal;

{ TBaseLocalUsuariosController }

class procedure TBaseLocalUsuariosController.AlterarUsuario(user: TBaseLocalUsuariosVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' UPDATE usuarios SET status = :status, ');
      query.SQL.Add('                     codigo = :codigo, ');
      query.SQL.Add('                     nome = :nome, ');
      query.SQL.Add('                     pw = :pw, ');
      query.SQL.Add('                     cpf = :cpf, ');
      query.SQL.Add('                     filtro_cadastro_empresa = :filtro_cadastro_empresa, ');
      query.SQL.Add('                     filtro_cadastro_usuarios = :filtro_cadastro_usuarios, ');
      query.SQL.Add('                     filtro_cadastro_funcionarios = :filtro_cadastro_funcionarios, ');
      query.SQL.Add('                     filtro_cadastro_clientes = :filtro_cadastro_clientes, ');
      query.SQL.Add('                     filtro_cadastro_unidades = :filtro_cadastro_unidades, ');
      query.SQL.Add('                     filtro_cadastro_produtos = :filtro_cadastro_produtos, ');
      query.SQL.Add('                     filtro_cadastro_pagamentos = :filtro_cadastro_pagamentos, ');
      query.SQL.Add('                     filtro_acesso_vendas = :filtro_acesso_vendas, ');
      query.SQL.Add('                     filtro_acesso_exportacoes = :filtro_acesso_exportacoes, ');
      query.SQL.Add('                     filtro_acesso_relatorios = :filtro_acesso_relatorios, ');
      query.SQL.Add('                     filtro_acesso_configuracoes = :filtro_acesso_configuracoes, ');
      query.SQL.Add('                     filtro_acesso_ped_ativos = :filtro_acesso_ped_ativos, ');
      query.SQL.Add('                     filtro_acesso_ped_cancelados = :filtro_acesso_ped_cancelados, ');
      query.SQL.Add('                     filtro_acesso_canc_venda = :filtro_acesso_canc_venda, ');
      query.SQL.Add('                     filtro_acesso_canc_pedido = :filtro_acesso_canc_pedido, ');
      query.SQL.Add('                     filtro_acesso_fechamento = :filtro_acesso_fechamento, ');
      query.SQL.Add('                     filtro_gerar_pedido = :filtro_gerar_pedido ');
      query.SQL.Add('  WHERE id = :id ');

      query.Params.ParamByName('status').AsString                       := Trim(user.STATUS);
      query.Params.ParamByName('codigo').AsString                       := Trim(user.CODIGO);
      query.Params.ParamByName('nome').AsString                         := Trim(user.NOME);
      query.Params.ParamByName('pw').AsString                           := Criptografa(Trim(user.PW),50);
      query.Params.ParamByName('cpf').AsString                          := Trim(user.cpf);
      query.Params.ParamByName('id').AsInteger                          := user.ID;
      query.Params.ParamByName('filtro_cadastro_empresa').AsString      := user.filtro_cadastro_empresa;
      query.Params.ParamByName('filtro_cadastro_usuarios').AsString     := user.filtro_cadastro_usuarios;
      query.Params.ParamByName('filtro_cadastro_funcionarios').AsString := user.filtro_cadastro_funcionarios;
      query.Params.ParamByName('filtro_cadastro_clientes').AsString     := user.filtro_cadastro_clientes;
      query.Params.ParamByName('filtro_cadastro_unidades').AsString     := user.filtro_cadastro_unidades;
      query.Params.ParamByName('filtro_cadastro_produtos').AsString     := user.filtro_cadastro_produtos;
      query.Params.ParamByName('filtro_cadastro_pagamentos').AsString   := user.filtro_cadastro_pagamentos;
      query.Params.ParamByName('filtro_acesso_vendas').AsString         := user.filtro_acesso_vendas;
      query.Params.ParamByName('filtro_acesso_exportacoes').AsString    := user.filtro_acesso_exportacoes;
      query.Params.ParamByName('filtro_acesso_relatorios').AsString     := user.filtro_acesso_relatorios;
      query.Params.ParamByName('filtro_acesso_configuracoes').AsString  := user.filtro_acesso_configuracoes;
      query.Params.ParamByName('filtro_acesso_ped_ativos').AsString     := user.filtro_acesso_ped_ativos;
      query.Params.ParamByName('filtro_acesso_ped_cancelados').AsString := user.filtro_acesso_ped_cancelados;
      query.Params.ParamByName('filtro_acesso_canc_venda').AsString     := user.filtro_acesso_canc_venda;
      query.Params.ParamByName('filtro_acesso_canc_pedido').AsString    := user.filtro_acesso_canc_pedido;
      query.Params.ParamByName('filtro_acesso_fechamento').AsString     := user.filtro_acesso_fechamento;
      query.Params.ParamByName('filtro_gerar_pedido').AsString          := user.filtro_gerar_pedido;

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryUsuarios.Refresh;
         Except
            frmPrincipal.qryUsuarios.Close;
            frmPrincipal.qryUsuarios.Open;
         End;
         prcMsgInf('Registro alterado com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryUsuarios.Refresh;
         Except
            frmPrincipal.qryUsuarios.Close;
            frmPrincipal.qryUsuarios.Open;
         End;
         prcMsgErro('N�o foi poss�vel alterar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class procedure TBaseLocalUsuariosController.GravarUsuario(user: TBaseLocalUsuariosVO);
var query: TFDQuery;
begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' INSERT INTO usuarios ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' status, codigo, nome, pw, cpf, filtro_cadastro_empresa, filtro_cadastro_usuarios, ');
      query.SQL.Add(' filtro_cadastro_funcionarios, filtro_cadastro_clientes, filtro_cadastro_unidades, ');
      query.SQL.Add(' filtro_cadastro_produtos, filtro_cadastro_pagamentos, filtro_acesso_vendas, ');
      query.SQL.Add(' filtro_acesso_exportacoes, filtro_acesso_relatorios, filtro_acesso_configuracoes, ');
      query.SQL.Add(' filtro_acesso_ped_ativos, filtro_acesso_ped_cancelados, filtro_acesso_canc_venda, ');
      query.SQL.Add(' filtro_acesso_canc_pedido, filtro_acesso_fechamento, filtro_gerar_pedido  ');
      query.SQL.Add(' )   ');
      query.SQL.Add(' VALUES   ');
      query.SQL.Add(' (  ');
      query.SQL.Add(' :status, :codigo, :nome, :pw, :cpf, :filtro_cadastro_empresa, :filtro_cadastro_usuarios, ');
      query.SQL.Add(' :filtro_cadastro_funcionarios, :filtro_cadastro_clientes, :filtro_cadastro_unidades, ');
      query.SQL.Add(' :filtro_cadastro_produtos, :filtro_cadastro_pagamentos, :filtro_acesso_vendas, ');
      query.SQL.Add(' :filtro_acesso_exportacoes, :filtro_acesso_relatorios, :filtro_acesso_configuracoes, ');
      query.SQL.Add(' :filtro_acesso_ped_ativos, :filtro_acesso_ped_cancelados, :filtro_acesso_canc_venda, ');
      query.SQL.Add(' :filtro_acesso_canc_pedido, :filtro_acesso_fechamento, :filtro_gerar_pedido  ');
      query.SQL.Add(' ) ');

      query.Params.ParamByName('status').AsString := Trim(user.STATUS);
      query.Params.ParamByName('codigo').AsString := Trim(user.CODIGO);
      query.Params.ParamByName('nome').AsString   := Trim(user.NOME);
      query.Params.ParamByName('pw').AsString     := Criptografa(Trim(user.PW),50);
      query.Params.ParamByName('cpf').AsString    := Trim(user.cpf);
      query.Params.ParamByName('filtro_cadastro_empresa').AsString      := user.filtro_cadastro_empresa;
      query.Params.ParamByName('filtro_cadastro_usuarios').AsString     := user.filtro_cadastro_usuarios;
      query.Params.ParamByName('filtro_cadastro_funcionarios').AsString := user.filtro_cadastro_funcionarios;
      query.Params.ParamByName('filtro_cadastro_clientes').AsString     := user.filtro_cadastro_clientes;
      query.Params.ParamByName('filtro_cadastro_unidades').AsString     := user.filtro_cadastro_unidades;
      query.Params.ParamByName('filtro_cadastro_produtos').AsString     := user.filtro_cadastro_produtos;
      query.Params.ParamByName('filtro_cadastro_pagamentos').AsString   := user.filtro_cadastro_pagamentos;
      query.Params.ParamByName('filtro_acesso_vendas').AsString         := user.filtro_acesso_vendas;
      query.Params.ParamByName('filtro_acesso_exportacoes').AsString    := user.filtro_acesso_exportacoes;
      query.Params.ParamByName('filtro_acesso_relatorios').AsString     := user.filtro_acesso_relatorios;
      query.Params.ParamByName('filtro_acesso_configuracoes').AsString  := user.filtro_acesso_configuracoes;
      query.Params.ParamByName('filtro_acesso_ped_ativos').AsString     := user.filtro_acesso_ped_ativos;
      query.Params.ParamByName('filtro_acesso_ped_cancelados').AsString := user.filtro_acesso_ped_cancelados;
      query.Params.ParamByName('filtro_acesso_canc_venda').AsString     := user.filtro_acesso_canc_venda;
      query.Params.ParamByName('filtro_acesso_canc_pedido').AsString    := user.filtro_acesso_canc_pedido;
      query.Params.ParamByName('filtro_acesso_fechamento').AsString     := user.filtro_acesso_fechamento;
      query.Params.ParamByName('filtro_gerar_pedido').AsString          := user.filtro_gerar_pedido;

      Try
         query.ExecSQL;
         frmPrincipal.ConexaoLocal.Commit;
         Try
            frmPrincipal.qryUsuarios.Refresh;
         Except
            frmPrincipal.qryUsuarios.Close;
            frmPrincipal.qryUsuarios.Open;
         End;
         prcMsgInf('Registro inserido com sucesso.');
      Except
         frmPrincipal.ConexaoLocal.Rollback;
         Try
            frmPrincipal.qryUsuarios.Refresh;
         Except
            frmPrincipal.qryUsuarios.Close;
            frmPrincipal.qryUsuarios.Open;
         End;
         prcMsgErro('N�o foi poss�vel gravar o registro.');
      End;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalUsuariosController.ValidarUsuario(user: TBaseLocalUsuariosVO): TBaseLocalUsuariosVO;
Var query: TFDQuery;

Begin

   Try

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM usuarios WHERE ((cpf = :cpf) AND (pw = :pw)) ');
      query.Params.ParamByName('cpf').AsString := Trim(user.cpf);
      query.Params.ParamByName('pw').AsString  := Criptografa(Trim(user.PW),50);
      query.open;

      user := TBaseLocalUsuariosVO.Create;

      if Not(query.IsEmpty) then Begin

         user.ID                           := query.FieldByName('id').AsInteger;
         user.NOME                         := query.FieldByName('nome').AsString;
         user.STATUS                       := query.FieldByName('status').AsString;
         user.filtro_cadastro_usuarios     := query.FieldByName('filtro_cadastro_empresa').AsString;
         user.filtro_cadastro_usuarios     := query.FieldByName('filtro_cadastro_usuarios').AsString;
         user.filtro_cadastro_funcionarios := query.FieldByName('filtro_cadastro_funcionarios').AsString;
         user.filtro_cadastro_clientes     := query.FieldByName('filtro_cadastro_clientes').AsString;
         user.filtro_cadastro_unidades     := query.FieldByName('filtro_cadastro_unidades').AsString;
         user.filtro_cadastro_produtos     := query.FieldByName('filtro_cadastro_produtos').AsString;
         user.filtro_cadastro_pagamentos   := query.FieldByName('filtro_cadastro_pagamentos').AsString;
         user.filtro_acesso_vendas         := query.FieldByName('filtro_acesso_vendas').AsString;
         user.filtro_acesso_exportacoes    := query.FieldByName('filtro_acesso_exportacoes').AsString;
         user.filtro_acesso_relatorios     := query.FieldByName('filtro_acesso_relatorios').AsString;
         user.filtro_acesso_configuracoes  := query.FieldByName('filtro_acesso_configuracoes').AsString;
         user.filtro_acesso_ped_ativos     := query.FieldByName('filtro_acesso_ped_ativos').AsString;
         user.filtro_acesso_ped_cancelados := query.FieldByName('filtro_acesso_ped_cancelados').AsString;
         user.filtro_acesso_canc_venda     := query.FieldByName('filtro_acesso_canc_venda').AsString;
         user.filtro_acesso_canc_pedido    := query.FieldByName('filtro_acesso_canc_pedido').AsString;
         user.filtro_acesso_fechamento     := query.FieldByName('filtro_acesso_fechamento').AsString;
         user.filtro_gerar_pedido          := query.FieldByName('filtro_gerar_pedido').AsString;


      End;

      Result := user;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalUsuariosController.VerificarPermissao(idUser: integer;campo: String): Boolean;
Var query: TFDQuery;

Begin

   Try

      Result := False;

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT '+campo+' FROM usuarios WHERE id = :id ');
      query.Params.ParamByName('id').AsInteger := idUser;
      query.open;

      if Trim(query.FieldByName(campo).AsString) = 'S' then
         Result := True;

   Finally

      FreeAndNil(query);

   End;

end;

class function TBaseLocalUsuariosController.VerificarSeUsuarioExiste(cpf: string): Boolean;
Var query: TFDQuery;

Begin

   Try

      Result := False;

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.Close;
      query.SQL.Add(' SELECT * FROM usuarios WHERE cpf = :cpf ');
      query.Params.ParamByName('cpf').AsString := Trim(cpf);
      query.open;

      if Not(query.IsEmpty) then
         Result := True;

   Finally

      FreeAndNil(query);

   End;

end;

end.
