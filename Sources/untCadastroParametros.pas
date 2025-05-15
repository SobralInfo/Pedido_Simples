unit untCadastroParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrPosPrinter, ACBrBase, Vcl.StdCtrls, TypInfo,Vcl.Printers,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask, BaseLocalParametrosController, BaseLocalParametrosVO,
  JvExStdCtrls, JvEdit, JvValidateEdit, ACBrDFe, ACBrNFe;

type
  TfrmCadastroParametros = class(TForm)
    grpImpressora: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    SpeedButton9: TSpeedButton;
    cbbImpressora: TComboBox;
    cbbPortaImpressora: TComboBox;
    ACBrPosPrinter1: TACBrPosPrinter;
    Panel3: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel4: TPanel;
    speSalvar: TSpeedButton;
    speEditar: TSpeedButton;
    grpBaseLocal: TGroupBox;
    rdbSim: TRadioButton;
    rdbNao: TRadioButton;
    Label1: TLabel;
    edtCaixa: TMaskEdit;
    grpTipoDescontoPedido: TGroupBox;
    rdbTipoDescontoItem: TRadioButton;
    rdbTipoDescontoTotal: TRadioButton;
    grpImpressoraCozinha: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    cbbImpressoraCozinha: TComboBox;
    cbbPortaImpressoraCozinha: TComboBox;
    grpTipoEmissao: TGroupBox;
    rdbHomologacao: TRadioButton;
    rdbProducao: TRadioButton;
    grpFormaEmissao: TGroupBox;
    rdbNormal: TRadioButton;
    rdbContingencia: TRadioButton;
    edtNumeroCSC: TMaskEdit;
    Label6: TLabel;
    Label5: TLabel;
    edtIdCSC: TMaskEdit;
    Label7: TLabel;
    edtSerieNFCe: TJvValidateEdit;
    edtNumeroNFCe: TJvValidateEdit;
    Label8: TLabel;
    edtCertificado: TMaskEdit;
    Label9: TLabel;
    speBuscarCertificado: TSpeedButton;
    nfeFiscal: TACBrNFe;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure speEditarClick(Sender: TObject);
    procedure speSalvarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure speBuscarCertificadoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Editar;
    procedure Salvar;
  end;

var
  frmCadastroParametros: TfrmCadastroParametros;

implementation

{$R *.dfm}

uses untPrincipal;

procedure TfrmCadastroParametros.Editar;
begin

   speSalvar.Enabled := True;
   speEditar.Enabled := False;

   grpImpressora.Enabled         := True;
   grpImpressoraCozinha.Enabled  := True;
   grpBaseLocal.Enabled          := True;
   grpTipoDescontoPedido.Enabled := True;
   edtCaixa.Enabled              := True;
   edtCertificado.Enabled        := True;
   speBuscarCertificado.Enabled  := True;
   edtNumeroNFCe.Enabled         := True;
   edtSerieNFCe.Enabled          := True;
   edtNumeroCSC.Enabled          := True;
   edtIdCSC.Enabled              := True;
   grpTipoEmissao.Enabled        := True;
   grpFormaEmissao.Enabled       := True;

   cbbImpressora.SetFocus;

end;

procedure TfrmCadastroParametros.FormCreate(Sender: TObject);
Var N: TACBrPosPrinterModelo;
    linha: string;
    f:TextFile;
    k: integer;
