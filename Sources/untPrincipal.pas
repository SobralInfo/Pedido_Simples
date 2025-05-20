unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client, untBiblioteca, BaseLocalEmpresaVO, BaseLocalSuprimentoVO,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope, pedidoProdutosVO, BaseLocalSuprimentoController,
  Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,BaseLocalVendaDetalheVO,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, unitConfiguracoes,BaseLocalSangriaVO,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, inifiles, BaseLocalFuncionariosVO,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, BaseLocalClientesVO,
  FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, FireDAC.Comp.DataSet, BaseLocalVendaCabecalhoVO,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, GENERICS.COLLECTIONS,
  Vcl.Imaging.pngimage, JvExExtCtrls, JvSpecialImage, ACBrBase, ACBrPosPrinter, BaseLocalUsuariosController,
  baseLocalPedidoCabecalhoVO, baseLocalPedidoDetalheVO, baseLocalVendaCabecalhoController,
  Vcl.Imaging.jpeg, REST.Types, ACBrDFeReport, ACBrDFeDANFeReport,
  ACBrNFeDANFEClass, ACBrNFeDANFeESCPOS, ACBrSATExtratoClass, untIntegracaoFidelidade,
  ACBrSATExtratoESCPOS, ACBrDANFCeFortesFr, ACBrSATExtratoReportClass,
  ACBrSATExtratoFortesFr, ACBrDANFCeFortesFrA4, ACBrNFeDANFeRLClass;

type
  TfrmPrincipal = class(TForm)
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    StatusBar1: TStatusBar;
    Conexao: TFDConnection;
    qryProdutos: TFDQuery;
    qryProdutosID: TIntegerField;
    qryProdutosSTATUS: TStringField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosQTDE_ESTOQUE: TFloatField;
    qryProdutosREFERENCIA: TStringField;
    qryProdutosID_UNIDADE: TIntegerField;
    qryProdutosCODIGO_BARRAS: TStringField;
    qryProdutosVALOR_UNITARIO: TFloatField;
    dtsClientes: TDataSource;
    qryClientes: TFDQuery;
    qryClientesID: TIntegerField;
    qryClientesSTATUS: TStringField;
    qryClientesCPF_CNPJ: TStringField;
    qryClientesNOME: TStringField;
    qryClientesLOGRADOURO: TStringField;
    qryClientesNUMERO: TStringField;
    qryClientesCOMPLEMENTO: TStringField;
    qryClientesBAIRRO: TStringField;
    qryClientesCIDADE: TIntegerField;
    qryClientesCONTATO: TStringField;
    dtsProdutos: TDataSource;
    qryFuncionarios: TFDQuery;
    qryFuncionariosID: TIntegerField;
    qryFuncionariosSTATUS: TStringField;
    qryFuncionariosCODIGO: TStringField;
    qryFuncionariosNOME: TStringField;
    qryFuncionariosPERCENTUAL_COMISSAO: TFloatField;
    dtsFuncionarios: TDataSource;
    dtsFormaPG: TDataSource;
    qryFormaPG: TFDQuery;
    qryFormaPGID: TIntegerField;
    qryFormaPGSTATUS: TStringField;
    qryFormaPGNOME: TStringField;
    qryFormaPGID_ORIGINAL: TIntegerField;
    qryFormaPGPERMITE_TROCO: TStringField;
    pnlBlend: TPanel;
    RESTClient1: TRESTClient;
    dtsEmpresa: TDataSource;
    qryEmpresa: TFDQuery;
    qryEmpresaID: TIntegerField;
    qryEmpresaCNPJ: TStringField;
    qryEmpresaRAZAO_SOCIAL: TStringField;
    qryEmpresaFANTASIA: TStringField;
    qryEmpresaFONE: TStringField;
    qryEmpresaCELULAR: TStringField;
    qryEmpresaEMAIL: TStringField;
    qryEmpresaSITE: TStringField;
    qryEmpresaBASE_LOCAL: TStringField;
    dtsUsuarios: TDataSource;
    qryUsuarios: TFDQuery;
    qryUsuariosID: TIntegerField;
    qryUsuariosSTATUS: TStringField;
    qryUsuariosCODIGO: TStringField;
    qryUsuariosNOME: TStringField;
    qryUsuariosPW: TStringField;
    qryUsuariosCPF: TStringField;
    qryUsuarioscalcUsuario: TStringField;
    dtsMunicipio: TDataSource;
    qryMunicipio: TFDQuery;
    qryMunicipioID: TIntegerField;
    qryMunicipioCID_CODIGO: TStringField;
    qryMunicipioUF_SIGLA: TStringField;
    qryMunicipioCID_NOME: TStringField;
    qryUnidades: TFDQuery;
    dtsUnidades: TDataSource;
    qryUnidadesID: TIntegerField;
    qryUnidadesSTATUS: TStringField;
    qryUnidadesDESCRICAO: TStringField;
    qryUnidadesSIGLA: TStringField;
    qryUnidadesFATOR: TFloatField;
    qryUnidadesPODE_FRACIONAR: TStringField;
    qryFormaPGcalcStatus: TStringField;
    qryParametros: TFDQuery;
    dtsParametros: TDataSource;
    qryParametrosID: TIntegerField;
    qryParametrosBASE_LOCAL: TStringField;
    qryParametrosCAIXA: TStringField;
    Panel1: TPanel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Panel2: TPanel;
    lblCaption: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image13: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ACBrPosPrinter1: TACBrPosPrinter;
    qryAUX1: TFDQuery;
    qryAUX: TFDQuery;
    qryAUXID: TIntegerField;
    qryAUXID_PRODUTO: TIntegerField;
    qryAUXID_VENDA_CABECALHO: TIntegerField;
    qryAUXGTIN: TStringField;
    qryAUXITEM: TIntegerField;
    qryAUXQUANTIDADE: TFloatField;
    qryAUXVALOR_UNITARIO: TFloatField;
    qryAUXVALOR_TOTAL: TFloatField;
    qryAUXDESCRICAO_PRODUTO: TStringField;
    qryPedidos: TFDQuery;
    dtsPedidos: TDataSource;
    qryPedidosID: TIntegerField;
    qryPedidosSTATUS: TStringField;
    qryPedidosID_CLIENTE: TIntegerField;
    qryPedidosID_FUNCIONARIO: TIntegerField;
    qryPedidosDATA_ABERTURA: TSQLTimeStampField;
    qryPedidosDATA_CONCLUSAO: TSQLTimeStampField;
    qryPedidosOBSERVACAO: TStringField;
    qryPedidosCLIENTE: TStringField;
    qryPedidosFUNCIONARIO: TStringField;
    qryPedidosFONE: TStringField;
    qryProdutosUNIDADE: TStringField;
    qryProdutosFATOR: TFloatField;
    ConexaoLocal: TFDConnection;
    qryParametrosTIPO_DESCONTO_PEDIDO: TStringField;
    qryClientesFONE_FIXO: TStringField;
    qryClientesREFERENCIA: TStringField;
    qryClientesCELULAR: TStringField;
    qryProdutosIMPRIMIR_COZINHA: TStringField;
    qryUsuariosFILTRO_CADASTRO_EMPRESA: TStringField;
    qryUsuariosFILTRO_CADASTRO_USUARIOS: TStringField;
    qryUsuariosFILTRO_CADASTRO_FUNCIONARIOS: TStringField;
    qryUsuariosFILTRO_CADASTRO_CLIENTES: TStringField;
    qryUsuariosFILTRO_CADASTRO_UNIDADES: TStringField;
    qryUsuariosFILTRO_CADASTRO_PRODUTOS: TStringField;
    qryUsuariosFILTRO_CADASTRO_PAGAMENTOS: TStringField;
    qryUsuariosFILTRO_ACESSO_VENDAS: TStringField;
    qryUsuariosFILTRO_ACESSO_EXPORTACOES: TStringField;
    qryUsuariosFILTRO_ACESSO_RELATORIOS: TStringField;
    qryUsuariosFILTRO_ACESSO_CONFIGURACOES: TStringField;
    qryUsuariosFILTRO_ACESSO_PED_ATIVOS: TStringField;
    qryUsuariosFILTRO_ACESSO_PED_CANCELADOS: TStringField;
    qryUsuariosFILTRO_ACESSO_CANC_VENDA: TStringField;
    qryUsuariosFILTRO_ACESSO_CANC_PEDIDO: TStringField;
    qryUsuariosFILTRO_GERAR_PEDIDO: TStringField;
    qryUsuariosFILTRO_ACESSO_FECHAMENTO: TStringField;
    Panel7: TPanel;
    Image12: TImage;
    qryProdutosNCM: TStringField;
    qryProdutosCEST: TStringField;
    qryProdutosTAXA_PIS: TFloatField;
    qryProdutosTAXA_COFINS: TFloatField;
    qryProdutosTAXA_ICMS: TFloatField;
    qryProdutosCST_CSOSN: TStringField;
    qryProdutosCST_PIS: TStringField;
    qryProdutosCST_COFINS: TStringField;
    qryProdutosORIGEM: TIntegerField;
    qryProdutosCFOP: TStringField;
    qryProdutosFISCAL: TStringField;
    qryEmpresaIE: TStringField;
    qryEmpresaCODIGO_CIDADE: TIntegerField;
    qryEmpresaLOGRADOURO: TStringField;
    qryEmpresaNUMERO: TStringField;
    qryEmpresaCOMPLEMENTO: TStringField;
    qryEmpresaBAIRRO: TStringField;
    qryEmpresaCIDADE: TStringField;
    qryEmpresaUF: TStringField;
    qryEmpresaCODIGO_UF: TIntegerField;
    qryEmpresaCEP: TStringField;
    qryEmpresaTIPO_REGIME: TIntegerField;
    qryParametrosCERTIFICADO_DIGITAL: TStringField;
    qryParametrosID_CSC_NFCE: TStringField;
    qryParametrosCSC_NFCE: TStringField;
    qryParametrosNUMERO_NFCE: TIntegerField;
    qryParametrosSERIE_NFCE: TIntegerField;
    qryParametrosFORMA_EMISSAO: TStringField;
    qryParametrosTIPO_AMBIENTE: TStringField;
    qryFormaPGEMITIR_FISCAL: TStringField;
    ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS;
    qryFormaPGTIPO_PG_NFCE: TIntegerField;
    qryFormaPGFIDELIDADE: TStringField;
    ACBrPosPrinter2: TACBrPosPrinter;
    qryAUX2: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure ConexoBancodeDados1Click(Sender: TObject);
    procedure SQLsExportaodeDados1Click(Sender: TObject);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure CadastrodeFuncionrios1Click(Sender: TObject);
    procedure CadastrodeClientes1Click(Sender: TObject);
    procedure CadastrodeFormadePagamento1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure qryUsuariosCalcFields(DataSet: TDataSet);
    procedure qryFormaPGCalcFields(DataSet: TDataSet);
    procedure Image9Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vgbLOGIN: Boolean;
    idEmpresa, idUser: integer;
    valorInformado: double;
    bd: string;
    Log: TextFile;
    padraoImpressao: integer;
    procedure CarregarRest;
    Function RefreshQuery(query: TFDMemTable): TFDMemTable;
    procedure HabilitarTelaAzul;
    procedure DesabilitarTelaAzul;
    procedure Usuarios;
    procedure Clientes;
    procedure Produtos;
    procedure Unidades;
    procedure Vendas;
    procedure Empresa;
    procedure Funcionarios;
    procedure Exportacao;
    procedure Parametros;
    procedure FormasPagamento;
    procedure Relatorios;
    procedure ImprimirVenda(id: integer);
    procedure ImprimirPedido(id: integer);
    procedure ImprimirCancelamentoDeVenda(id: integer);
    procedure ImprimirProdutoCozinhaPedido(id: integer);
    procedure ImprimirProdutoCozinhaVenda(id: integer);
    procedure ImprimirSuprimento(Suprimento: TBaseLocalSuprimentoVO);
    procedure ImprimirSangria(Sangria: TBaseLocalSangriaVO);
    procedure ImprimirFechamento(dtIni, dtFim: tdate; sintetico: Boolean);
    procedure PrepararImpressao(cozinha: boolean);
    procedure RetornarValorEspecie;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses untLogin, untExportacaoDeProdutos, untSQLs, untConexao, baseLocalPedidoDetalheController,
  untExportacaoDeFuncionarios, untExportacaoDeClientes, baseLocalPedidoCabecalhoController,
  untExportacaoDeFormaPagamento, untPedidos, untCadastrarUsuarios,
  untCadastrarProdutos, untCadastrarUnidades, untCadastrarFuncionarios, BaseLocalFuncionariosController,
  untCadastrarClientes, untCadastrarEmpresa, untCadastrarFormaPG, BaseLocalClientesController,
  untExportacoes, untCadastroParametros, BaseLocalEmpresaController,
  untPainelRelatorios, untFechamentoCaixa;

