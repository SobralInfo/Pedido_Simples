unit untPainelRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmPainelRelatorios = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel3: TPanel;
    Label2: TLabel;
    Image1: TImage;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPainelRelatorios: TfrmPainelRelatorios;

implementation

{$R *.dfm}

uses untRelVendasPorPeriodo, untRelProdutosMaisVendidos, untExportarXML,
  untRelVendasPorCFOP;

procedure TfrmPainelRelatorios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmPainelRelatorios.Image1Click(Sender: TObject);
begin

   close;

end;

procedure TfrmPainelRelatorios.SpeedButton1Click(Sender: TObject);
begin
   frmPainelRelatorios.Visible := false;
   Application.CreateForm(TfrmRelVendasPorPeriodo, frmRelVendasPorPeriodo);
   frmRelVendasPorPeriodo.ShowModal;
   frmPainelRelatorios.Visible := true;

end;

procedure TfrmPainelRelatorios.SpeedButton2Click(Sender: TObject);
begin
   frmPainelRelatorios.Visible := false;
   Application.CreateForm(TfrmRelProdutosMaisVendidos, frmRelProdutosMaisVendidos);
   frmRelProdutosMaisVendidos.ShowModal;
   frmPainelRelatorios.Visible := true;
end;

procedure TfrmPainelRelatorios.SpeedButton3Click(Sender: TObject);
begin
   frmPainelRelatorios.Visible := false;
   Application.CreateForm(TfrmExportarXML, frmExportarXML);
   frmExportarXML.ShowModal;
   frmPainelRelatorios.Visible := true;
end;

procedure TfrmPainelRelatorios.SpeedButton4Click(Sender: TObject);
begin
   frmPainelRelatorios.Visible := false;
   Application.CreateForm(TfrmRelVendasPorCFOP, frmRelVendasPorCFOP);
   frmRelVendasPorCFOP.ShowModal;
   frmPainelRelatorios.Visible := true;
end;

end.
