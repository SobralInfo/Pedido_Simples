unit BaseLocalParametrosVO;

interface

Type TBaseLocalParametrosVO = class
  private
     FBASE_LOCAL: String;
     FCAIXA: String;
     FID: integer;
    FTIPO_DESCONTO_PEDIDO: String;
    Fcsc_nfce: String;
    Fid_csc_nfce: String;
    Fserie_nfce: integer;
    Fnumero_nfce: integer;
    Fcertificado_digital: String;
    Ftipo_ambiente: String;
    Fforma_emissao: String;
     procedure SetBASE_LOCAL(const Value: String);
     procedure SetCAIXA(const Value: String);
     procedure SetID(const Value: integer);
    procedure SetTIPO_DESCONTO_PEDIDO(const Value: String);
    procedure Setcertificado_digital(const Value: String);
    procedure Setcsc_nfce(const Value: String);
    procedure Setid_csc_nfce(const Value: String);
    procedure Setnumero_nfce(const Value: integer);
    procedure Setserie_nfce(const Value: integer);
    procedure Setforma_emissao(const Value: String);
    procedure Settipo_ambiente(const Value: String);
  published
     property ID: integer read FID write SetID;
     property BASE_LOCAL: String read FBASE_LOCAL write SetBASE_LOCAL;
     property CAIXA: String read FCAIXA write SetCAIXA;
     property TIPO_DESCONTO_PEDIDO: String read FTIPO_DESCONTO_PEDIDO write SetTIPO_DESCONTO_PEDIDO;
     property certificado_digital: String read Fcertificado_digital write Setcertificado_digital;
     property id_csc_nfce: String read Fid_csc_nfce write Setid_csc_nfce;
     property csc_nfce: String read Fcsc_nfce write Setcsc_nfce;
     property numero_nfce: integer read Fnumero_nfce write Setnumero_nfce;
     property serie_nfce: integer read Fserie_nfce write Setserie_nfce;
     property forma_emissao: String read Fforma_emissao write Setforma_emissao;
     property tipo_ambiente: String read Ftipo_ambiente write Settipo_ambiente;

end;

implementation

{ TBaseLocalParametrosVO }

procedure TBaseLocalParametrosVO.SetBASE_LOCAL(const Value: String);
begin
  FBASE_LOCAL := Value;
end;

procedure TBaseLocalParametrosVO.SetCAIXA(const Value: String);
begin
  FCAIXA := Value;
end;

procedure TBaseLocalParametrosVO.Setcertificado_digital(const Value: String);
begin
  Fcertificado_digital := Value;
end;

procedure TBaseLocalParametrosVO.Setcsc_nfce(const Value: String);
begin
  Fcsc_nfce := Value;
end;

procedure TBaseLocalParametrosVO.Setforma_emissao(const Value: String);
begin
  Fforma_emissao := Value;
end;

procedure TBaseLocalParametrosVO.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TBaseLocalParametrosVO.Setid_csc_nfce(const Value: String);
begin
  Fid_csc_nfce := Value;
end;

procedure TBaseLocalParametrosVO.Setnumero_nfce(const Value: integer);
begin
  Fnumero_nfce := Value;
end;

procedure TBaseLocalParametrosVO.Setserie_nfce(const Value: integer);
begin
  Fserie_nfce := Value;
end;

procedure TBaseLocalParametrosVO.Settipo_ambiente(const Value: String);
begin
  Ftipo_ambiente := Value;
end;

procedure TBaseLocalParametrosVO.SetTIPO_DESCONTO_PEDIDO(const Value: String);
begin
  FTIPO_DESCONTO_PEDIDO := Value;
end;

end.

