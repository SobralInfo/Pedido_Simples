unit untCadastrarEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.pngimage, unitConfiguracoes,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, baseLocalEmpresaVO, baseLocalEmpresaController,
  Vcl.DBCtrls;

type
  TfrmCadastrarEmpresa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Panel4: TPanel;
    speNovo: TSpeedButton;
    speSalvar: TSpeedButton;
    speCancelar: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label5: TLabel;
    edtFoneFixo: TMaskEdit;
    Label6: TLabel;
    edtCelular: TMaskEdit;
    Label8: TLabel;
    edtSite: TMaskEdit;
    Label1: TLabel;
    cbbTipoRegime: TComboBox;
    Label14: TLabel;
    lkpCidade: TDBLookupComboBox;
    edtRazaoSocial: TMaskEdit;
    edtIE: TMaskEdit;
    edtCNPJ: TMaskEdit;
    Label3: TLabel;
    edtFantasia: TMaskEdit;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtComplemento: TMaskEdit;
    edtNumero: TMaskEdit;
    edtCEP: TMaskEdit;
    edtEmail: TMaskEdit;
    Label12: TLabel;
    Label13: TLabel;
    edtBairro: TMaskEdit;
    Label11: TLabel;
    edtLogradouro: TMaskEdit;
    Label7: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lkpUF: TComboBox;
    procedure Image1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure speNovoClick(Sender: TObject);
    procedure speSalvarClick(Sender: TObject);
    procedure speCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lkpUFChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var DAO: String;
        idEmpresa: integer;
    procedure Pesquisar;
    procedure Novo;
    procedure Salvar;
    procedure Cancelar;
    procedure HabilitarDesabilitarBotoes(tipo: string);
    procedure HabilitarDesabilitarCampos(tipo: string);
    procedure LimparCampos;
    procedure FiltrarMunicipio;
  end;

var
  frmCadastrarEmpresa: TfrmCadastrarEmpresa;

implementation

{$R *.dfm}

uses untPesquisarEmpresa, untPrincipal;

procedure TfrmCadastrarEmpresa.Cancelar;
begin

   HabilitarDesabilitarCampos('D');
   HabilitarDesabilitarBotoes('C');
   LimparCampos;

end;

procedure TfrmCadastrarEmpresa.FiltrarMunicipio;
begin

   frmPrincipal.qryMunicipio.Close;
   frmPrincipal.qryMunicipio.Filtered := False;
   frmPrincipal.qryMunicipio.Filter := ' UPPER(UF_SIGLA) = '+QuotedStr(Trim(UpperCase(lkpUF.Text)));
   frmPrincipal.qryMunicipio.Filtered := True;
   frmPrincipal.qryMunicipio.Open;

end;

procedure TfrmCadastrarEmpresa.FormCreate(Sender: TObject);
begin

   frmPrincipal.qryMunicipio.Close;
   frmPrincipal.qryMunicipio.Open;

end;

procedure TfrmCadastrarEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

     VK_ESCAPE: close;

   end;

end;

procedure TfrmCadastrarEmpresa.HabilitarDesabilitarBotoes(tipo: string);
begin

   if tipo = 'N' then Begin

      speNovo.Enabled     := False;
      speSalvar.Enabled   := True;
      speCancelar.Enabled := True;

   End;

   if tipo = 'E' then Begin

      speNovo.Enabled     := False;
      speSalvar.Enabled   := True;
      speCancelar.Enabled := True;

   End;

   if tipo = 'X' then Begin

      speNovo.Enabled     := True;
      speSalvar.Enabled   := False;
      speCancelar.Enabled := False;

   End;

   if tipo = 'C' then Begin

      speNovo.Enabled     := True;
      speSalvar.Enabled   := False;
      speCancelar.Enabled := False;

   End;

   if tipo = 'S' then Begin

      speNovo.Enabled     := True;
      speSalvar.Enabled   := False;
      speCancelar.Enabled := False;

   End;



end;

procedure TfrmCadastrarEmpresa.HabilitarDesabilitarCampos(tipo: string);
begin

   if tipo = 'H' then Begin

      edtCNPJ.Enabled        := True;
      edtRazaoSocial.Enabled := True;
      edtFantasia.Enabled    := True;
      edtFoneFixo.Enabled    := True;
      edtCelular.Enabled     := True;
      edtEmail.Enabled       := True;
      edtSite.Enabled        := True;
      lkpUF.Enabled          := True;
      lkpCidade.Enabled      := True;
      edtLogradouro.Enabled  := True;
      edtNumero.Enabled      := True;
      edtComplemento.Enabled := True;
      edtBairro.Enabled      := True;
      edtIE.Enabled          := True;
      cbbTipoRegime.Enabled  := True;
      edtCEP.Enabled         := True;

   End else if tipo = 'D' then Begin

      edtCNPJ.Enabled        := False;
      edtRazaoSocial.Enabled := False;
      edtFantasia.Enabled    := False;
      edtFoneFixo.Enabled    := False;
      edtCelular.Enabled     := False;
      edtEmail.Enabled       := False;
      edtSite.Enabled        := False;
      lkpUF.Enabled          := False;
      lkpCidade.Enabled      := False;
      edtLogradouro.Enabled  := False;
      edtNumero.Enabled      := False;
      edtComplemento.Enabled := False;
      edtBairro.Enabled      := False;
      edtIE.Enabled          := False;
      cbbTipoRegime.Enabled  := False;
      edtCEP.Enabled         := False;

   End;