begin

  cbbImpressora.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbbImpressora.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;


  cbbPortaImpressora.Items.Clear;
  ACBrPosPrinter1.Device.AcharPortasSeriais( cbbPortaImpressora.Items );
  cbbPortaImpressora.Items.Add('\\localhost\ImpCupom') ;

  For K := 0 to Printer.Printers.Count-1 do
    cbbPortaImpressora.Items.Add('RAW:'+Printer.Printers[K]);

  edtCaixa.Text := frmPrincipal.qryParametrosCAIXA.AsString;

  //

  cbbImpressoraCozinha.Items.Clear ;
  For N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbbImpressoraCozinha.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;


  cbbPortaImpressoraCozinha.Items.Clear;
  ACBrPosPrinter1.Device.AcharPortasSeriais( cbbPortaImpressoraCozinha.Items );
  cbbPortaImpressoraCozinha.Items.Add('\\localhost\ImpCupom') ;

  For K := 0 to Printer.Printers.Count-1 do
    cbbPortaImpressoraCozinha.Items.Add('RAW:'+Printer.Printers[K]);

  edtCaixa.Text := frmPrincipal.qryParametrosCAIXA.AsString;

  rdbNao.Checked       := True;

  if frmPrincipal.qryParametrosBASE_LOCAL.AsString = 'S' then
     rdbSim.Checked := True;

  if frmPrincipal.qryParametrosTIPO_DESCONTO_PEDIDO.AsString = 'I' then
     rdbTipoDescontoItem.Checked := True
  else if frmPrincipal.qryParametrosTIPO_DESCONTO_PEDIDO.AsString = 'T' then
     rdbTipoDescontoTotal.Checked := True;

  if frmPrincipal.qryParametrosFORMA_EMISSAO.AsString = 'N' then
     rdbNormal.Checked := True
  else if frmPrincipal.qryParametrosFORMA_EMISSAO.AsString = 'C' then
     rdbContingencia.Checked := True;

  if frmPrincipal.qryParametrosTIPO_AMBIENTE.AsString = 'P' then
     rdbProducao.Checked := True
  else if frmPrincipal.qryParametrosTIPO_AMBIENTE.AsString = 'H' then
     rdbHomologacao.Checked := True;

  edtCertificado.Text := Trim(frmPrincipal.qryParametrosCERTIFICADO_DIGITAL.AsString);
  edtIdCSC.Text       := Trim(frmPrincipal.qryParametrosID_CSC_NFCE.AsString);
  edtNumeroCSC.Text   := Trim(frmPrincipal.qryParametrosCSC_NFCE.AsString);
  edtNumeroNFCe.AsInteger := frmPrincipal.qryParametrosNUMERO_NFCE.AsInteger;
  edtSerieNFCe.AsInteger  := frmPrincipal.qryParametrosSERIE_NFCE.AsInteger;

  Try

   AssignFile(f, ExtractFilePath(Application.ExeName)+'\impressoraLocal.txt');
   Reset(f); //abre o arquivo para leitura;

   While not eof(f) do begin
     Readln(f,linha); //le do arquivo e desce uma linha. O conteúdo lido é transferido para a variável linha

     if cbbImpressora.Text = '' then
         cbbImpressora.ItemIndex := StrToInt(linha)
     else
         cbbPortaImpressora.ItemIndex := StrToInt(Copy(linha,1,2));

     if cbbImpressora.Text = '' then
         cbbImpressora.ItemIndex := StrToInt(linha)
     else
         cbbPortaImpressora.ItemIndex := StrToInt(Copy(linha,1,2));

   End;

   Closefile(f);

   AssignFile(f, ExtractFilePath(Application.ExeName)+'\impressoraLocalCozinha.txt');
   Reset(f); //abre o arquivo para leitura;

   While not eof(f) do begin
     Readln(f,linha); //le do arquivo e desce uma linha. O conteúdo lido é transferido para a variável linha

     if cbbImpressoraCozinha.Text = '' then
         cbbImpressoraCozinha.ItemIndex := StrToInt(linha)
     else
         cbbPortaImpressoraCozinha.ItemIndex := StrToInt(Copy(linha,1,2));

     if cbbImpressoraCozinha.Text = '' then
         cbbImpressoraCozinha.ItemIndex := StrToInt(linha)
     else
         cbbPortaImpressoraCozinha.ItemIndex := StrToInt(Copy(linha,1,2));

   End;

   Closefile(f);

  Except
  End;

end;

procedure TfrmCadastroParametros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmCadastroParametros.Image1Click(Sender: TObject);
begin

   close;

