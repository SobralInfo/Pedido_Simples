unit untPesquisarClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask, unitConfiguracoes,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, JvExDBGrids, JvDBGrid, untBiblioteca,
  Vcl.Imaging.pngimage, BaseLocalClientesController, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, untPrincipal,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPesquisarClientes = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    lblTotal: TLabel;
    mkeDescricao: TMaskEdit;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Panel3: TPanel;
    Label2: TLabel;
    Panel4: TPanel;
    JvDBGrid1: TJvDBGrid;
    imgNovo: TImage;
    qryNCM: TFDQuery;
    dtsNCM: TDataSource;
    qryNCMNCM: TStringField;
    qryNCMDESCRICAO: TStringField;
    qryNCMSITUACAO: TStringField;
    qryNCMCEST: TStringField;
    qryNCMDESCRICAO_CEST: TStringField;
    qryNCMPERC_IMP_FEDERAL: TFloatField;
    qryNCMPERC_IMP_ESTADUAL: TFloatField;
    qryNCMPERC_IMP_MUNICIPAL: TFloatField;
    procedure mkeDescricaoChange(Sender: TObject);
    procedure mkeDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure JvDBGrid1DblClick(Sender: TObject);
    procedure JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Image4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure speNovoClick(Sender: TObject);
    procedure imgNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Var origem: string;
    procedure Filtrar;
    procedure Confirmar;
    procedure NovoCliente;
  end;

var
  frmPesquisarClientes: TfrmPesquisarClientes;

implementation

{$R *.dfm}

uses untPedidos, untCadastrarClientes, untTelaDePedido;

procedure TfrmPesquisarClientes.Confirmar;
begin

   if frmPrincipal.qryClientes.IsEmpty then Begin

      prcMsgAdv('Selecione um registro.');
      Exit;

   End;

   if origem = 'CADASTRO_CLIENTES' then Begin

      frmCadastrarClientes.HabilitarDesabilitarBotoes('E');
      frmCadastrarClientes.HabilitarDesabilitarCampos('H');
      frmCadastrarClientes.LimparCampos;
      frmCadastrarClientes.DAO := 'U';

      if frmPrincipal.qryClientesSTATUS.AsString = 'A' then
         frmCadastrarClientes.cbbStatus.ItemIndex := 0
      else
         frmCadastrarClientes.cbbStatus.ItemIndex := 1;

      if Length(frmPrincipal.qryClientesCPF_CNPJ.AsString) > 11 then
         frmCadastrarClientes.rdbCNPJ.Checked  := True
      else
         frmCadastrarClientes.rdbCPF.Checked := True;

      frmCadastrarClientes.edtCPF_CNPJ.Text        := Trim(frmPrincipal.qryClientesCPF_CNPJ.AsString);
      frmCadastrarClientes.edtNome.Text            := Trim(frmPrincipal.qryClientesNOME.AsString);
      frmCadastrarClientes.edtContato.Text         := Trim(frmPrincipal.qryClientesCONTATO.AsString);
      frmCadastrarClientes.edtLogradouro.Text      := Trim(frmPrincipal.qryClientesLOGRADOURO.AsString);
      frmCadastrarClientes.edtNumero.Text          := Trim(frmPrincipal.qryClientesNUMERO.AsString);
      frmCadastrarClientes.edtComplemento.Text     := Trim(frmPrincipal.qryClientesCOMPLEMENTO.AsString);
      frmCadastrarClientes.edtBairro.Text          := Trim(frmPrincipal.qryClientesBAIRRO.AsString);
      frmCadastrarClientes.idCliente               := frmPrincipal.qryClientesID.AsInteger;
      frmCadastrarClientes.edtCelular.Text         := Trim(frmPrincipal.qryClientesCELULAR.AsString);
      frmCadastrarClientes.edtFoneFixo.Text        := Trim(frmPrincipal.qryClientesFONE_FIXO.AsString);
      frmCadastrarClientes.edtReferencia.Text      := Trim(frmPrincipal.qryClientesREFERENCIA.AsString);

      frmCadastrarClientes.lkpUF.ItemIndex         := -1;
      frmCadastrarClientes.lkpUF.ItemIndex         := TBiblioteca.RetornarIDporUF(TBaseLocalClientesController.RetornarUFporID(frmPrincipal.qryClientesCIDADE.AsInteger));
      frmCadastrarClientes.FiltrarMunicipio;
      frmCadastrarClientes.lkpMunicipio.KeyValue   := frmPrincipal.qryClientesCIDADE.AsInteger;


   End else if origem = 'PEDIDO' then Begin

      frmTelaDePedido.edtCodCliente.Text := frmPrincipal.qryClientesID.AsString;
      frmTelaDePedido.idCliente          := frmPrincipal.qryClientesID.AsInteger;

   end else Begin

      frmPedidos.idCliente                 := frmPrincipal.qryClientesID.AsInteger;
      frmPedidos.lblNomeCliente.Caption    := Trim(FormataNome(frmPrincipal.qryClientesNOME.AsString));
      frmPedidos.lblCPFCNPJCliente.Caption := TBiblioteca.mascaraCPFCNPJ(Trim(frmPrincipal.qryClientesCPF_CNPJ.AsString));

      frmPedidos.lblCliente.Visible        := True;
      frmPedidos.lblCPFCNPJ.Visible        := True;
      frmPedidos.lblNomeCliente.Visible    := True;
      frmPedidos.lblCPFCNPJCliente.Visible := True;

   End;

   close;