{ TfrmPrincipal }

procedure TfrmPrincipal.CadastrodeClientes1Click(Sender: TObject);
begin

   Application.CreateForm(TfrmExportacaoDeClientes, frmExportacaoDeClientes);
   frmExportacaoDeClientes.ShowModal;

end;

procedure TfrmPrincipal.CadastrodeFormadePagamento1Click(Sender: TObject);
begin

   Application.CreateForm(TfrmExportacaoDeFormaPagamento, frmExportacaoDeFormaPagamento);
   frmExportacaoDeFormaPagamento.ShowModal;

end;

procedure TfrmPrincipal.CadastrodeFuncionrios1Click(Sender: TObject);
begin

  Application.CreateForm(TfrmExportacaoDeFuncionarios, frmExportacaoDeFuncionarios);
  frmExportacaoDeFuncionarios.ShowModal;

end;

procedure TfrmPrincipal.CadastrodeProdutos1Click(Sender: TObject);
begin

   Application.CreateForm(TfrmExportacaoDeProdutos, frmExportacaoDeProdutos);
   frmExportacaoDeProdutos.ShowModal;

end;

procedure TfrmPrincipal.CarregarRest;
begin

   RESTClient1.Disconnect;
   RESTClient1.ResetToDefaults;
   RESTRequest1.ResetToDefaults;
   RESTRequest1.Timeout := 55555;
   RESTResponse1.ResetToDefaults;
   RESTClient1.BaseURL := TBiblioteca.Servidor;

end;

procedure TfrmPrincipal.Clientes;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_clientes') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarClientes, frmCadastrarClientes);
   frmCadastrarClientes.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.ConexoBancodeDados1Click(Sender: TObject);
begin

   Application.CreateForm(TfrmConexao, frmConexao);
   frmConexao.ShowModal;

end;

procedure TfrmPrincipal.DesabilitarTelaAzul;
begin

   StatusBar1.Visible := True;
   //BorderStyle := bsSingle;
   Panel1.Visible := True;
   frmPrincipal.AlphaBlendValue := 255;
   pnlBlend.Visible := False;

end;

procedure TfrmPrincipal.Empresa;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_empresa') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarEmpresa, frmCadastrarEmpresa);
   frmCadastrarEmpresa.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.Exportacao;
begin

   if qryParametrosBASE_LOCAL.AsString = 'S' then Begin
      prcMsgAdv('Opção não disponível na configuração.');
      Exit;
   End;

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_acesso_exportacoes') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmExportacoes, frmExportacoes);
   frmExportacoes.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.FormasPagamento;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_pagamentos') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarFormaPG, frmCadastrarFormaPG);
   frmCadastrarFormaPG.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if Application.MessageBox('Deseja realmente sair do sistema?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
   begin
    Closefile(Log);
    Action := caFree;
    frmPrincipal := Nil;
    Application.Terminate;
   end;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
VAR con : TIniFile;
    server, database : string;
    cli: untIntegracaoFidelidade.TClientes;
Begin
   AssignFile(Log, ExtractFilePath(Application.ExeName)+'Log.txt');
   Try
      Append(Log);
   Except
      Rewrite (Log);
   End;
   Writeln(Log, 'Caixa aberto: '+DateTimeToStr(now));
   {
   frmPrincipal.Height := frmPrincipal.Height - 5;
   frmPrincipal.Width  := frmPrincipal.Width;
   frmPrincipal.Left   := 0;
   frmPrincipal.Top    := 0;  }
   //ShowScrollBar(DBCtrlGrid1.handle, SB_HORZ, False);

  // associa o arquivo de configuração a variável
   con:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'conexao.ini');
  //variável param recebe 12345
   server   := con.readstring('caminho_server','Servidor','');
   database := con.readstring('caminho_server','BD','');

  ConexaoLocal.Close();
  ConexaoLocal.Params.Values['Database'] := database;
  ConexaoLocal.Params.Values['User_Name'] := 'sysdba';
  ConexaoLocal.Params.Values['Server'] := server;
  ConexaoLocal.Params.Values['Password'] := 'masterkey';
  ConexaoLocal.Params.Values['DriverID'] := 'FB';

  Try

    ConexaoLocal.Open();
    Application.Run;

    SetWindowLong(frmPrincipal.Handle,
                  GWL_STYLE,
                  GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
    Height := ClientHeight;

  except
    Application.MessageBox(pchar('Erro na Conexao com o Banco de Dados'),pchar('Aviso Do Sistema'),MB_ICONINFORMATION+MB_OK);
    Application.ProcessMessages;
    Application.Terminate;
    raise;
  End;

   if not vgbLOGIN   then begin
      frmLogin := TfrmLogin.Create(Self);
      frmLogin.ShowModal;
   end;

   if not vgbLOGIN then
      Application.Terminate;

   qryParametros.Close;
   qryParametros.Open;

   qryEmpresa.Close;
   qryEmpresa.Open;

   Try
      untIntegracaoFidelidade.TIntegracaoCoteFacil.Create(self);
   except
   End;

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

   lblCaption.Caption := frmPrincipal.qryEmpresaFANTASIA.AsString;
   padraoImpressao := 1;

end;

procedure TfrmPrincipal.Funcionarios;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_funcionarios') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;
   //teste
   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarFuncionarios, frmCadastrarFuncionarios);
   frmCadastrarFuncionarios.ShowModal;
   DesabilitarTelaAzul;
end;

