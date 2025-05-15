unit untFinalizarVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, untprincipal, acbrUtil,
  Vcl.StdCtrls, Vcl.DBCtrls, JvExStdCtrls, JvEdit, JvValidateEdit, Vcl.Mask, unitConfiguracoes, BaseLocalEmpresaVO, BaseLocalEmpresaController,
  JvExMask, JvToolEdit, JvDBLookup, JvDBLookupComboEdit, JvExControls, baseLocalVendaCabecalhoVO, BaseLocalPedidoCabecalhoController,
  JvDBLookupTreeView, JvCombobox, JvDBCombobox, ACBrBase, ACBrEnterTab, baseLocalVendaCabecalhoController,
  Vcl.DBCGrids, Data.DB, Datasnap.DBClient, BaseLocalVendaDetalheController, BaseLocalVendaDetalheVO,
  BaseLocalTotalTipoPagtoController, BaseLocalTotalTipoPagtoVO, ACBrPosPrinter, generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, BaseLocalClientesController, BaseLocalClientesVO,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, BaseLocalFuncionariosController,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, BaseLocalFuncionariosVO,
  Vcl.Imaging.jpeg, JvExExtCtrls, JvExtComponent, JvPanel, untIntegracaoFidelidade;

type
  TfrmFinalizarVenda = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtRecebido: TJvValidateEdit;
    Label1: TLabel;
    DBCtrlGrid1: TDBCtrlGrid;
    DBText1: TDBText;
    Label2: TLabel;
    DBText7: TDBText;
    Panel3: TPanel;
    lblTotal: TLabel;
    Image5: TImage;
    Label3: TLabel;
    lblValorVenda: TLabel;
    lblValorRecebido: TLabel;
    lblValorFaltante: TLabel;
    lblValorTroco: TLabel;
    lkpFormaPG: TDBLookupComboBox;
    dtsPagamento: TDataSource;
    cdsPagamento: TClientDataSet;
    cdsPagamentoidPagamento: TIntegerField;
    cdsPagamentodescricao: TStringField;
    cdsPagamentovalor: TFloatField;
    cdsPagamentosequencia: TStringField;
    Panel4: TPanel;
    DBText2: TDBText;
    Label4: TLabel;
    qryFuncionarios: TFDQuery;
    qryFuncionariosID: TIntegerField;
    qryFuncionariosSTATUS: TStringField;
    qryFuncionariosCODIGO: TStringField;
    qryFuncionariosNOME: TStringField;
    qryFuncionariosPERCENTUAL_COMISSAO: TFloatField;
    Image1: TImage;
    Image3: TImage;
    JvPanel1: TJvPanel;
    Timer1: TTimer;
    cdsPagamentofidelidade: TStringField;
    Image2: TImage;
    Image4: TImage;
    Image6: TImage;
    qryAUX: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure JvDBLookupComboEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure JvDBLookupComboEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtRecebidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lkpFormaPGKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure DBCtrlGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure lkpFormaPGExit(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var ValorVenda, valorRecebido, valorRestante, valorTroco: double;
        sequencia: integer;
        existeFiscal: Boolean;
    procedure AtualizarTotais;
    procedure EfetuarPagamento;
    procedure GravarVenda;
    Function ExisteFidelidade: boolean;

  end;

var
  frmFinalizarVenda: TfrmFinalizarVenda;

implementation

{$R *.dfm}

uses untPedidos, untConsultarPagarFidelidade;

procedure TfrmFinalizarVenda.AtualizarTotais;
begin

   valorRestante := RoundABNT(ValorVenda - valorRecebido,2);

   if valorRestante < 0 then Begin
      valorTroco    := RoundABNT(valorRestante * -1,2);
      valorRestante := 0.00;
   End;

   lblValorVenda.Caption    := 'R$ '+FormatFloat('###,#0.00',ValorVenda);
   lblValorRecebido.Caption := 'R$ '+FormatFloat('###,#0.00',valorRecebido);
   lblValorFaltante.Caption := 'R$ '+FormatFloat('###,#0.00',valorRestante);
   lblValorTroco.Caption    := 'R$ '+FormatFloat('###,#0.00',valorTroco);

   if valorRestante <= 0 then Begin

      GravarVenda;
      frmPedidos.CancelarVendaAtual(false);
      lkpFormaPG.Enabled  := False;
      edtRecebido.Enabled := False;
      //prcMsgInf('Venda finalizada com sucesso.');
      Timer1.Enabled := True;
      frmFinalizarVenda.SetFocus;
   End;

end;

procedure TfrmFinalizarVenda.DBCtrlGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if key = VK_DELETE then Begin

      if ((Not(cdsPagamento.IsEmpty)) AND (edtRecebido.Enabled = True)) then Begin

         if fctMsgConfirmDefaultButtonNo('Confirma a exclusão do pagamento selecionado?') = false then
            Exit;

         valorRecebido := valorRecebido - cdsPagamentovalor.AsFloat;
         cdsPagamento.Delete;
         AtualizarTotais;
         cdsPagamento.Open;

      End;

   End;


end;

procedure TfrmFinalizarVenda.edtRecebidoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   case key of

      VK_RETURN: EfetuarPagamento;
      VK_F12: EfetuarPagamento;

   end;

end;

procedure TfrmFinalizarVenda.EfetuarPagamento;
Var vl01,vl02, vl03: real;
begin

   if Trim(lkpFormaPG.Text) = '' then Begin
      prcMsgAdv('Informe a forma de pagamento.');
      if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
         lkpFormaPG.SetFocus
      else
         edtRecebido.SelectAll;
      Exit;
   End;

   if edtRecebido.AsFloat <= 0 then Begin
      prcMsgAdv('Valor de Pagamento inválido.');
      if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
         lkpFormaPG.SetFocus
      else
         edtRecebido.SelectAll;
      Exit;
   End;

   vl01 := 0.00;
   vl02 := 0.00;
   vl03 := 0.00;

   vl01 := ValorVenda;
   vl02 := valorRecebido;
   vl01 := vl01 - vl02;
   vl03 := edtRecebido.Value;
   vl01 := RoundABNT((vl01 - vl03),2);

   if ((vl01 < 0.00) AND (frmPrincipal.qryFormaPGPERMITE_TROCO.AsString <> 'S')) then Begin
      prcMsgAdv('Forma de pagamento não permite troco.');
      if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
         lkpFormaPG.SetFocus
      else
         edtRecebido.SelectAll;
      exit;
   End;

   valorRecebido := valorRecebido + edtRecebido.AsFloat;

   if frmPrincipal.qryFormaPGEMITIR_FISCAL.AsString = 'S' then
      existeFiscal := True;

   cdsPagamento.Append;
   cdsPagamentoidPagamento.AsInteger := lkpFormaPG.KeyValue;
   cdsPagamentodescricao.AsString    := Trim(lkpFormaPG.Text);
   cdsPagamentovalor.AsFloat         := edtRecebido.AsFloat;

   if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
      cdsPagamentofidelidade.AsString := 'S';

   Inc(sequencia);
   cdsPagamentosequencia.AsString    := 'Del';
   cdsPagamento.Post;
   cdsPagamento.Open;


   AtualizarTotais;
   edtRecebido.Value := valorRestante;

   if lkpFormaPG.Enabled = True then Begin
      lkpFormaPG.SetFocus;
      Exit;
   End;

end;

function TfrmFinalizarVenda.ExisteFidelidade: boolean;
begin

   Result := False;

   cdsPagamento.First;

   while not(cdsPagamento.Eof) do begin
      if cdsPagamentofidelidade.AsString = 'S' then
         Result := True;
      cdsPagamento.Next;
   end;

   cdsPagamento.First;

end;

procedure TfrmFinalizarVenda.FormCreate(Sender: TObject);
begin

   frmPrincipal.qryFormaPG.close;
   frmPrincipal.qryFormaPG.Filtered := False;
   frmPrincipal.qryFormaPG.Filter := ' STATUS = ''A'' ';
   frmPrincipal.qryFormaPG.Filtered := True;
   frmPrincipal.qryFormaPG.Open;

   existeFiscal := False;

end;

procedure TfrmFinalizarVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmFinalizarVenda.FormShow(Sender: TObject);
begin

   valorRecebido := 0.00;
   //lkpFormaPG.SetFocus;

end;

procedure TfrmFinalizarVenda.GravarVenda;
Var vendaCabecalho: TBaseLocalVendaCabecalhoVO;
    vendaDetalhe: TBaseLocalVendaDetalheVO;
    tipoPagto: TBaseLocalTotalTipoPagtoVO;
    sequencia: integer;
    fidelidade: TLancamentos;
    valorSemFidelidade,
    valorComFidelidade: double;

begin

   Try

      vendaCabecalho := TBaseLocalVendaCabecalhoVO.Create;
      vendaCabecalho.ID               := TBaseLocalVendaCabecalhoController.RetornarIdVenda;
      vendaCabecalho.NUMERO_PEDIDO    := TBaseLocalVendaCabecalhoController.RetornarIdPedido;
      vendaCabecalho.TROCO            := valorTroco;

      if frmPedidos.idFidelidade > 0 then Begin
        try
           valorSemFidelidade := 0.00;
           valorComFidelidade := 0.00;

           cdsPagamento.First;

           while not(cdsPagamento.Eof) do begin

              if cdsPagamentofidelidade.AsString <> 'S' then
                 valorSemFidelidade := valorSemFidelidade + cdsPagamentovalor.AsFloat
              else
                 valorComFidelidade := valorComFidelidade + cdsPagamentovalor.AsFloat;

              TLancamentos.GravarLancamentoTipoPagto(vendaCabecalho.ID,
                                                     cdsPagamentoidPagamento.AsInteger,
                                                     cdsPagamentovalor.AsFloat,
                                                     '');


              cdsPagamento.Next;

           end;

           Try

              fidelidade := TLancamentos.Create;

              if valorSemFidelidade > 0 then begin
                 fidelidade.id_cliente     := frmPedidos.idFidelidade;
                 fidelidade.tipo           := 'E';
                 fidelidade.valor_compra   := valorSemFidelidade-vendaCabecalho.TROCO;
                 fidelidade.pontuacao      := Trunc(valorSemFidelidade);
                 fidelidade.data_compra    := Date;
                 fidelidade.id_funcionario := 0;
                 fidelidade.id_Pagamento   := cdsPagamentoidPagamento.AsInteger;
                 fidelidade.descricao_Pagamento := trim(cdsPagamentodescricao.AsString);
                 TLancamentos.GravarLancamento(fidelidade);
                 {
                 if Trim(frmPedidos.Configuracao.observacao) <> '' then
                    frmPedidos.obsFidelidade  := Trim(frmPedidos.Configuracao.observacao) +
                    '. Parabéns! :) voce acumulou '+
                    inttostr(trunc((valorSemFidelidade-vendaCabecalho.TROCO) * frmPedidos.Configuracao.valor_ponto_venda))+' pontos no programa de fidelidade.'
                 else
                    frmPedidos.obsFidelidade  := 'Parabéns! :) voce acumulou '+ inttostr(trunc((valorSemFidelidade-vendaCabecalho.TROCO) * frmPedidos.Configuracao.valor_ponto_venda))+' pontos no programa de fidelidade.';
                 }
              end;

              if valorComFidelidade > 0 then begin
                 fidelidade.id_cliente     := frmPedidos.idFidelidade;
                 fidelidade.tipo           := 'S';
                 fidelidade.valor_compra   := valorComFidelidade;
                 fidelidade.pontuacao      := Trunc(valorComFidelidade)*-1;
                 fidelidade.data_compra    := Date;
                 fidelidade.id_funcionario := 0;
                 fidelidade.id_Pagamento   := cdsPagamentoidPagamento.AsInteger;
                 fidelidade.descricao_Pagamento := trim(cdsPagamentodescricao.AsString);
                 TLancamentos.GravarLancamento(fidelidade);
              end;

           Finally

              FreeAndNil(fidelidade);

           End;
        except
        end;

      End else Begin

        Try
           valorSemFidelidade := 0.00;
           cdsPagamento.First;

           while not(cdsPagamento.Eof) do begin
              valorSemFidelidade := valorSemFidelidade + cdsPagamentovalor.AsFloat;
              cdsPagamento.Next;
           end;

          Try
             fidelidade := TLancamentos.Create;
             if frmPedidos.idFidelidade > 0 then
                fidelidade.id_cliente  := frmPedidos.idFidelidade
             else
                fidelidade.id_cliente  := -1;
             fidelidade.tipo           := 'E';
             fidelidade.valor_compra   := valorSemFidelidade-vendaCabecalho.TROCO;
             fidelidade.pontuacao      := 0;
             fidelidade.data_compra    := Date;
             fidelidade.id_funcionario := 0;
             fidelidade.id_Pagamento   := cdsPagamentoidPagamento.AsInteger;
             fidelidade.descricao_Pagamento := trim(cdsPagamentodescricao.AsString);
             TLancamentos.GravarLancamento(fidelidade);

          Finally

             FreeAndNil(fidelidade);

          End;

        Except
        End;

      End;

      if existeFiscal then
         frmPedidos.GerarNFCe(StringParaFloat(Copy(lblValorVenda.Caption,3,10)), vendaCabecalho.NUMERO_PEDIDO);

      vendaCabecalho.ID_CLIENTE       := frmPedidos.idCliente;
      vendaCabecalho.ID_VENDEDOR      := frmPedidos.idFuncionario;
      vendaCabecalho.DATA_HORA_VENDA  := Now;
      vendaCabecalho.VALOR_VENDA      := frmPedidos.totalGeral;
      vendaCabecalho.DESCONTO         := frmPedidos.desconto;
      vendaCabecalho.ACRESCIMO        := frmPedidos.acrescimo;
      vendaCabecalho.VALOR_FINAL      := ValorVenda;
      vendaCabecalho.STATUS           := 'F';
      vendaCabecalho.NOME_CLIENTE     := Copy(Trim(frmPedidos.lblNomeCliente.Caption),1,85);
      vendaCabecalho.CPF_CNPJ_CLIENTE := Trim(SoNumero(frmPedidos.lblCPFCNPJCliente.Caption));

      if existeFiscal then Begin
        vendaCabecalho.CHAVE_NFCE  := Trim(Copy(frmPedidos.ACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID,4,44));
        vendaCabecalho.NUMERO_NFCE := frmPedidos.ACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF;
      End;

      if frmPedidos.idPedido > 0 then
         vendaCabecalho.ID_PEDIDO     := frmPedidos.idPedido
      else
         vendaCabecalho.ID_PEDIDO     := 0;

      TBaseLocalVendaCabecalhoController.GravarVenda(vendaCabecalho);

      frmPedidos.qryItens.First;
      sequencia := 0;

      while not(frmPedidos.qryItens.Eof) do Begin

         Inc(sequencia);
         vendaDetalhe := TBaseLocalVendaDetalheVO.Create;

         vendaDetalhe.ID_VENDA_CABECALHO := vendaCabecalho.ID;
         vendaDetalhe.ID_PRODUTO         := frmPedidos.qryItensidProduto.AsInteger;
         vendaDetalhe.GTIN               := frmPedidos.qryItensgtin.AsString;
         vendaDetalhe.ITEM               := sequencia;
         vendaDetalhe.QUANTIDADE         := frmPedidos.qryItensqtde.AsFloat;
         vendaDetalhe.VALOR_UNITARIO     := frmPedidos.qryItensvlUnit.AsFloat;
         vendaDetalhe.VALOR_TOTAL        := frmPedidos.qryItensvlTotal.AsFloat;
         vendaDetalhe.DESCRICAO_PRODUTO  := Trim(frmPedidos.qryItensdescricao.AsString);
         vendaDetalhe.OBSERVACAO         := Trim(frmPedidos.qryItensobservacao.AsString);

         TBaseLocalVendaDetalheController.GravarVendaDetalhe(vendaDetalhe);

         frmPedidos.qryItens.Next;

      End;

      cdsPagamento.First;

      while Not(cdsPagamento.Eof) do Begin

         tipoPagto := TBaseLocalTotalTipoPagtoVO.Create;

         tipoPagto.ID_VENDA_CABECALHO := vendaCabecalho.ID;
         tipoPagto.ID_FORMA_PAGAMENTO := cdsPagamentoidPagamento.AsInteger;
         tipoPagto.VALOR              := cdsPagamentovalor.AsFloat;

         TBaseLocalTotalTipoPagtoController.GravarTotalTipoPagto(tipoPagto);
         cdsPagamento.Next;

      End;

      if Not(existeFiscal) then
         frmPrincipal.ImprimirVenda(vendaCabecalho.ID);

      if vendaCabecalho.ID_PEDIDO > 0 then
         TBaseLocalPedidoCabecalhoController.MudarStatusPedido(vendaCabecalho.ID_PEDIDO.ToString, 'F');

      if vendaCabecalho.ID_PEDIDO > 0 then
        begin
          qryAUX.Close;
          qryAUX.SQL.Clear;
          qryAUX.SQL.Add('select impresso_cozinha from pedido_cabecalho where id = ' +IntToStr(vendaCabecalho.ID_PEDIDO));
          qryAUX.open;

          if qryAUX.FieldByName('impresso_cozinha').AsString <> 'S' then
            frmPrincipal.ImprimirProdutoCozinhaVenda(vendaCabecalho.ID_PEDIDO);
        end
     else
      frmPrincipal.ImprimirProdutoCozinhaVenda(vendaCabecalho.ID);

   Finally

      FreeAndNil(vendaCabecalho);
      FreeAndNil(vendaDetalhe);

   End;

end;

procedure TfrmFinalizarVenda.Image1Click(Sender: TObject);
begin

   cdsPagamento.Delete;
   valorRecebido := valorRecebido - cdsPagamentovalor.AsFloat;
   AtualizarTotais;
   cdsPagamento.Open;

end;

procedure TfrmFinalizarVenda.Image4Click(Sender: TObject);
begin

   close;

end;

procedure TfrmFinalizarVenda.Image6Click(Sender: TObject);
begin

   if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
      lkpFormaPG.KeyValue := -1;

   EfetuarPagamento;

end;

procedure TfrmFinalizarVenda.JvDBLookupComboEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin

   if Not(Key in [#38..#40]) then
      Key := #0;

end;

procedure TfrmFinalizarVenda.JvDBLookupComboEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin

   if Not(key in[#38..#40]) then
      key := #0;

end;

procedure TfrmFinalizarVenda.lkpFormaPGExit(Sender: TObject);
Var cliente: TClientes;
begin

   if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then
      lkpFormaPG.KeyValue := -1;

   {
   if ((frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S') and (lkpFormaPG.Enabled) and (not(ExisteFidelidade)) and (frmPedidos.statuVenda <> 0)) then Begin
         if not (frmPedidos.idFidelidade > 0) then begin
            prcMsgAdv('Não existe cliente fidelidade informado.');
            lkpFormaPG.SetFocus;
            exit;
         end;
         frmConsultarPagarFidelidade := tfrmConsultarPagarFidelidade.Create(self);
         cliente := TClientes.RetornarPontuacao(frmPedidos.idFidelidade.ToString);
         frmConsultarPagarFidelidade.EdCpfCliFid.Text    := RetornarCPFCNPJcomMascara(Trim(cliente.cpf_cnpj));
         frmConsultarPagarFidelidade.EdNomCliFid.Text    := Trim(cliente.nome);
         frmConsultarPagarFidelidade.EdPntCliFid.Text    := cliente.pontuacao.ToString;
         frmConsultarPagarFidelidade.EdPntDinCliFid.Text := FormatFloat('###,#0.00', cliente.valor_Disponivel);
         frmConsultarPagarFidelidade.EdValDisVen.Text    := FormatFloat('###,#0.00', StringParaFloat(Copy(lblValorFaltante.Caption,3,15))*(cliente.perc_Utilizacao_Pontos/100));

         if StringParaFloat(frmConsultarPagarFidelidade.EdValDisVen.Text) >
                   StringParaFloat(frmConsultarPagarFidelidade.EdPntDinCliFid.Text) then
            frmConsultarPagarFidelidade.EdValDisVen.Text := frmConsultarPagarFidelidade.EdPntDinCliFid.Text;

         frmConsultarPagarFidelidade.ShowModal;
   End else begin
      if ((frmPedidos.idFidelidade = 0) and (frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S') and (frmPedidos.statuVenda <> 0)) then Begin
         prcMsgAdv('Não existe cliente fidelidade informado.');
         lkpFormaPG.SetFocus;
         exit;
      end;
      if ((ExisteFidelidade) and (frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S') and (frmPedidos.statuVenda <> 0)) then Begin
         prcMsgAdv('Já foi lançado um valor com fidelidade.');
         lkpFormaPG.SetFocus;
         Exit;
      End;
   end;
   }
end;

procedure TfrmFinalizarVenda.lkpFormaPGKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cliente: TClientes;
begin

   if key = VK_RETURN then Begin
      if Trim(lkpFormaPG.Text) = '' then Begin
         prcMsgAdv('Informe a forma de pagamento.');
         lkpFormaPG.SetFocus;
         Exit;
      End else if frmPrincipal.qryFormaPGFIDELIDADE.AsString = 'S' then Begin
         if not (frmPedidos.idFidelidade > 0) then begin
            prcMsgAdv('Não existe cliente fidelidade informado.');
            exit;
         end;
         if ExisteFidelidade then begin
            prcMsgAdv('Já foi lançado um valor com fidelidade.');
            exit;
         end;
         frmConsultarPagarFidelidade := tfrmConsultarPagarFidelidade.Create(self);
         cliente := TClientes.RetornarPontuacao(frmPedidos.idFidelidade.ToString);
         frmConsultarPagarFidelidade.EdCpfCliFid.Text    := RetornarCPFCNPJcomMascara(Trim(cliente.cpf_cnpj));
         frmConsultarPagarFidelidade.EdNomCliFid.Text    := Trim(cliente.nome);
         frmConsultarPagarFidelidade.EdPntCliFid.Text    := cliente.pontuacao.ToString;
         frmConsultarPagarFidelidade.EdPntDinCliFid.Text := FormatFloat('###,#0.00', cliente.valor_Disponivel);
         frmConsultarPagarFidelidade.EdValDisVen.Text    := FormatFloat('###,#0.00', StringParaFloat(Copy(lblValorFaltante.Caption,3,15))*(cliente.perc_Utilizacao_Pontos/100));

         if StringParaFloat(frmConsultarPagarFidelidade.EdValDisVen.Text) >
                   StringParaFloat(frmConsultarPagarFidelidade.EdPntDinCliFid.Text) then
            frmConsultarPagarFidelidade.EdValDisVen.Text := frmConsultarPagarFidelidade.EdPntDinCliFid.Text;

         frmConsultarPagarFidelidade.ShowModal;
      End else
         edtRecebido.SetFocus;
   End;

end;

procedure TfrmFinalizarVenda.Timer1Timer(Sender: TObject);
begin

   JvPanel1.Visible := True;
   Panel3.Visible   := FAlse;

   if JvPanel1.Color = $00666666 then
   begin
      JvPanel1.Color      := clWhite;
      JvPanel1.Font.Color := $00FF9933;
   end
   else
   begin
      JvPanel1.Font.Color := clWhite;
      JvPanel1.Color      := $00666666;
   end;

end;

end.
