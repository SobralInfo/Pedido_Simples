unit untRelVendasPorPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, FireDAC.Stan.Intf, unitConfiguracoes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, RLFilters, RLPDFFilter, Vcl.Imaging.pngimage;

type
  TfrmRelVendasPorPeriodo = class(TForm)
    dtpDataIni: TDateTimePicker;
    dtpDataFim: TDateTimePicker;
    Panel1: TPanel;
    rlSintetico: TRLReport;
    qryRel: TFDQuery;
    dtsRel: TDataSource;
    qryRelCLIENTE: TStringField;
    qryRelDATA_HORA_VENDA: TSQLTimeStampField;
    qryRelVALOR_VENDA: TFloatField;
    qryRelDESCONTO: TFloatField;
    qryRelACRESCIMO: TFloatField;
    qryRelVALOR_FINAL: TFloatField;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel1: TRLLabel;
    qryAUX: TFDQuery;
    lblQtdeMediaVendas: TRLLabel;
    lblValorMediaVendas: TRLLabel;
    GroupBox1: TGroupBox;
    rdbAnalitico: TRadioButton;
    rdbSintetico: TRadioButton;
    lblPeriodo: TRLLabel;
    RLBand4: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLBand5: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLPDFFilter1: TRLPDFFilter;
    Panel3: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    chkFiscal: TCheckBox;
    procedure Image1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Confirmar;
  end;

var
  frmRelVendasPorPeriodo: TfrmRelVendasPorPeriodo;

implementation

{$R *.dfm}

uses untPrincipal;

procedure TfrmRelVendasPorPeriodo.Confirmar;
Var qtde, valor: double;
begin

   if dtpDataIni.Date > dtpDataFim.Date then Begin

      prcMsgAdv('Data inicial n�o pode ser maior que a data final.');
      Exit;

   End;

   qryRel.Close;
   qryRel.SQL.Clear;

   if rdbAnalitico.Checked then Begin

      qryRel.SQL.Add('      SELECT Coalesce(cl.nome, ''Cliente n�o informado'') AS cliente, ');
      qryRel.SQL.Add('                c.data_hora_venda, ');
      qryRel.SQL.Add('                c.valor_venda, ');
      qryRel.SQL.Add('                c.desconto, ');
      qryRel.SQL.Add('                c.acrescimo, ');
      qryRel.SQL.Add('                c.valor_final ');
      qryRel.SQL.Add('           FROM venda_cabecalho c  ');
      qryRel.SQL.Add('                LEFT JOIN clientes cl ON c.id_cliente = cl.id ');
      qryRel.SQL.Add('          WHERE c.status = ''F'' ');

      if chkFiscal.Checked then
      qryRel.SQL.Add('            AND c.chave_nfce <> '''' AND c.numero_nfce > 0 ');

      qryRel.SQL.Add('            AND c.data_hora_venda BETWEEN :dtIni AND :dtfim ');
      qryRel.SQL.Add('       ORDER BY c.data_hora_venda  ');

   End else Begin

      qryRel.SQL.Add('         SELECT ''TODOS'' AS cliente, ');
      qryRel.SQL.Add('                cast(substring(c.data_hora_venda from 1 for 11) as timestamp) AS data_hora_venda, ');
      qryRel.SQL.Add('                SUM(c.valor_venda) AS valor_venda, ');
      qryRel.SQL.Add('                SUM(c.desconto) AS desconto, ');
      qryRel.SQL.Add('                SUM(c.acrescimo) AS acrescimo, ');
      qryRel.SQL.Add('                SUM(c.valor_final) AS valor_final ');
      qryRel.SQL.Add('           FROM venda_cabecalho c  ');
      qryRel.SQL.Add('                LEFT JOIN clientes cl ON c.id_cliente = cl.id ');
      qryRel.SQL.Add('          WHERE c.status = ''F'' ');
      qryRel.SQL.Add('            AND c.data_hora_venda BETWEEN :dtIni AND :dtfim ');

      if chkFiscal.Checked then
      qryRel.SQL.Add('            AND c.chave_nfce <> '''' AND c.numero_nfce > 0 ');

      qryRel.SQL.Add('       GROUP by cast(substring(c.data_hora_venda from 1 for 11) as timestamp) ');
      qryRel.SQL.Add('       ORDER BY cast(substring(c.data_hora_venda from 1 for 11) as timestamp) ');

   End;

   qryRel.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtpDataIni.Date)+' 00:00:00');
   qryRel.Params.ParamByName('dtfim').AsDateTime := StrToDateTime(datetostr(dtpDataFim.Date)+' 23:59:59');

   qryRel.Open;

   if Not(qryRel.IsEmpty) then Begin

      qryAUX.Close;
      qryAUX.SQL.Clear;
      qryAUX.SQL.Add('   SELECT SUM(c.valor_final) AS valor, ');
      qryAUX.SQL.Add('          count(c.valor_final) AS qtde ');
      qryAUX.SQL.Add('     FROM venda_cabecalho c ');
      qryAUX.SQL.Add('          LEFT JOIN clientes cl ON c.id_cliente = cl.id ');
      qryAUX.SQL.Add('    WHERE c.status = ''F'' ');
      qryAUX.SQL.Add('      AND c.data_hora_venda BETWEEN :dtIni AND :dtfim  ');

      if chkFiscal.Checked then
      qryAUX.SQL.Add('      AND c.chave_nfce <> '''' AND c.numero_nfce > 0 ');

      qryAUX.SQL.Add(' GROUP by cast(substring(c.data_hora_venda from 1 for 11) as timestamp) ');

      qryAUX.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtpDataIni.Date)+' 00:00:00');
      qryAUX.Params.ParamByName('dtfim').AsDateTime := StrToDateTime(datetostr(dtpDataFim.Date)+' 23:59:59');

      qryAUX.Open;

      qtde  := 0.00;
      valor := 0.00;

      while Not(qryAUX.Eof) do Begin

         qtde  := qtde + qryAUX.FieldByName('qtde').AsFloat;
         valor := valor + qryAUX.FieldByName('valor').AsFloat;

         qryAUX.Next;

      End;

      lblQtdeMediaVendas.Caption  := 'Quantidade M�dia de Vendas por dia: '+FormatFloat('#0',qtde/qryAUX.RecordCount);
      lblValorMediaVendas.Caption := 'Valor M�dio de Vendas por dia: '+FormatFloat('###,#0.00',valor/qryAUX.RecordCount);
      lblPeriodo.Caption          := 'Per�odo: '+DateToStr(dtpDataIni.Date)+' � '+DateToStr(dtpDataFim.Date);

      rlSintetico.PreviewModal;

   End else
      prcMsgAdv('Nenhum registro localizado no per�odo.');

end;

procedure TfrmRelVendasPorPeriodo.FormCreate(Sender: TObject);
begin

   dtpDataIni.Date := Date;
   dtpDataFim.Date := Date;

end;

procedure TfrmRelVendasPorPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmRelVendasPorPeriodo.Image1Click(Sender: TObject);
begin

   close;

end;

procedure TfrmRelVendasPorPeriodo.Image3Click(Sender: TObject);
begin

   Confirmar;

end;

procedure TfrmRelVendasPorPeriodo.Image4Click(Sender: TObject);
begin

   close;

end;

end.