procedure TfrmPrincipal.HabilitarTelaAzul;
begin

   //StatusBar1.Visible := False;
   Panel1.Visible := False;
   BorderStyle := bsNone;
   frmPrincipal.AlphaBlendValue := 250;
   pnlBlend.Align   := alClient;
   pnlBlend.Visible := True;

end;

procedure TfrmPrincipal.Image10Click(Sender: TObject);
begin

   close;

end;

procedure TfrmPrincipal.Image11Click(Sender: TObject);
begin

   Parametros;

end;

procedure TfrmPrincipal.Image13Click(Sender: TObject);
begin

   Relatorios;

end;

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin

   Empresa;

end;

procedure TfrmPrincipal.Image2Click(Sender: TObject);
begin

   Usuarios;

end;

procedure TfrmPrincipal.Image3Click(Sender: TObject);
begin

   Funcionarios;

end;

procedure TfrmPrincipal.Image4Click(Sender: TObject);
begin

   Clientes;

end;

procedure TfrmPrincipal.Image5Click(Sender: TObject);
begin

   Unidades;

end;

procedure TfrmPrincipal.Image6Click(Sender: TObject);
begin

   Produtos;

end;

procedure TfrmPrincipal.Image7Click(Sender: TObject);
begin

   FormasPagamento;

end;

procedure TfrmPrincipal.Image8Click(Sender: TObject);
begin

   Vendas;

end;

procedure TfrmPrincipal.Image9Click(Sender: TObject);
begin

   Exportacao;

end;

procedure TfrmPrincipal.ImprimirCancelamentoDeVenda(id: integer);
var vias, i: integer;
    dadosVendaCabecalho: TBaseLocalVendaCabecalhoVO;
    empresa: TBaseLocalEmpresaVO;
    RazaoSocial, NomeFantasia: String;

begin

  //Try

   Try

      Try

         empresa := TBaseLocalEmpresaVO.Create;
         empresa := TBaseLocalEmpresaController.retornarDadosEmpresa;

         If empresa.ID > 0 then Begin
            RazaoSocial  := Trim(empresa.RAZAO_SOCIAL);
            NomeFantasia := Trim(empresa.FANTASIA);
         end else Begin
            RazaoSocial  := '';
            NomeFantasia := '';
         end;

         PrepararImpressao(false);
         vias := 1;

         for I := 1 to vias do Begin

            dadosVendaCabecalho := TBaseLocalVendaCabecalhoController.RetornarVendaPorID(id);

            frmPrincipal.ACBrPosPrinter1.Ativar;
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(RazaoSocial)+'</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(NomeFantasia)+'</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>CANCELAMENTO DE VENDA</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');

            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>VENDA No. '+dadosVendaCabecalho.NUMERO_PEDIDO.ToString+'</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>DATA VENDA '+DateToStr(dadosVendaCabecalho.DATA_HORA_VENDA)+'</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>VALOR VENDA '+FormatFloat('###,#0.00',dadosVendaCabecalho.VALOR_FINAL)+'</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');

            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.CortarPapel;

         end;

        frmPrincipal.ACBrPosPrinter1.Desativar;

      Except

         prcMsgAdv('Não foi possível imprimir o cancelamento da venda: '+ID.ToString);
         Exit;
      end;

   Finally

      Try
         FreeAndNil(dadosVendaCabecalho);
         FreeAndNil(empresa);
      Except
      end;
   end;

end;

procedure TfrmPrincipal.ImprimirFechamento(dtIni, dtFim: tdate; sintetico: Boolean);
Var empresa: TBaseLocalEmpresaVO;
    RazaoSocial, NomeFantasia, status: sTRING;
    saldo: double;

function Preenche(Campo, Letra, Alinhamento: String; Tamanho: Integer): String;
var i00 : Integer;
begin
    // Campo = Passar campo a ser preenchido
    // Letra    = Caracter pra ser prenchido
    // Alinhamento = Preencher a esquerda("E") ou direita ("D")

    Campo := Trim(Campo);

     Result := '';
     for i00:=1 to Tamanho - Length(Campo) do Result := Result + Letra;

     if Alinhamento = 'E' then
        Result := Result + Campo
    else
         Result := Campo + Result;
end;

begin

   Try

      saldo := 0.00;

      empresa := TBaseLocalEmpresaVO.Create;
      empresa := TBaseLocalEmpresaController.retornarDadosEmpresa;

      If empresa.ID > 0 then Begin
         RazaoSocial  := Trim(empresa.RAZAO_SOCIAL);
         NomeFantasia := Trim(empresa.FANTASIA);
      end else Begin
         RazaoSocial  := '';
         NomeFantasia := '';
      end;

      qryAUX1.Close;
      qryAUX1.SQL.Clear;
      qryAUX1.SQL.Add(' SELECT fp.nome, ');
      qryAUX1.SQL.Add('        (SUM(tp.valor)-SUM(c.desconto)-SUM(c.troco)) AS valor  ');
      qryAUX1.SQL.Add('   FROM venda_cabecalho c, ');
      qryAUX1.SQL.Add('        total_tipo_pgto tp, ');
      qryAUX1.SQL.Add('        formas_pagamento fp ');
      qryAUX1.SQL.Add('  WHERE c.id = tp.id_venda_cabecalho ');
      qryAUX1.SQL.Add('    and tp.id_forma_pagamento = fp.id ');
      qryAUX1.SQL.Add('    AND c.status = ''F'' ');
      qryAUX1.SQL.Add('    AND c.data_hora_venda BETWEEN :dtIni AND :dtFim ');
      qryAUX1.SQL.Add('GROUP BY fp.nome ');
      qryAUX1.SQL.Add('  UNION  ');
      qryAUX1.SQL.Add(' SELECT ''SUPRIMENTO'' as NOME, ');
      qryAUX1.SQL.Add('        SUM(S.valor) AS valor ');
      qryAUX1.SQL.Add('   FROM suprimento s   ');
      qryAUX1.SQL.Add('  WHERE s.data BETWEEN :dtIni AND :dtFim ');

      qryAUX1.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtIni)+' 00:00:00');
      qryAUX1.Params.ParamByName('dtFim').AsDateTime := StrToDateTime(datetostr(dtFim)+' 23:59:59');

      qryAUX1.Open;

      if Not(qryAUX1.IsEmpty) then Begin

         qryAUX1.First;

         PrepararImpressao(false);

         frmPrincipal.ACBrPosPrinter1.Ativar;
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(RazaoSocial)+'</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(NomeFantasia)+'</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>FECHAMENTO DO CAIXA</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>PERÍODO</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce>'+datetostr(dtIni)+' à '+datetostr(dtFim)+'</ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');

         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>ENTRADAS</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');

      End else Begin
         prcMsgAdv('Nenhum registro localizado no período.');
         Exit;
      end;

      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche('VALOR INFORMADO (ESPECIE)',' ','D',35)+Preenche(FormatFloat('###,#0.00',valorInformado),' ','E',10));

      while not(qryAUX1.Eof) do Begin
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche(Trim(qryAUX1.FieldByName('nome').AsString),' ','D',35)+Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10));
         saldo := saldo + qryAUX1.FieldByName('valor').AsFloat;
         qryAUX1.Next;
      End;


      qryAUX1.Close;
      qryAUX1.SQL.Clear;
      qryAUX1.SQL.Add('        SELECT fp.nome, ');
      qryAUX1.SQL.Add('        (SUM(tp.valor)-SUM(c.desconto)-SUM(c.troco)) AS valor  ');
      qryAUX1.SQL.Add('   FROM venda_cabecalho c, ');
      qryAUX1.SQL.Add('        total_tipo_pgto tp, ');
      qryAUX1.SQL.Add('        formas_pagamento fp ');
      qryAUX1.SQL.Add('  WHERE c.id = tp.id_venda_cabecalho ');
      qryAUX1.SQL.Add('    and tp.id_forma_pagamento = fp.id ');
      qryAUX1.SQL.Add('    AND c.status = ''C'' ');
      qryAUX1.SQL.Add('    AND c.data_hora_venda BETWEEN :dtIni AND :dtFim ');
      qryAUX1.SQL.Add('GROUP BY fp.nome ');
      qryAUX1.SQL.Add('  UNION  ');
      qryAUX1.SQL.Add(' SELECT ''SANGRIA'' as NOME, ');
      qryAUX1.SQL.Add('        SUM(S.valor) AS valor ');
      qryAUX1.SQL.Add('   FROM sangria s   ');
      qryAUX1.SQL.Add('  WHERE s.data BETWEEN :dtIni AND :dtFim ');

      qryAUX1.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtIni)+' 00:00:00');
      qryAUX1.Params.ParamByName('dtFim').AsDateTime := StrToDateTime(datetostr(dtFim)+' 23:59:59');

      qryAUX1.Open;
      qryAUX1.First;

      if Not(qryAUX1.IsEmpty) then Begin
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>SAIDAS</n></ce>');
         frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      End;

      while not(qryAUX1.Eof) do Begin
         if Trim(qryAUX1.FieldByName('nome').AsString) <> 'SANGRIA' then
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche('CANCELAMENTO '+Trim(qryAUX1.FieldByName('nome').AsString),' ','D',35)+
                                                                        Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10))
         else
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche(Trim(qryAUX1.FieldByName('nome').AsString),' ','D',35)+
                                                                        Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10));
         saldo := saldo - qryAUX1.FieldByName('valor').AsFloat;
         qryAUX1.Next;
      End;

      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>                                              --------</n></ce>');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>'+Preenche('SALDO TOTAL',' ','D',35)+
                                                                  Preenche(FormatFloat('###,#0.00',saldo),' ','E',10)+'</n>');

      qryAUX1.Close;
      qryAUX1.SQL.Clear;
      qryAUX1.SQL.Add('   SELECT Distinct(c.id), ');
      qryAUX1.SQL.Add('          c.numero_pedido, ');
      qryAUX1.SQL.Add('          Coalesce(c.id_pedido,0) as id_pedido, ');
      qryAUX1.SQL.Add('          c.valor_final,   ');
      qryAUX1.SQL.Add('          c.status   ');
      qryAUX1.SQL.Add('     FROM venda_cabecalho c  ');
      qryAUX1.SQL.Add('    WHERE c.data_hora_venda BETWEEN :dtIni AND :dtFim ');
      qryAUX1.SQL.Add(' ORDER BY id_pedido, ID ');

      qryAUX1.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtIni)+' 00:00:00');
      qryAUX1.Params.ParamByName('dtFim').AsDateTime := StrToDateTime(datetostr(dtFim)+' 23:59:59');

      qryAUX1.Open;
      qryAUX1.First;

      if sintetico = False then Begin

         if Not(qryAUX1.IsEmpty) then Begin
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>DETALHAMENTO VENDAS</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
            frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
         End;

         while not(qryAUX1.Eof) do Begin

            if Trim(qryAUX1.FieldByName('status').AsString) = 'C' then
               status := 'CANCELADA'
            else
               status := 'FINALIZADA';


            if qryAUX1.FieldByName('id_pedido').AsInteger > 0 then
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+'PEDIDO No. '+Preenche(Trim(qryAUX1.FieldByName('id').AsString),' ','D',9)+
                                                                                      Preenche(status,' ','D',15)+
                                                                                      Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor_final').AsFloat),' ','E',10))
            else
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+'VENDA No. '+Preenche(Trim(qryAUX1.FieldByName('numero_pedido').AsString),' ','D',10)+
                                                                                    Preenche(status,' ','D',15)+
                                                                                    Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor_final').AsFloat),' ','E',10));
            qryAUX1.Next;

         End;

      end;

      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>DATA/HORA:  ['+DateTimeToStr(now)+']'+'</n></ce>');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.CortarPapel;

      frmPrincipal.ACBrPosPrinter1.Desativar;


   Except
      prcMsgAdv('Não foi possível imprimir o Encerramento do Movimento.');
      Exit;
   End;