end;

procedure TfrmPesquisarClientes.Filtrar;
begin

   frmPrincipal.qryClientes.Filtered := False;

   if origem = 'CADASTRO_CLIENTES' then
      frmPrincipal.qryClientes.Filter := ' ((celular like '+QuotedStr('%'+Trim(Copy(mkeDescricao.Text,1,11))+'%')+
                                                ') or (fone_fixo like '+QuotedStr('%'+Trim(Copy(mkeDescricao.Text,1,10))+'%')+
                                                ') or (cpf_cnpj like '+QuotedStr(Trim(Copy(mkeDescricao.Text,1,14))+'%')+
                                                ') OR (UPPER(nome) LIKE '+QuotedStr(UpperCase(Trim(mkeDescricao.Text))+'%')+'))'
   else
      frmPrincipal.qryClientes.Filter := ' status = ''A'' AND ((celular like '+QuotedStr('%'+Trim(Copy(mkeDescricao.Text,1,11))+'%')+
                                                                ') or (fone_fixo like '+QuotedStr('%'+Trim(Copy(mkeDescricao.Text,1,10))+'%')+
                                                                ') or (cpf_cnpj like '+QuotedStr(Trim(Copy(mkeDescricao.Text,1,14))+'%')+
                                                               ') OR (UPPER(nome) LIKE '+QuotedStr(UpperCase(Trim(mkeDescricao.Text))+'%')+'))';

   frmPrincipal.qryClientes.Filtered := True;

   lblTotal.Caption := 'Total de Clientes: '+frmPrincipal.qryClientes.RecordCount.ToString;
   frmPrincipal.qryClientes.First;

end;

procedure TfrmPesquisarClientes.FormCreate(Sender: TObject);
begin

   frmPrincipal.qryClientes.Close;
   frmPrincipal.qryClientes.Open;

end;

procedure TfrmPesquisarClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_F12, VK_RETURN: Confirmar;
      VK_ESCAPE: close;
      VK_F2: NovoCliente;

   end;

end;

procedure TfrmPesquisarClientes.FormShow(Sender: TObject);
begin

   Filtrar;

end;

procedure TfrmPesquisarClientes.Image4Click(Sender: TObject);
begin

   close;

end;

procedure TfrmPesquisarClientes.imgNovoClick(Sender: TObject);
begin

   NovoCliente;

end;

procedure TfrmPesquisarClientes.JvDBGrid1DblClick(Sender: TObject);
begin

   //Confirmar;

end;

procedure TfrmPesquisarClientes.JvDBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin

   if key = #13 then
      Confirmar;

end;

procedure TfrmPesquisarClientes.mkeDescricaoChange(Sender: TObject);
begin

   Filtrar;

end;

procedure TfrmPesquisarClientes.mkeDescricaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   if key = VK_DOWN then
      JvDBGrid1.SetFocus;

end;

procedure TfrmPesquisarClientes.NovoCliente;
begin

   if imgNovo.Visible = false then
      Exit;

   Application.CreateForm(TfrmCadastrarClientes, frmCadastrarClientes);
   frmCadastrarClientes.ShowModal;
   frmPrincipal.qryClientes.Refresh;

end;

procedure TfrmPesquisarClientes.speNovoClick(Sender: TObject);
begin

   NovoCliente;

end;

end.
