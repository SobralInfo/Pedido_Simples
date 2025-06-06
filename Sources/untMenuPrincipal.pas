unit untMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, unitConfiguracoes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvgListBox, BaseLocalUsuariosController;

type
  TfrmMenuPrincipal = class(TForm)
    Panel3: TPanel;
    Label2: TLabel;
    Panel1: TPanel;
    listaMenuOperacoes: TJvgListBox;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarPedidosPendentes;
    procedure CarregarPedidosCancelados;
    procedure CancelarVenda;
    procedure Suprimento;
    procedure Sangria;
    procedure FechamentoDoCaixa;
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

{$R *.dfm}

uses untPedidosPendentes, untCadastrarSangria, untCadastrarSuprimento,
  untFechamentoCaixa, untPedidosCancelados, untCancelamentoDeVenda,
  untPrincipal;

procedure TfrmMenuPrincipal.CancelarVenda;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(frmPrincipal.idUser, 'filtro_acesso_canc_venda') = false then Begin
      prcMsgAdv('Usu�rio sem permiss�o de acesso a fun��o.');
      Exit;
   End;

   Visible := False;
   Application.CreateForm(TfrmCancelamentoDeVenda, frmCancelamentoDeVenda);
   frmCancelamentoDeVenda.ShowModal;
   Visible := True;

end;

procedure TfrmMenuPrincipal.CarregarPedidosCancelados;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(frmPrincipal.idUser, 'filtro_acesso_ped_cancelados') = false then Begin
      prcMsgAdv('Usu�rio sem permiss�o de acesso a fun��o.');
      Exit;
   End;

   Application.CreateForm(TfrmPedidosCancelados, frmPedidosCancelados);
   frmPedidosCancelados.Showmodal;

end;

procedure TfrmMenuPrincipal.CarregarPedidosPendentes;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(frmPrincipal.idUser, 'filtro_acesso_ped_ativos') = false then Begin
      prcMsgAdv('Usu�rio sem permiss�o de acesso a fun��o.');
      Exit;
   End;

   Application.CreateForm(TfrmPedidosPendentes, frmPedidosPendentes);
   frmPedidosPendentes.ShowModal;

end;

procedure TfrmMenuPrincipal.FechamentoDoCaixa;
begin

   if TBaseLocalUsuariosController.VerificarPermissao(frmPrincipal.idUser, 'filtro_acesso_fechamento') = false then Begin
      prcMsgAdv('Usu�rio sem permiss�o de acesso a fun��o.');
      Exit;
   End;

   Visible := False;
   Application.CreateForm(TfrmFechamentoCaixa, frmFechamentoCaixa);
   frmFechamentoCaixa.showModal;
   Visible := True;

end;

procedure TfrmMenuPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case key of

      VK_ESCAPE: close;

   end;

end;

procedure TfrmMenuPrincipal.FormShow(Sender: TObject);
begin

   listaMenuOperacoes.SetFocus;

end;

procedure TfrmMenuPrincipal.listaMenuOperacoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   if key = VK_RETURN then Begin

      case listaMenuOperacoes.ItemIndex of

         0: CarregarPedidosPendentes;
         1: CarregarPedidosCancelados;
         3: CancelarVenda;
         4: FechamentoDoCaixa;
         5: Suprimento;
         6: Sangria;

      end;

   End;

end;

procedure TfrmMenuPrincipal.Sangria;
begin

   Visible := False;
   Application.CreateForm(TfrmCadastrarSangria, frmCadastrarSangria);
   frmCadastrarSangria.ShowModal;
   Visible := True;

end;

procedure TfrmMenuPrincipal.Suprimento;
begin

   Visible := False;
   Application.CreateForm(TfrmCadastrarSuprimento, frmCadastrarSuprimento);
   frmCadastrarSuprimento.ShowModal;
   Visible := True;

end;

end.