end;
procedure TfrmPrincipal.ImprimirPedido(id: integer);
var acrescimo, desconto, bruto, liquido, troco: double;
    linha1, complemento, bairro, referencia, obs: string;
    i, y, id_funcionario, id_cliente, vias: integer;
    RazaoSocial,NomeFantasia, cliente, endereco, contato, fones, funcionario: String;
    DadosCliente: TBaseLocalClientesVO;
    DadosFuncionario: TBaseLocalFuncionariosVO;
    dadosVendaCabeca: TBaseLocalPedidoCabecalhoVO;
    dadosVendaDetalhe: TObjectList<TBaseLocalPedidoDetalheVO>;
    empresa: TBaseLocalEmpresaVO;

function Preenche(Campo, Letra, Alinhamento: String; Tamanho: Integer): String;
var i00 : Integer;
begin
    // Campo = Passar campo a ser preenchido
    // Letra    = Caracter pra ser prenchido
    // Alinhamento = Preencher a esquerda("E") ou direita ("D")

    Campo := Trim(Campo);

     Result := '';
     for i00:=1 to Tamanho - Length(Campo) do Result := Result + Letra;

     if Alinhamento = 'E' then
        Result := Result + Campo
    else
         Result := Campo + Result;
end;


begin

  //Try

     Try
      Try
        desconto := 0.00;
        troco    := 0.00;

        empresa := TBaseLocalEmpresaVO.Create;

        empresa := TBaseLocalEmpresaController.retornarDadosEmpresa;


        if empresa.ID > 0 then Begin

           RazaoSocial  := Trim(empresa.RAZAO_SOCIAL);
           NomeFantasia := Trim(empresa.FANTASIA);

        end else Begin

           RazaoSocial  := '';
           NomeFantasia := '';

        end;

        dadosVendaCabeca := TBaseLocalPedidoCabecalhoVO.Create;
        dadosVendaCabeca := TBaseLocalPedidoCabecalhoController.RetornarPedidoPorID(id);

        if dadosVendaCabeca.ID > 0 then Begin

           id_cliente     := dadosVendaCabeca.ID_CLIENTE;
           obs            := '';
           id_funcionario := dadosVendaCabeca.id_funcionario;
           contato        := '';
           troco          := 0.00;//dadosVendaCabeca.TROCO;
           if dadosVendaCabeca.VALOR_DESCONTO < 0 then
              desconto    := (dadosVendaCabeca.VALOR_DESCONTO * -1)
           else if dadosVendaCabeca.VALOR_DESCONTO > 0 then
              acrescimo   := dadosVendaCabeca.VALOR_DESCONTO;

           //if dadosVendaCabeca.taxa_entrega > 0 then
           //   acrescimo   := acrescimo + dadosVendaCabeca.taxa_entrega;

        end else
           Exit;

        DadosCliente := TBaseLocalClientesVO.Create;
        DadosCliente := TBaseLocalClientesController.RetornarClientePorID(id_cliente);

        if Trim(DadosCliente.nome) <> '' then Begin

           complemento := '';
           cliente  := Trim(DadosCliente.nome);

           Endereco := Trim(DadosCliente.logradouro)+', '+
                       Trim(DadosCliente.numero);

        end else Begin

           cliente  := '';
           Endereco := '';

        end;

        DadosFuncionario := TBaseLocalFuncionariosVO.Create;
        DadosFuncionario := TBaseLocalFuncionariosController.RetornarFuncionarioPorID(id_funcionario);

        if Trim(DadosFuncionario.nome) <> '' then
           funcionario := Trim(DadosFuncionario.nome);

        PrepararImpressao(false);
        vias := 1;

        for I := 1 to vias do Begin

           frmPrincipal.ACBrPosPrinter1.Ativar;
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(RazaoSocial)+'</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(NomeFantasia)+'</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Pedido: '+FormatFloat('#0000000000', id)+'</n></ce>');

           if Trim(cliente) <> '' then Begin

              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>Cliente:  '+Preenche(Copy(Trim(cliente),1,27),' ','D',8)+'</ae>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>Endereço: '+Trim(endereco)+'</ae>');

              if DadosCliente.complemento <> '' then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>          '+Trim(DadosCliente.complemento)+'</ae>');

              if DadosCliente.bairro <> '' then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>          '+Trim(DadosCliente.bairro)+'</ae>');

              if DadosCliente.referencia <> '' then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>          '+Trim(DadosCliente.referencia)+'</ae>');

           end;

           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Descricao     Qtde         Preço        Total</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');

           bruto     := 0.00;

           qryAUX1.Close;
           qryAUX1.SQL.Clear;
           qryAUX1.SQL.Add(' SELECT * FROM pedido_detalhe WHERE ID_pedido = '+IntToStr(id));
           qryAUX1.Open;
           qryAUX1.First;

           while Not(qryAUX1.Eof) do Begin

             Try

              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche(Copy(Trim(qryAUX1.FieldByName('descricao').AsString),1,42),' ','D',8)+'</ae>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>              '+Preenche(FormatFloat('#0.000',qryAUX1.FieldByName('QUANTIDADE').AsFloat),' ','D',8)+'x    '+
                                                                           Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('VALOR_UNITARIO').AsFloat),' ','D',8)+'  '+
                                                                           Preenche(FormatFloat('###,#0.00',(qryAUX1.FieldByName('VALOR_TOTAL').AsFloat)),' ','E',8)+'</ae>');

              bruto     := bruto + (qryAUX1.FieldByName('VALOR_TOTAL').AsFloat);
              desconto  := desconto + (qryAUX1.FieldByName('DESCONTO_ITEM').AsFloat);
              acrescimo := acrescimo + 0.00;
              liquido   := liquido + qryAUX1.FieldByName('VALOR_TOTAL').AsFloat;

             Except
                on e:exception do
                   ShowMessage(e.Message);
             end;

              qryAUX1.Next;

           end;

           if desconto <> 0.00 then Begin

              if dadosVendaCabeca.VALOR_DESCONTO > 0 then
                 acrescimo := dadosVendaCabeca.VALOR_DESCONTO
              else if dadosVendaCabeca.VALOR_DESCONTO < 0 then
                 desconto  := dadosVendaCabeca.VALOR_DESCONTO * -1;

           end;



           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
           if desconto >  0 then Begin
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Desconto:                    '+Preenche(FormatFloat('###,#0.00',desconto),' ','E',10)+'</n>');
              if dadosVendaCabeca.taxa_entrega > 0 then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Taxa de Entrega:             '+Preenche(FormatFloat('###,#0.00',dadosVendaCabeca.taxa_entrega ),' ','E',10)+'</n>');
              bruto := bruto - desconto+dadosVendaCabeca.taxa_entrega;
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
           end else if acrescimo >  0 then Begin
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Acréscimo:                   '+Preenche(FormatFloat('###,#0.00',acrescimo),' ','E',10)+'</n>');
              if dadosVendaCabeca.taxa_entrega > 0 then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Taxa de Entrega:             '+Preenche(FormatFloat('###,#0.00',dadosVendaCabeca.taxa_entrega ),' ','E',10)+'</n>');
              bruto := bruto +acrescimo+dadosVendaCabeca.taxa_entrega;
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
           end else Begin
              if dadosVendaCabeca.taxa_entrega > 0 then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Taxa de Entrega:             '+Preenche(FormatFloat('###,#0.00',dadosVendaCabeca.taxa_entrega ),' ','E',10)+'</n>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto+dadosVendaCabeca.taxa_entrega),' ','E',10)+'</n>');
           end;
           {
           qryAUX1.Close;
           qryAUX1.SQL.Clear;
           qryAUX1.SQL.Add(' SELECT fp.nome, ttp.valor FROM total_tipo_pgto ttp, formas_pagamento fp WHERE ttp.id_forma_pagamento = fp.id AND ttp.id_venda_cabecalho = '+IntToStr(id));
           qryAUX1.Open;
           qryAUX1.First;

           while Not(qryAUX1.Eof) do Begin
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>'+Preenche(Copy(Trim(qryAUX1.FieldByName('nome').AsString),1,35),' ','D',35)+Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10)+'</n>');
              qryAUX1.Next;
           end;

           if troco > 0 then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Troco:                             '+Preenche(FormatFloat('###,#0.00',troco),' ','E',10)+'</n>');
           }
           if Trim(obs) <> '' then Begin
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>OBSERVACAO:</n>');
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+obs);
           end;

           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
           if funcionario <> '' then
              frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>VENDEDOR: '+Preenche(funcionario,' ','D',10)+'</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>DATA/HORA:  ['+DateTimeToStr(now)+']'+'</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
           frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
           frmPrincipal.ACBrPosPrinter1.CortarPapel;

        end;

        frmPrincipal.ACBrPosPrinter1.Desativar;

      Except
         prcMsgAdv('Não foi possível imprimir a venda: '+ID.ToString);
         Exit;
      end;

     Finally

       Try
          //FreeAndNil(DadosCliente);
          //FreeAndNil(dadosVendaDetalhe);
          //FreeAndNil(DadosFuncionario);
          //FreeAndNil(empresa);
       Except
       end;
     end;

  //Except

  //   prcMsgAdv('Não foi possível imprimir a venda: '+ID.ToString);

  //end;

