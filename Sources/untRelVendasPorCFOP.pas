unit untRelVendasPorCFOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, FireDAC.Stan.Intf, unitConfiguracoes,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, RLFilters, RLPDFFilter, Vcl.Imaging.pngimage;

type
  TfrmRelVendasPorCFOP = class(TForm)
    dtpDataIni: TDateTimePicker;
    dtpDataFim: TDateTimePicker;
    Panel1: TPanel;
    rlSintetico: TRLReport;
    qryRel: TFDQuery;
    dtsRel: TDataSource;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    qryAUX: TFDQuery;
    lblPeriodo: TRLLabel;
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
    qryRelCFOP: TStringField;
    qryRelTOTAL: TFloatField;
    RLBand4: TRLBand;
    RLBand6: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand7: TRLBand;
    RLDBResult2: TRLDBResult;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
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
  frmRelVendasPorCFOP: TfrmRelVendasPorCFOP;

implementation

{$R *.dfm}

uses untPrincipal;

procedure TfrmRelVendasPorCFOP.Confirmar;
begin

   if dtpDataIni.Date > dtpDataFim.Date then Begin

      prcMsgAdv('Data inicial não pode ser maior que a data final.');
      Exit;

   End;

   qryRel.Close;
   qryRel.SQL.Clear;
   qryRel.SQL.Add('   SELECT Coalesce(p.cfop,''0000'') as cfop, ');
   qryRel.SQL.Add('          sum(vd.valor_total) as total ');
   qryRel.SQL.Add('     FROM venda_cabecalho vc INNER JOIN venda_detalhe vd ON vc.id = vd.id_venda_cabecalho ');
   qryRel.SQL.Add('                             INNER JOIN produtos p ON vd.id_produto = p.id  ');
   qryRel.SQL.Add('    WHERE vc.status = ''F''  ');

   if chkFiscal.Checked then
      qryRel.SQL.Add('   AND vc.numero_nfce > 0 and vc.chave_nfce <> '''' ');

   qryRel.SQL.Add('      AND vc.data_hora_venda BETWEEN :dtIni AND :dtfim ');
   qryRel.SQL.Add(' group by p.cfop ');
   qryRel.SQL.Add(' ORDER BY p.cfop ');

   qryRel.Params.ParamByName('dtIni').AsDateTime := StrToDateTime(datetostr(dtpDataIni.Date)+' 00:00:00');
   qryRel.Params.ParamByName('dtfim').AsDateTime := StrToDateTime(datetostr(dtpDataFim.Date)+' 23:59:59');
   qryRel.Open;

   if qryRel.IsEmpty then begin
      prcMsgAdv('Nenhum registro localizado no período.');
      exit;
   end;

   lblPeriodo.Caption          := 'Período: '+DateToStr(dtpDataIni.Date)+' à '+DateToStr(dtpDataFim.Date);
   rlSintetico.PreviewModal;

end;

procedure TfrmRelVendasPorCFOP.FormCreate(Sender: TObject);
begin

   dtpDataIni.Date := Date;
   dtpDataFim.Date := Date;

end;

procedure TfrmRelVendasPorCFOP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmRelVendasPorCFOP.Image1Click(Sender: TObject);
begin

   close;

end;

procedure TfrmRelVendasPorCFOP.Image3Click(Sender: TObject);
begin

   Confirmar;

end;

procedure TfrmRelVendasPorCFOP.Image4Click(Sender: TObject);
begin

   close;

end;

end.
