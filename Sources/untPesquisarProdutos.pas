unit untPesquisarProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask, PedidoProdutosVO, unitConfiguracoes,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, JvExDBGrids, JvDBGrid, PedidoProdutosController,
  Vcl.Imaging.pngimage;

type
  TfrmPesquisarProdutos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    mkeDescricao: TMaskEdit;
    Panel2: TPanel;
    lblTotal: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    JvDBGrid1: TJvDBGrid;
    Label2: TLabel;
    procedure mkeDescricaoChange(Sender: TObject);
    procedure mkeDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure JvDBGrid1DblClick(Sender: TObject);
    procedure JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Image3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var origem: string;
    procedure Filtrar;
    procedure Confirmar;
  end;

var
  frmPesquisarProdutos: TfrmPesquisarProdutos;

implementation

{$R *.dfm}

uses untPrincipal, untPedidos, untCadastrarProdutos, untTelaDePedido,
  untObservacao;

procedure TfrmPesquisarProdutos.Confirmar;
Var produto: TPedidoProdutosVO;
begin

   if frmPrincipal.qryProdutos.IsEmpty then Begin

      prcMsgAdv('Selecione um registro.');
      Exit;

   End;

   if origem = 'PEDIDO' then Begin

      if frmPrincipal.qryProdutosVALOR_UNITARIO.AsFloat <= 0.00 then Begin

         prcMsgAdv('Produto com valor de venda inválido.');
         Exit;

      End;

      frmTelaDePedido.edtCodigoProduto.Text    := frmPrincipal.qryProdutosID.AsString;
      frmTelaDePedido.edtDescricaoProduto.Text := Trim(frmPrincipal.qryProdutosDESCRICAO.AsString);
      frmTelaDePedido.lblUnidade.Caption       := Trim(frmPrincipal.qryProdutosUNIDADE.AsString);
      frmTelaDePedido.fatorUnidade             := frmPrincipal.qryProdutosFATOR.AsFloat;
      frmTelaDePedido.lblValorUnitario.Caption := FormatFloat('###,#0.00',frmPrincipal.qryProdutosVALOR_UNITARIO.AsFloat);
      frmTelaDePedido.idProduto := frmPrincipal.qryProdutosID.AsInteger;
      frmTelaDePedido.AtualizarTotais;
      frmTelaDePedido.edtQuantidade.SetFocus;
      frmTelaDePedido.edtQuantidade.SelText;


   End else if origem <> 'CADASTRO_PRODUTOS' then Begin


      if frmPrincipal.qryProdutosVALOR_UNITARIO.AsFloat <= 0.00 then Begin

         prcMsgAdv('Produto com valor de venda inválido.');
         Exit;

      End;

      Try

         produto := TPedidoProdutosVO.Create;
         produto := TPedidoProdutosController.RetornarProdutoPorID(frmPrincipal.qryProdutosID.AsInteger);
         frmPedidos.Confirmar(produto);

      Finally

         FreeAndNil(produto);

      End;

   End else Begin

      frmCadastrarProdutos.HabilitarDesabilitarBotoes('E');
      frmCadastrarProdutos.HabilitarDesabilitarCampos('H');
      frmCadastrarProdutos.LimparCampos;
      frmCadastrarProdutos.DAO := 'U';

      if frmPrincipal.qryProdutosSTATUS.AsString = 'A' then
         frmCadastrarProdutos.cbbStatus.ItemIndex := 0
      else
         frmCadastrarProdutos.cbbStatus.ItemIndex := 1;

      if frmPrincipal.qryProdutosIMPRIMIR_COZINHA.AsString = 'S' then
         frmCadastrarProdutos.cbbImprimirCozinha.ItemIndex := 0
      else
         frmCadastrarProdutos.cbbImprimirCozinha.ItemIndex := 1;

      frmCadastrarProdutos.edtDescricao.Text    := Trim(frmPrincipal.qryProdutosDESCRICAO.AsString);
      frmCadastrarProdutos.lkpUnidade.KeyValue  := frmPrincipal.qryProdutosID_UNIDADE.AsInteger;
      frmCadastrarProdutos.edtCodigoBarras.Text := Trim(frmPrincipal.qryProdutosCODIGO_BARRAS.AsString);
      frmCadastrarProdutos.edtReferencia.Text   := Trim(frmPrincipal.qryProdutosREFERENCIA.AsString);
      frmCadastrarProdutos.edtEstoque.AsFloat   := frmPrincipal.qryProdutosQTDE_ESTOQUE.AsFloat;
      frmCadastrarProdutos.edtValor.AsFloat     := frmPrincipal.qryProdutosVALOR_UNITARIO.AsFloat;

      frmCadastrarProdutos.chkFiscais.Checked := True;
      frmCadastrarProdutos.chkFiscais.Checked := False;

      if Trim(frmPrincipal.qryProdutosFISCAL.AsString) = 'S' then Begin

         frmCadastrarProdutos.chkFiscais.Checked := True;
         frmCadastrarProdutos.lkpOrigem.KeyValue := frmPrincipal.qryProdutosORIGEM.AsInteger;
         frmCadastrarProdutos.lkpCFOP.KeyValue   := frmPrincipal.qryProdutosCFOP.AsString;
         frmCadastrarProdutos.edtNCM.Text        := Trim(frmPrincipal.qryProdutosNCM.AsString);
         frmCadastrarProdutos.edtCEST.Text       := Trim(frmPrincipal.qryProdutosCEST.AsString);
         frmCadastrarProdutos.lkpCST_CSOSN.KeyValue := frmPrincipal.qryProdutosCST_CSOSN.AsString;
         frmCadastrarProdutos.lkpAliquotaICMS.KeyValue := frmPrincipal.qryProdutosTAXA_ICMS.AsFloat;
         frmCadastrarProdutos.lkpCST_PIS.KeyValue := frmPrincipal.qryProdutosCST_PIS.AsString;
         frmCadastrarProdutos.lkpAliquotaPIS.KeyValue  := frmPrincipal.qryProdutosTAXA_PIS.AsFloat;
         frmCadastrarProdutos.lkpCST_COFINS.KeyValue   := frmPrincipal.qryProdutosCST_COFINS.AsString;
         frmCadastrarProdutos.lkpAliquotaCOFINS.KeyValue := frmPrincipal.qryProdutosTAXA_COFINS.AsFloat;
         frmCadastrarProdutos.cbbStatus.SetFocus;

      End;

      frmCadastrarProdutos.idProduto            := frmPrincipal.qryProdutosID.AsInteger;

   End;

   close;