end;

procedure TfrmCadastrarEmpresa.Image1Click(Sender: TObject);
begin

   close;

end;

procedure TfrmCadastrarEmpresa.LimparCampos;
begin

   edtCNPJ.Text        := '';
   edtRazaoSocial.Text := '';
   edtFantasia.Text    := '';
   edtFoneFixo.Text    := '';
   edtCelular.Text     := '';
   edtEmail.Text       := '';
   edtSite.Text        := '';
   idEmpresa           := 0;
   lkpUF.ItemIndex         := -1;
   lkpCidade.KeyValue      := -1;
   edtLogradouro.Text      := '';
   edtNumero.Text          := '';
   edtComplemento.Text     := '';
   edtBairro.Text          := '';
   edtIE.Text              := '';
   cbbTipoRegime.ItemIndex := -1;
   edtCEP.Text         := '';
   DAO                 := '';

end;

procedure TfrmCadastrarEmpresa.lkpUFChange(Sender: TObject);
begin

   FiltrarMunicipio;

end;

procedure TfrmCadastrarEmpresa.Novo;
begin

   Try
      frmPrincipal.qryEmpresa.Refresh;
   Except
      frmPrincipal.qryEmpresa.Close;
      frmPrincipal.qryEmpresa.Open;
   End;

   if Not(frmPrincipal.qryEmpresa.IsEmpty) then Begin
      prcMsgAdv('Já consta uma empresa cadastrada.');
      Exit;
   End;

   HabilitarDesabilitarBotoes('N');
   HabilitarDesabilitarCampos('H');
   LimparCampos;
   edtCNPJ.SetFocus;
   DAO := '';


end;

procedure TfrmCadastrarEmpresa.Pesquisar;
begin

   Application.CreateForm(TfrmPesquisarEmpresa, frmPesquisarEmpresa);
   frmPesquisarEmpresa.origem := 'CADASTRO_EMPRESA';
   frmPesquisarEmpresa.ShowModal;

end;

procedure TfrmCadastrarEmpresa.Salvar;
var empresa: TBaseLocalEmpresaVO;
begin

   if Length(Trim(edtCNPJ.Text)) <> 14 then Begin
      prcMsgAdv('CNPJ inválido.');
      edtCNPJ.SetFocus;
      Exit;
   End;

   if Trim(edtRazaoSocial.Text) = '' then Begin
      prcMsgAdv('Informe a razão social da empresa.');
      edtRazaoSocial.SetFocus;
      Exit;
   End;

   if Trim(edtFantasia.Text) = '' then Begin
      prcMsgAdv('Informe o nome fantasia da empresa.');
      edtFantasia.SetFocus;
      Exit;
   End;

   if ((Trim(edtFoneFixo.Text) = '') and (Trim(edtCelular.Text) = '')) then Begin
      prcMsgAdv('Informe ao menos um telefone da empresa.');
      edtFoneFixo.SetFocus;
      Exit;
   End;

   Try

      empresa := TBaseLocalEmpresaVO.Create;

      empresa.CNPJ          := Trim(edtCNPJ.Text);
      empresa.RAZAO_SOCIAL  := Trim(edtRazaoSocial.Text);
      empresa.FANTASIA      := Trim(edtFantasia.Text);
      empresa.FONE          := Trim(edtFoneFixo.Text);
      empresa.CELULAR       := Trim(edtCelular.Text);
      empresa.EMAIL         := Trim(edtEmail.Text);
      empresa.SITE          := Trim(edtSite.Text);
      empresa.IE            := Trim(edtIE.Text);
      empresa.LOGRADOURO    := Trim(edtLogradouro.Text);
      empresa.NUMERO        := Trim(edtNumero.Text);
      empresa.COMPLEMENTO   := Trim(edtComplemento.Text);
      empresa.BAIRRO        := Trim(edtBairro.Text);
      empresa.CEP           := Trim(edtCEP.Text);
      empresa.CODIGO_CIDADE := lkpCidade.KeyValue;
      empresa.CODIGO_UF     := StrToInt(Copy(IntToStr(lkpCidade.KeyValue),1,2));
      empresa.UF            := Trim(Trim(lkpUF.Text));
      empresa.CIDADE        := Trim(lkpCidade.Text);

      empresa.TIPO_REGIME   := StrToInt(Copy(cbbTipoRegime.Text,1,1));


      if DAO = 'U' then Begin
         empresa.ID        := idEmpresa;
         TBaseLocalEmpresaController.AlterarEmpresa(empresa);
      End else
         TBaseLocalEmpresaController.GravarEmpresa(empresa);

   Finally

      FreeAndNil(empresa);

   End;

end;

procedure TfrmCadastrarEmpresa.speCancelarClick(Sender: TObject);
begin

   Cancelar;

end;

procedure TfrmCadastrarEmpresa.SpeedButton5Click(Sender: TObject);
begin

   Pesquisar;

end;

procedure TfrmCadastrarEmpresa.speNovoClick(Sender: TObject);
begin

   Novo;

end;

procedure TfrmCadastrarEmpresa.speSalvarClick(Sender: TObject);
begin

   Salvar;

end;

end.