end;

procedure TfrmCadastroParametros.speEditarClick(Sender: TObject);
begin

   Editar;

end;

procedure TfrmCadastroParametros.speSalvarClick(Sender: TObject);
begin

   Salvar;

end;

procedure TfrmCadastroParametros.Salvar;
Var config: TBaseLocalParametrosVO;
begin

   Try

      config := TBaseLocalParametrosVO.Create;

      if rdbSim.Checked then
         config.BASE_LOCAL := 'S'
      else
         config.BASE_LOCAL := 'N';

      if rdbTipoDescontoItem.Checked then
         config.TIPO_DESCONTO_PEDIDO := 'I'
      else
         config.TIPO_DESCONTO_PEDIDO := 'T';

      config.CAIXA := Trim(edtCaixa.Text);

      config.certificado_digital := Trim(edtCertificado.Text);
      config.numero_nfce         := edtNumeroNFCe.AsInteger;
      config.id_csc_nfce         := Trim(edtIdCSC.Text);
      config.serie_nfce          := edtSerieNFCe.AsInteger;
      config.csc_nfce            := Trim(edtNumeroCSC.Text);

      if rdbNormal.Checked then
         config.forma_emissao := 'N'
      else
         config.forma_emissao := 'C';

      if rdbHomologacao.Checked then
         config.tipo_ambiente := 'H'
      else
         config.tipo_ambiente := 'P';

      TBaseLocalParametrosController.GravarParametros(config);

      grpImpressora.Enabled         := False;
      grpImpressoraCozinha.Enabled  := False;
      grpBaseLocal.Enabled          := False;
      edtCaixa.Enabled              := False;
      grpTipoDescontoPedido.Enabled := False;
      edtCertificado.Enabled        := False;
      speBuscarCertificado.Enabled  := False;
      edtNumeroNFCe.Enabled         := False;
      edtSerieNFCe.Enabled          := False;
      edtNumeroCSC.Enabled          := False;
      edtIdCSC.Enabled              := False;
      grpTipoEmissao.Enabled        := False;
      grpFormaEmissao.Enabled       := False;

      speSalvar.Enabled := False;
      speEditar.Enabled := True;

      frmPrincipal.qryParametros.Close;
      frmPrincipal.qryParametros.Open;

   Finally

      FreeAndNil(config);

   End;

end;

procedure TfrmCadastroParametros.SpeedButton1Click(Sender: TObject);
var arq: TextFile;
    linha: String;

begin

   AssignFile ( arq, ExtractFilePath(Application.ExeName)+'\impressoraLocalCozinha.txt' );
   Rewrite ( arq );
   Write(arq,inttostr(cbbImpressoraCozinha.ItemIndex));
   Writeln(arq);
   Write(arq,FormatFloat('#00',cbbPortaImpressoraCozinha.ItemIndex)+Trim(cbbPortaImpressoraCozinha.Text));
   Writeln(arq);
   CloseFile ( arq );
end;

procedure TfrmCadastroParametros.speBuscarCertificadoClick(Sender: TObject);
begin

   {$IFNDEF ACBrNFeOpenSSL}
   Try
     edtCertificado.Text := nfeFiscal.SSL.SelecionarCertificado;
   except
      on e:exception do
         ShowMessage(e.Message);
   End;
   {$ENDIF}

end;

procedure TfrmCadastroParametros.SpeedButton9Click(Sender: TObject);
var arq: TextFile;
    linha: String;

begin

   AssignFile ( arq, ExtractFilePath(Application.ExeName)+'\impressoraLocal.txt' );
   Rewrite ( arq );
   Write(arq,inttostr(cbbImpressora.ItemIndex));
   Writeln(arq);
   Write(arq,FormatFloat('#00',cbbPortaImpressora.ItemIndex)+Trim(cbbPortaImpressora.Text));
   Writeln(arq);
   CloseFile ( arq );
end;

end.