end;
procedure TfrmPrincipal.ImprimirProdutoCozinhaPedido(id: integer);
var vias, i: integer;
    dadosVendaDetalhe: TObjectList<TBaseLocalPedidoDetalheVO>;
    empresa: TBaseLocalEmpresaVO;
    impressao, obs: String;

function Preenche(Campo, Letra, Alinhamento: String; Tamanho: Integer): String;
var i00 : Integer;
begin
    // Campo = Passar campo a ser preenchido
    // Letra    = Caracter pra ser prenchido
    // Alinhamento = Preencher a esquerda("E") ou direita ("D")

    Campo := Trim(Campo);

     Result := '';
     for i00:=1 to Tamanho - Length(Campo) do Result := Result + Letra;

     if Alinhamento = 'E' then
        Result := Result + Campo
    else
         Result := Campo + Result;
end;


begin
  qryAUX1.Close;
  qryAUX1.SQL.Clear;
  qryAUX1.SQL.Add('select impresso_cozinha from pedido_cabecalho where id = ' +IntToStr(id));
  qryAUX1.open;

  if qryAUX1.FieldByName('impresso_cozinha').AsString = 'S' then
     Exit;

   Try

      Try

         PrepararImpressao(true);
         vias := 1;

         for I := 1 to vias do Begin

            qryAUX1.Close;
            qryAUX1.SQL.Clear;
            qryAUX1.SQL.Add('   SELECT p.descricao, ');
            qryAUX1.SQL.Add('          u.sigla, ');
            qryAUX1.SQL.Add('          pd.quantidade, ');
            qryAUX1.SQL.Add('          PD.observacao  ');
            qryAUX1.SQL.Add('     FROM pedido_detalhe pd, ');
            qryAUX1.SQL.Add('          produtos p, ');
            qryAUX1.SQL.Add('          unidade_produtos u  ');
            qryAUX1.SQL.Add('    WHERE pd.id_produto = p.id ');
            qryAUX1.SQL.Add('      AND p.id_unidade = u.id  ');
            qryAUX1.SQL.Add('      AND p.imprimir_cozinha = ''S''  ');
            qryAUX1.SQL.Add('      AND ((pd.impresso_cozinha <> ''S'') or (pd.impresso_cozinha IS NULL)) ');
            qryAUX1.SQL.Add('      AND pd.ID_pedido = '+IntToStr(id));
            qryAUX1.SQL.Add(' ORDER BY pd.id_produto ');
            qryAUX1.Open;
            qryAUX1.First;
            {
            if Not(qryAUX1.IsEmpty) then Begin
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Pedido: '+FormatFloat('#0000000000', id)+'</n></ce>');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
            end;
            }

            if Not(qryAUX1.IsEmpty) then Begin

               impressao := impressao + '</zera><ce><n>Data/Hora'+Preenche(DateTimeToStr(Now),' ','E',37)+'</n></ce>'+#13+
                                        '------------------------------------------------'+#13+
                                        '</zera><e><n>PEDIDO: '+Trim(ID.ToString)+'</n></e>'+#13+
                                        '------------------------------------------------'+#13+
                                        ''+#13;

            end;

            while Not(qryAUX1.Eof) do Begin

               if Trim(qryAUX1.FieldByName('OBSERVACAO').AsString) <> '' then
                       obs := '<n>Obs: '+Trim(qryAUX1.FieldByName('OBSERVACAO').AsString)+'</n>'+#13;

               impressao := impressao + '<e><n>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</n></e>'+#13+
                                        obs+
                                        ''+#13+
                                        '<e><n>'+Preenche(FormatFloat('#0.000',qryAUX1.FieldByName('quantidade').AsFloat),' ','E',20)+' '+Trim(qryAUX1.FieldByName('sigla').AsString)+'</n></e>'+#13+
                                        ''+#13+
                                        '------------------------------------------------'+#13+
                                        ''+#13+#13;

              {
               Try

                  frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                  frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</ce>');
                  frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(FormatFloat('#0.000',qryAUX1.FieldByName('QUANTIDADE').AsFloat))+' '+
                                                                            Trim(qryAUX1.FieldByName('SIGLA').AsString)+'</n></ce>');

                  if Trim(qryAUX1.FieldByName('observacao').AsString) <> '' then
                     frmPrincipal.ACBrPosPrinter1.ImprimirLinha('<ce>'+'Obs: '+Trim(qryAUX1.FieldByName('observacao').AsString)+'</ce>');

               Except
                  on e:exception do
                  ShowMessage(e.Message);
               end;
              }
              qryAUX1.Next;

            end;

            if Not(qryAUX1.IsEmpty) then Begin

               frmPrincipal.ACBrPosPrinter1.ImprimirLinha(impressao);
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.CortarPapel;
               TBaseLocalPedidoCabecalhoController.MarcarProdutosCozinha(id);

            end;

         end;

        qryAUX1.Close;
        qryAUX1.SQL.Clear;
        qryAUX1.SQL.Add(' update pedido_cabecalho set impresso_cozinha = ''S'' where id = ' +IntToStr(id));
        qryAUX1.ExecSQL;

        frmPrincipal.ACBrPosPrinter1.Desativar;

      Except
         on e:exception do begin
            prcMsgAdv('Não foi possível imprimir na cozinha: '+ID.ToString+#13+e.Message);
            Exit;
         end;
      end;

   Finally

      Try
         FreeAndNil(dadosVendaDetalhe);
         FreeAndNil(empresa);
      Except
      end;
   end;

end;

procedure TfrmPrincipal.ImprimirProdutoCozinhaVenda(id: integer);
var vias, i, numero_pedido: integer;
    dadosVendaDetalhe: TObjectList<TBaseLocalPedidoDetalheVO>;
    empresa: TBaseLocalEmpresaVO;
    impressao, obs: String;

function Preenche(Campo, Letra, Alinhamento: String; Tamanho: Integer): String;
var i00 : Integer;
begin
    // Campo = Passar campo a ser preenchido
    // Letra    = Caracter pra ser prenchido
    // Alinhamento = Preencher a esquerda("E") ou direita ("D")

    Campo := Trim(Campo);

     Result := '';
     for i00:=1 to Tamanho - Length(Campo) do Result := Result + Letra;

     if Alinhamento = 'E' then
        Result := Result + Campo
    else
         Result := Campo + Result;
end;


begin
   Try

      Try

         PrepararImpressao(true);
         vias := 1;

         numero_pedido := TBaseLocalVendaCabecalhoController.RetornarNumeroPedidoPorIDVenda(id);

         for I := 1 to vias do Begin

            qryAUX1.Close;
            qryAUX1.SQL.Clear;
            qryAUX1.SQL.Add('   SELECT p.descricao, ');
            qryAUX1.SQL.Add('          u.sigla, ');
            qryAUX1.SQL.Add('          pd.quantidade, ');
            qryAUX1.SQL.Add('          PD.observacao  ');
            qryAUX1.SQL.Add('     FROM venda_detalhe pd, ');
            qryAUX1.SQL.Add('          produtos p, ');
            qryAUX1.SQL.Add('          unidade_produtos u  ');
            qryAUX1.SQL.Add('    WHERE pd.id_produto = p.id ');
            qryAUX1.SQL.Add('      AND p.id_unidade = u.id  ');
            qryAUX1.SQL.Add('      AND p.imprimir_cozinha = ''S''  ');
            qryAUX1.SQL.Add('      AND ((pd.impresso_cozinha <> ''S'') or (pd.impresso_cozinha IS NULL)) ');
            qryAUX1.SQL.Add('      AND pd.id_venda_cabecalho = '+IntToStr(id));
            qryAUX1.SQL.Add(' ORDER BY pd.id_produto ');
            qryAUX1.Open;
            qryAUX1.First;
            {
            if Not(qryAUX1.IsEmpty) then Begin
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Pedido: '+FormatFloat('#0000000000', id)+'</n></ce>');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
            end;
            }

            if padraoImpressao = 1 then begin

              if Not(qryAUX1.IsEmpty) then Begin

                 impressao := impressao + '</zera><ce><n>Data/Hora'+Preenche(DateTimeToStr(Now),' ','E',37)+'</n></ce>'+#13+
                                          '------------------------------------------------'+#13+
                                          '</zera><e><n>VENDA: '+Trim(numero_pedido.ToString)+'</n></e>'+#13+
                                          '------------------------------------------------'+#13+
                                          ''+#13;

              end;

              while Not(qryAUX1.Eof) do Begin

                 if Trim(qryAUX1.FieldByName('OBSERVACAO').AsString) <> '' then
                         obs := '<n>Obs: '+Trim(qryAUX1.FieldByName('OBSERVACAO').AsString)+'</n>'+#13;

                 impressao := impressao + '<e><n>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</n></e>'+#13+
                                          obs+
                                          ''+#13+
                                          '<e><n>'+Preenche(FormatFloat('#0.000',qryAUX1.FieldByName('quantidade').AsFloat),' ','E',20)+' '+Trim(qryAUX1.FieldByName('sigla').AsString)+'</n></e>'+#13+
                                          ''+#13+
                                          '------------------------------------------------'+#13+
                                          ''+#13+#13;

                {
                 Try

                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</ce>');
                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(FormatFloat('#0.000',qryAUX1.FieldByName('QUANTIDADE').AsFloat))+' '+
                                                                              Trim(qryAUX1.FieldByName('SIGLA').AsString)+'</n></ce>');

                    if Trim(qryAUX1.FieldByName('observacao').AsString) <> '' then
                       frmPrincipal.ACBrPosPrinter1.ImprimirLinha('<ce>'+'Obs: '+Trim(qryAUX1.FieldByName('observacao').AsString)+'</ce>');

                 Except
                    on e:exception do
                    ShowMessage(e.Message);
                 end;
                }
                qryAUX1.Next;

              end;

            end;

            if padraoImpressao = 2 then begin

              if Not(qryAUX1.IsEmpty) then Begin

                 impressao := impressao + '</zera><ce><n>Data/Hora'+Preenche(DateTimeToStr(Now),' ','E',37)+'</n></ce>'+#13+
                                          '-----------------------------'+#13+
                                          '</zera><e><n>VENDA: '+Trim(numero_pedido.ToString)+'</n></e>'+#13+
                                          '-----------------------------'+#13+
                                          ''+#13;

              end;

              while Not(qryAUX1.Eof) do Begin

                 if Trim(qryAUX1.FieldByName('OBSERVACAO').AsString) <> '' then
                         obs := '<n>Obs: '+Trim(qryAUX1.FieldByName('OBSERVACAO').AsString)+'</n>'+#13;

                 impressao := impressao + '<e><n>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</n></e>'+#13+
                                          obs+
                                          ''+#13+
                                          '<e><n>'+Preenche(FormatFloat('#0.000',qryAUX1.FieldByName('quantidade').AsFloat),' ','E',10)+' '+Trim(qryAUX1.FieldByName('sigla').AsString)+'</n></e>'+#13+
                                          ''+#13+
                                          '-----------------------------'+#13+
                                          ''+#13+#13;

                {
                 Try

                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce>'+Trim(qryAUX1.FieldByName('descricao').AsString)+'</ce>');
                    frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(FormatFloat('#0.000',qryAUX1.FieldByName('QUANTIDADE').AsFloat))+' '+
                                                                              Trim(qryAUX1.FieldByName('SIGLA').AsString)+'</n></ce>');

                    if Trim(qryAUX1.FieldByName('observacao').AsString) <> '' then
                       frmPrincipal.ACBrPosPrinter1.ImprimirLinha('<ce>'+'Obs: '+Trim(qryAUX1.FieldByName('observacao').AsString)+'</ce>');

                 Except
                    on e:exception do
                    ShowMessage(e.Message);
                 end;
                }
                qryAUX1.Next;

              end;

            end;

            if Not(qryAUX1.IsEmpty) then Begin
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha(impressao);
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
               frmPrincipal.ACBrPosPrinter1.CortarPapel;
               TBaseLocalVendaCabecalhoController.MarcarProdutosCozinha(id);
            end;

         end;

        frmPrincipal.ACBrPosPrinter1.Desativar;

      Except

         prcMsgAdv('Não foi possível imprimir na cozinha: '+ID.ToString);
         Exit;
      end;

   Finally

      Try
         FreeAndNil(dadosVendaDetalhe);
         FreeAndNil(empresa);
      Except
      end;
   end;