end;

procedure TfrmPesquisarProdutos.Filtrar;
begin

   frmPrincipal.qryProdutos.Close;
   frmPrincipal.qryProdutos.Filtered := False;

   if origem = 'CADASTRO_PRODUTOS' then
      frmPrincipal.qryProdutos.Filter := ' ((Upper(referencia) like '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,80)+'%')+') or (Upper(descricao) LIKE '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,100)+'%')+') OR (Upper(codigo_barras) like '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,15)+'%')+'))'
   else
      frmPrincipal.qryProdutos.Filter := ' ((status = ''A'') AND (((Upper(referencia) like '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,80)+'%')+') or (Upper(descricao) LIKE '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,100)+'%')+') OR (Upper(codigo_barras) like '+QuotedStr(Copy(Trim(AnsiUpperCase(mkeDescricao.Text)),1,15)+'%')+'))))';


   frmPrincipal.qryProdutos.Filtered := True;

   frmPrincipal.qryProdutos.Open;

   lblTotal.Caption := 'Total de Produtos: '+frmPrincipal.qryProdutos.RecordCount.ToString;
   frmPrincipal.qryProdutos.First;

end;

procedure TfrmPesquisarProdutos.FormCreate(Sender: TObject);
begin

   frmPrincipal.qryProdutos.Close;
   frmPrincipal.qryProdutos.Open;
   Filtrar;

end;

procedure TfrmPesquisarProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_F12: Confirmar;
      VK_ESCAPE: close;

   end;

end;

procedure TfrmPesquisarProdutos.Image3Click(Sender: TObject);
begin

   Confirmar;

end;

procedure TfrmPesquisarProdutos.Image4Click(Sender: TObject);
begin

   close;

end;

procedure TfrmPesquisarProdutos.JvDBGrid1DblClick(Sender: TObject);
begin

   //Confirmar;

end;

procedure TfrmPesquisarProdutos.JvDBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin

   if key = #13 then
      Confirmar;

end;

procedure TfrmPesquisarProdutos.mkeDescricaoChange(Sender: TObject);
begin

   Filtrar;

end;

procedure TfrmPesquisarProdutos.mkeDescricaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   if key = VK_DOWN then
      JvDBGrid1.SetFocus;

end;

end.
