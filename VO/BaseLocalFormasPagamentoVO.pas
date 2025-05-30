unit BaseLocalFormasPagamentoVO;

interface

type TBaseLocalFormasPagamentoVO = class
  private
    Fid: integer;
    Fstatus: string;
    Fnome: string;
    Fpermite_troco: string;
    Ftipo_pagamento_nfce: integer;
    FEMITIR_FISCAL: String;
    FFIDELIDADE: String;
    procedure Setid(const Value: integer);
    procedure Setnome(const Value: string);
    procedure Setstatus(const Value: string);
    procedure Setpermite_troco(const Value: string);
    procedure Settipo_pagamento_nfce(const Value: integer);
    procedure SetEMITIR_FISCAL(const Value: String);
    procedure SetFIDELIDADE(const Value: String);
  published

   property id: integer read Fid write Setid;
   property status: string read Fstatus write Setstatus;
   property nome: string read Fnome write Setnome;
   property permite_troco: string read Fpermite_troco write Setpermite_troco;
   property tipo_pagamento_nfce: integer read Ftipo_pagamento_nfce write Settipo_pagamento_nfce;
   property EMITIR_FISCAL: String read FEMITIR_FISCAL write SetEMITIR_FISCAL;
   property FIDELIDADE: String read FFIDELIDADE write SetFIDELIDADE;

end;

implementation

{ TBaseLocalFormasPagamentoVO }

procedure TBaseLocalFormasPagamentoVO.SetEMITIR_FISCAL(const Value: String);
begin
  FEMITIR_FISCAL := Value;
end;

procedure TBaseLocalFormasPagamentoVO.SetFIDELIDADE(const Value: String);
begin
  FFIDELIDADE := Value;
end;

procedure TBaseLocalFormasPagamentoVO.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TBaseLocalFormasPagamentoVO.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TBaseLocalFormasPagamentoVO.Setpermite_troco(const Value: string);
begin
  Fpermite_troco := Value;
end;

procedure TBaseLocalFormasPagamentoVO.Setstatus(const Value: string);
begin
  Fstatus := Value;
end;

procedure TBaseLocalFormasPagamentoVO.Settipo_pagamento_nfce(
  const Value: integer);
begin
  Ftipo_pagamento_nfce := Value;
end;

end.