end;

procedure TfrmPrincipal.ImprimirSangria(Sangria: TBaseLocalSangriaVO);
var
  texto, texto1, texto2  : String;

begin


   Try

      PrepararImpressao(false);

      Texto := '';
      Texto :=  '</zera></ce>' +
                '</linha_simples>'+
                '<n>SANGRIA</n>'#10 +
                '</linha_simples>'+#10+#10;

      Texto1 := 'Data/Hora: '+datetimetostr(Sangria.data)+#10+
                'Valor: '+FormatFloat('###,#0.00',Sangria.valor)+#10;

      if Trim(Sangria.descricao) <> '' Then
         Texto1 := Texto1 + Trim(Sangria.descricao)+#10+#10+#10
      else
         Texto1 := Texto1 +#10+#10;

      Texto2 := '____________________________________'+#10+
                '</zera></ce> Visto'+#10+#10+#10;

      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      ACBrPosPrinter1.ImprimirLinha(Texto+texto1+texto2 );
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      ACBrPosPrinter1.CortarPapel(True);
      frmPrincipal.ACBrPosPrinter1.Desativar;

   Except
      prcMsgAdv('Não foi possível imprimir o suprimento.');
      Exit;
   End;

end;

procedure TfrmPrincipal.ImprimirSuprimento(Suprimento: TBaseLocalSuprimentoVO);
var
  texto, texto1, texto2  : String;

begin


   Try

      PrepararImpressao(false);

      Texto := '';
      Texto :=  '</zera></ce>' +
                '</linha_simples>'+
                '<n>SUPRIMENTO</n>'#10 +
                '</linha_simples>'+#10+#10;

      Texto1 := 'Data/Hora: '+datetimetostr(Suprimento.data)+#10+
                'Valor: '+FormatFloat('###,#0.00',Suprimento.valor)+#10;

      if Trim(Suprimento.descricao) <> '' Then
         Texto1 := Texto1 + Trim(Suprimento.descricao)+#10+#10+#10
      else
         Texto1 := Texto1 +#10+#10;

      Texto2 := '____________________________________'+#10+
                '</zera></ce> Visto'+#10+#10+#10;

      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      ACBrPosPrinter1.ImprimirLinha(Texto+texto1+texto2 );
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
      ACBrPosPrinter1.CortarPapel(True);
      frmPrincipal.ACBrPosPrinter1.Desativar;

   Except
      prcMsgAdv('Não foi possível imprimir o suprimento.');
      Exit;
   End;

end;

procedure TfrmPrincipal.ImprimirVenda(id: integer);
var acrescimo, desconto, bruto, liquido, troco: double;
    linha1, complemento, obs: string;
    i, y, id_funcionario, id_cliente, vias: integer;
    RazaoSocial,NomeFantasia, cliente, endereco, contato, fones, funcionario: String;
    DadosCliente: TBaseLocalClientesVO;
    DadosFuncionario: TBaseLocalFuncionariosVO;
    dadosVendaCabeca: TBaseLocalVendaCabecalhoVO;
    dadosVendaDetalhe: TObjectList<TBaseLocalVendaDetalheVO>;
    empresa: TBaseLocalEmpresaVO;

function Preenche(Campo, Letra, Alinhamento: String; Tamanho: Integer): String;
var i00 : Integer;
begin
    // Campo = Passar campo a ser preenchido
    // Letra    = Caracter pra ser prenchido
    // Alinhamento = Preencher a esquerda("E") ou direita ("D")

    Campo := Trim(Campo);

     Result := '';
     for i00:=1 to Tamanho - Length(Campo) do Result := Result + Letra;

     if Alinhamento = 'E' then
        Result := Result + Campo
    else
         Result := Campo + Result;
end;


begin

  //Try

   Try
      Try
        desconto := 0.00;
        troco    := 0.00;

        empresa := TBaseLocalEmpresaVO.Create;

        empresa := TBaseLocalEmpresaController.retornarDadosEmpresa;


        if empresa.ID > 0 then Begin

           RazaoSocial  := Trim(empresa.RAZAO_SOCIAL);
           NomeFantasia := Trim(empresa.FANTASIA);

        end else Begin

           RazaoSocial  := '';
           NomeFantasia := '';

        end;

        dadosVendaCabeca := TBaseLocalVendaCabecalhoVO.Create;
        dadosVendaCabeca := TBaseLocalVendaCabecalhoController.RetornarVendaPorID(id);

        if dadosVendaCabeca.ID > 0 then Begin

           id_cliente     := dadosVendaCabeca.ID_CLIENTE;
           obs            := '';
           id_funcionario := dadosVendaCabeca.ID_VENDEDOR;
           contato        := '';
           troco          := dadosVendaCabeca.TROCO;
           desconto       := dadosVendaCabeca.DESCONTO;
           acrescimo      := dadosVendaCabeca.ACRESCIMO;

        end else
           Exit;

        DadosCliente := TBaseLocalClientesVO.Create;
        DadosCliente := TBaseLocalClientesController.RetornarClientePorID(id_cliente);

        if Trim(DadosCliente.nome) <> '' then Begin

           complemento := '';
           cliente  := Trim(DadosCliente.nome);
           Endereco := '';

        end else Begin

           cliente  := '';
           Endereco := '';

        end;

        DadosFuncionario := TBaseLocalFuncionariosVO.Create;
        funcionario := '';

        if id_funcionario > 0 then Begin

           DadosFuncionario := TBaseLocalFuncionariosController.RetornarFuncionarioPorID(id_funcionario);

           if Trim(DadosFuncionario.nome) <> '' then
              funcionario := Trim(DadosFuncionario.nome);

        end;

        PrepararImpressao(false);
        vias := 1;

        for I := 1 to vias do Begin

           frmPrincipal.ACBrPosPrinter1.Ativar;

           if padraoImpressao = 1 then begin

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(RazaoSocial)+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(NomeFantasia)+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Venda: '+FormatFloat('#0000000000', dadosVendaCabeca.NUMERO_PEDIDO)+'</n></ce>');

             if Trim(cliente) <> '' then Begin

                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>Cliente: '+Preenche(Copy(Trim(cliente),1,27),' ','D',8)+'</ae>');

             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Descricao     Qtde         Preço        Total</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');

             bruto     := 0.00;

             qryAUX.Close;
             qryAUX.SQL.Clear;
             qryAUX.SQL.Add(' SELECT * FROM venda_detalhe WHERE ID_VENDA_CABECALHO = '+IntToStr(id));
             qryAUX.Open;
             qryAUX.First;

             while Not(qryAUX.Eof) do Begin

               Try

                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche(Copy(Trim(qryAUXDESCRICAO_PRODUTO.AsString),1,38),' ','D',8)+'</ae>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>              '+Preenche(FormatFloat('#0.000',qryAUXQUANTIDADE.AsFloat),' ','D',8)+'x    '+
                                                                             Preenche(FormatFloat('###,#0.00',qryAUXVALOR_UNITARIO.AsFloat),' ','D',8)+'  '+
                                                                             Preenche(FormatFloat('###,#0.00',(qryAUXVALOR_TOTAL.AsFloat)),' ','E',8)+'</ae>');

                bruto     := bruto + (qryAUXVALOR_TOTAL.AsFloat);
                desconto  := desconto + 0.00;
                acrescimo := acrescimo + 0.00;
                liquido   := liquido + qryAUXVALOR_TOTAL.AsFloat;

               Except
                  on e:exception do
                     ShowMessage(e.Message);
               end;

                qryAUX.Next;

             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             if desconto >  0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Desconto:                    '+Preenche(FormatFloat('###,#0.00',desconto),' ','E',10)+'</n>');
                bruto := bruto - desconto;
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
             end else if acrescimo >  0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Acréscimo:                   '+Preenche(FormatFloat('###,#0.00',acrescimo),' ','E',10)+'</n>');
                bruto := bruto +acrescimo;
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
             end else
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:                       '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');

             qryAUX1.Close;
             qryAUX1.SQL.Clear;
             qryAUX1.SQL.Add(' SELECT fp.nome, ttp.valor FROM total_tipo_pgto ttp, formas_pagamento fp WHERE ttp.id_forma_pagamento = fp.id AND ttp.id_venda_cabecalho = '+IntToStr(id));
             qryAUX1.Open;
             qryAUX1.First;

             while Not(qryAUX1.Eof) do Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>'+Preenche(Copy(Trim(qryAUX1.FieldByName('nome').AsString),1,35),' ','D',35)+Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10)+'</n>');
                qryAUX1.Next;
             end;

             if troco > 0 then
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Troco:                             '+Preenche(FormatFloat('###,#0.00',troco),' ','E',10)+'</n>');

             if ((Trim(obs) <> '') or (Trim(frmPedidos.obsFidelidade) <> '')) then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>OBSERVACAO:</n>');
                if Trim(obs) <> '' then
                   frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+obs+#13+frmPedidos.obsFidelidade)
                else
                   frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+frmPedidos.obsFidelidade);
             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             if funcionario <> '' then
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>VENDEDOR: '+Preenche(funcionario,' ','D',10)+'</n></ce>');

             if dadosVendaCabeca.ID_PEDIDO > 0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>PEDIDO No.: '+Preenche(dadosVendaCabeca.ID_PEDIDO.ToString,' ','D',10)+'</n></ce>');
             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>DATA/HORA:  ['+DateTimeToStr(now)+']'+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-------------------------------------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');

           end;


           if padraoImpressao = 2 then begin

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(RazaoSocial)+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>'+Trim(NomeFantasia)+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-----------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Venda: '+FormatFloat('#0000000000', dadosVendaCabeca.NUMERO_PEDIDO)+'</n></ce>');

             if Trim(cliente) <> '' then Begin

                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>Cliente: '+Preenche(Copy(Trim(cliente),1,27),' ','D',8)+'</ae>');

             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-----------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>Descricao  Qtde  Preço  Total</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-----------------------------</n></ce>');

             bruto     := 0.00;

             qryAUX.Close;
             qryAUX.SQL.Clear;
             qryAUX.SQL.Add(' SELECT * FROM venda_detalhe WHERE ID_VENDA_CABECALHO = '+IntToStr(id));
             qryAUX.Open;
             qryAUX.First;

             while Not(qryAUX.Eof) do Begin

               Try

                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+Preenche(Copy(Trim(qryAUXDESCRICAO_PRODUTO.AsString),1,27),' ','D',8)+'</ae>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>     '+Preenche(FormatFloat('#0.000',qryAUXQUANTIDADE.AsFloat),' ','D',6)+'x '+
                                                                             Preenche(FormatFloat('###,#0.00',qryAUXVALOR_UNITARIO.AsFloat),' ','D',6)+'  '+
                                                                             Preenche(FormatFloat('###,#0.00',(qryAUXVALOR_TOTAL.AsFloat)),' ','E',6)+'</ae>');

                bruto     := bruto + (qryAUXVALOR_TOTAL.AsFloat);
                desconto  := desconto + 0.00;
                acrescimo := acrescimo + 0.00;
                liquido   := liquido + qryAUXVALOR_TOTAL.AsFloat;

               Except
                  on e:exception do
                     ShowMessage(e.Message);
               end;

                qryAUX.Next;

             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             if desconto >  0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:     '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Desconto:  '+Preenche(FormatFloat('###,#0.00',desconto),' ','E',10)+'</n>');
                bruto := bruto - desconto;
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:     '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
             end else if acrescimo >  0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Bruto:     '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Acréscimo: '+Preenche(FormatFloat('###,#0.00',acrescimo),' ','E',10)+'</n>');
                bruto := bruto +acrescimo;
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:     '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');
             end else
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Valor Total:     '+Preenche(FormatFloat('###,#0.00',bruto),' ','E',10)+'</n>');

             qryAUX1.Close;
             qryAUX1.SQL.Clear;
             qryAUX1.SQL.Add(' SELECT fp.nome, ttp.valor FROM total_tipo_pgto ttp, formas_pagamento fp WHERE ttp.id_forma_pagamento = fp.id AND ttp.id_venda_cabecalho = '+IntToStr(id));
             qryAUX1.Open;
             qryAUX1.First;

             while Not(qryAUX1.Eof) do Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>'+Preenche(Copy(Trim(qryAUX1.FieldByName('nome').AsString),1,17),' ','D',17)+Preenche(FormatFloat('###,#0.00',qryAUX1.FieldByName('valor').AsFloat),' ','E',10)+'</n>');
                qryAUX1.Next;
             end;

             if troco > 0 then
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>Troco:           '+Preenche(FormatFloat('###,#0.00',troco),' ','E',10)+'</n>');

             if ((Trim(obs) <> '') or (Trim(frmPedidos.obsFidelidade) <> '')) then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae><n>OBSERVACAO:</n>');
                if Trim(obs) <> '' then
                   frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+obs+#13+frmPedidos.obsFidelidade)
                else
                   frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>'+frmPedidos.obsFidelidade);
             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             if funcionario <> '' then
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>VENDEDOR: '+Preenche(funcionario,' ','D',10)+'</n></ce>');

             if dadosVendaCabeca.ID_PEDIDO > 0 then Begin
                frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>PEDIDO No.: '+Preenche(dadosVendaCabeca.ID_PEDIDO.ToString,' ','D',10)+'</n></ce>');
             end;

             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ae>DATA: ['+DateTimeToStr(now)+']'+'</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('</zera><ce><n>-----------------------------</n></ce>');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');
             frmPrincipal.ACBrPosPrinter1.ImprimirLinha('');

           end;

           frmPrincipal.ACBrPosPrinter1.CortarPapel;

        end;

        frmPrincipal.ACBrPosPrinter1.Desativar;

      Except
         on e:exception do Begin
            prcMsgAdv('Não foi possível imprimir a venda: '+ID.ToString+#13+'Erro: '+e.Message);
            Exit;
         end;
      end;

   Finally

      Try
          FreeAndNil(DadosCliente);
          FreeAndNil(dadosVendaCabeca);
          //if Assigned(DadosFuncionario) then
          FreeAndNil(DadosFuncionario);
          FreeAndNil(empresa);
       Except
       end;

   end;

  //Except

  //   prcMsgAdv('Não foi possível imprimir a venda: '+ID.ToString);

  //end;

end;

procedure TfrmPrincipal.Label10Click(Sender: TObject);
begin

   Exportacao;

end;

procedure TfrmPrincipal.Label12Click(Sender: TObject);
begin

   Parametros;

end;

procedure TfrmPrincipal.Label1Click(Sender: TObject);
begin

   Empresa;

end;

procedure TfrmPrincipal.Label2Click(Sender: TObject);
begin

   Usuarios;

end;

procedure TfrmPrincipal.Label3Click(Sender: TObject);
begin

   Funcionarios;

end;

procedure TfrmPrincipal.Label5Click(Sender: TObject);
begin

   Clientes;

end;

procedure TfrmPrincipal.Label6Click(Sender: TObject);
begin

   Unidades;

end;

procedure TfrmPrincipal.Label7Click(Sender: TObject);
begin

   produtos;

end;

procedure TfrmPrincipal.Label8Click(Sender: TObject);
begin

   FormasPagamento;

end;

procedure TfrmPrincipal.Label9Click(Sender: TObject);
begin

   Vendas;

end;

procedure TfrmPrincipal.Parametros;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_acesso_configuracoes') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastroParametros, frmCadastroParametros);
   frmCadastroParametros.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.PrepararImpressao(cozinha: boolean);
Var porta, modelo, linha: String;
    f : TextFile;

begin


  Try

   porta  := '';
   modelo := '';

   if cozinha then
      AssignFile(f, ExtractFilePath(Application.ExeName)+'\impressoraLocalCozinha.txt')
   else
      AssignFile(f, ExtractFilePath(Application.ExeName)+'\impressoraLocal.txt');

   Reset(f); //abre o arquivo para leitura;

   While not eof(f) do begin
     Readln(f,linha); //le do arquivo e desce uma linha. O conteúdo lido é transferido para a variável linha

     if modelo = '' then
         modelo := linha
     else
         porta := Copy(Trim(linha),3,25);

   End;

   Closefile(f);

  Except
  End;

  Try

     ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo( StrToInt(modelo) );
     ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo( 0 );
     ACBrPosPrinter1.Porta := porta;
     ACBrPosPrinter1.ColunasFonteNormal := 48;
     ACBrPosPrinter1.LinhasEntreCupons  := 3;
     ACBrPosPrinter1.LinhasBuffer       := 0;
     ACBrPosPrinter1.EspacoEntreLinhas  := 0;
     ACBrPosPrinter1.ArqLOG := '';
     ACBrPosPrinter1.LinhasBuffer := 0;
     ACBrPosPrinter1.ControlePorta := false;
     ACBrPosPrinter1.CortaPapel := True;
     ACBrPosPrinter1.TraduzirTags := True;
     ACBrPosPrinter1.IgnorarTags := False;
     ACBrPosPrinter1.ConfigBarras.MostrarCodigo := False;
     ACBrPosPrinter1.ConfigBarras.LarguraLinha := 0;
     ACBrPosPrinter1.ConfigBarras.Altura := 0;
     ACBrPosPrinter1.ConfigQRCode.ErrorLevel := 0;
     ACBrPosPrinter1.ConfigLogo.KeyCode1 := 0;
     ACBrPosPrinter1.ConfigLogo.KeyCode2 := 0;
     ACBrPosPrinter1.ConfigLogo.FatorX := 0;
     ACBrPosPrinter1.ConfigLogo.FatorY := 0;
     ACBrSATExtratoESCPOS1.ImprimeQRCode := True;
     ACBrSATExtratoESCPOS1.ImprimeEmUmaLinha := false;
     ACBrSATExtratoESCPOS1.MostraPreview := True;

     Try
        ACBrPosPrinter1.Inicializar;
        ACBrPosPrinter1.Ativar;
     Except
        on e:Exception do
           prcMsgErro('Erro na impressora: '+e.Message);
     End;

  Finally

  End;

end;

procedure TfrmPrincipal.Produtos;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_produtos') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarProdutos, frmCadastrarProdutos);
   frmCadastrarProdutos.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.qryFormaPGCalcFields(DataSet: TDataSet);
begin

   if qryFormaPGSTATUS.AsString = 'A' then
      qryFormaPGcalcStatus.AsString := 'ATIVO'
   else
      qryFormaPGcalcStatus.AsString := 'INATIVO';

end;

procedure TfrmPrincipal.qryUsuariosCalcFields(DataSet: TDataSet);
begin

   if qryUsuariosSTATUS.AsString = 'A' then
      qryUsuarioscalcUsuario.AsString := 'ATIVO'
   else
      qryUsuarioscalcUsuario.AsString := 'INATIVO';

end;

function TfrmPrincipal.RefreshQuery(query: TFDMemTable): TFDMemTable;
begin

   query.Active := False;
   query.Open;
   query.EmptyDataSet;
   query.Close;
   query.Open;
   query.Append;
   query.Post;
   query.Open;
   query.Active := True;

   REsult := query;

end;

procedure TfrmPrincipal.Relatorios;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_acesso_relatorios') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   Application.CreateForm(TfrmPainelRelatorios, frmPainelRelatorios);
   frmPainelRelatorios.ShowModal;

end;

procedure TfrmPrincipal.RetornarValorEspecie;
Var query: TFDQuery;
begin

   Try

      frmFechamentoCaixa.edtEspecie.Enabled := True;
      frmFechamentoCaixa.edtEspecie.AsFloat := 0.00;
      valorInformado := 0.00;

      query := TFDQuery.Create(Nil);
      query.Connection := frmPrincipal.ConexaoLocal;

      query.SQL.Add(' SELECT Coalesce(valor,0.00) valor FROM fechamento WHERE data = :data ');
      query.Params.ParamByName('data').AsDateTime := frmFechamentoCaixa.dtIni.Date;
      query.Open;

      if Not(query.IsEmpty) then Begin
         frmFechamentoCaixa.edtEspecie.AsFloat := query.FieldByName('valor').AsFloat;
         frmFechamentoCaixa.edtEspecie.Enabled := False;
         valorInformado := query.FieldByName('valor').AsFloat;
      End;


   Finally

      FreeAndNil(query);

   End;

end;

procedure TfrmPrincipal.SQLsExportaodeDados1Click(Sender: TObject);
begin

   HabilitarTelaAzul;
   Application.CreateForm(TfrmSQLs, frmSQLs);
   frmSQLs.showmodal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.Unidades;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_unidades') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarUnidades, frmCadastrarUnidades);
   frmCadastrarUnidades.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.Usuarios;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_cadastro_usuarios') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   HabilitarTelaAzul;
   Application.CreateForm(TfrmCadastrarUsuarios, frmCadastrarUsuarios);
   frmCadastrarUsuarios.ShowModal;
   DesabilitarTelaAzul;

end;

procedure TfrmPrincipal.Vendas;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(idUser, 'filtro_acesso_vendas') = false then Begin
      prcMsgAdv('Usuário sem permissão de acesso a função.');
      Exit;
   End;

   Application.CreateForm(TfrmPedidos, frmPedidos);
   frmPedidos.lblUserLogado.Caption := FormataNome(Trim(Copy(Trim(StatusBar1.Panels[0].Text),19,20)));
   frmPedidos.lblCaixa.Caption      := 'CAIXA '+Trim(qryParametrosCAIXA.AsString);
   frmPedidos.ShowModal;

end;

end.
