unit BaseLocalEmpresaVO;

interface

Type TBaseLocalEmpresaVO = class
  private
    FFONE: string;
    FFANTASIA: string;
    FCNPJ: string;
    FSITE: string;
    FEMAIL: string;
    FRAZAO_SOCIAL: string;
    FBASE_LOCAL: string;
    FID: integer;
    FCELULAR: string;
    FLOGRADOURO: String;
    FBAIRRO: String;
    FCODIGO_UF: Integer;
    FUF: String;
    FCEP: String;
    FNUMERO: String;
    FIE: String;
    FCOMPLEMENTO: String;
    FTIPO_REGIME: Integer;
    FCODIGO_CIDADE: Integer;
    FCIDADE: String;
    procedure SetBASE_LOCAL(const Value: string);
    procedure SetCELULAR(const Value: string);
    procedure SetCNPJ(const Value: string);
    procedure SetEMAIL(const Value: string);
    procedure SetFANTASIA(const Value: string);
    procedure SetFONE(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetRAZAO_SOCIAL(const Value: string);
    procedure SetSITE(const Value: string);
    procedure SetBAIRRO(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCIDADE(const Value: String);
    procedure SetCODIGO_CIDADE(const Value: Integer);
    procedure SetCODIGO_UF(const Value: Integer);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetLOGRADOURO(const Value: String);
    procedure SetNUMERO(const Value: String);
    procedure SetTIPO_REGIME(const Value: Integer);
    procedure SetUF(const Value: String);
  published

   property ID: integer read FID write SetID;
   property CNPJ: string read FCNPJ write SetCNPJ;
   property RAZAO_SOCIAL: string read FRAZAO_SOCIAL write SetRAZAO_SOCIAL;
   property FANTASIA: string read FFANTASIA write SetFANTASIA;
   property FONE: string read FFONE write SetFONE;
   property CELULAR: string read FCELULAR write SetCELULAR;
   property EMAIL: string read FEMAIL write SetEMAIL;
   property SITE: string read FSITE write SetSITE;
   property BASE_LOCAL: string read FBASE_LOCAL write SetBASE_LOCAL;
   property IE: String read FIE write SetIE;
   property CODIGO_CIDADE: Integer read FCODIGO_CIDADE write SetCODIGO_CIDADE;
   property LOGRADOURO: String read FLOGRADOURO write SetLOGRADOURO;
   property NUMERO: String read FNUMERO write SetNUMERO;
   property COMPLEMENTO: String read FCOMPLEMENTO write SetCOMPLEMENTO;
   property BAIRRO: String read FBAIRRO write SetBAIRRO;
   property CIDADE: String read FCIDADE write SetCIDADE;
   property UF: String read FUF write SetUF;
   property CODIGO_UF: Integer read FCODIGO_UF write SetCODIGO_UF;
   property CEP: String read FCEP write SetCEP;
   property TIPO_REGIME: Integer read FTIPO_REGIME write SetTIPO_REGIME;

end;

implementation

{ tBaseLocalEmpresaVO }

procedure TBaseLocalEmpresaVO.SetBAIRRO(const Value: String);
begin
  FBAIRRO := Value;
end;

procedure tBaseLocalEmpresaVO.SetBASE_LOCAL(const Value: string);
begin
  FBASE_LOCAL := Value;
end;

procedure tBaseLocalEmpresaVO.SetCELULAR(const Value: string);
begin
  FCELULAR := Value;
end;

procedure TBaseLocalEmpresaVO.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TBaseLocalEmpresaVO.SetCIDADE(const Value: String);
begin
  FCIDADE := Value;
end;

procedure tBaseLocalEmpresaVO.SetCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

procedure TBaseLocalEmpresaVO.SetCODIGO_CIDADE(const Value: Integer);
begin
  FCODIGO_CIDADE := Value;
end;

procedure TBaseLocalEmpresaVO.SetCODIGO_UF(const Value: Integer);
begin
  FCODIGO_UF := Value;
end;

procedure TBaseLocalEmpresaVO.SetCOMPLEMENTO(const Value: String);
begin
  FCOMPLEMENTO := Value;
end;

procedure tBaseLocalEmpresaVO.SetEMAIL(const Value: string);
begin
  FEMAIL := Value;
end;

procedure tBaseLocalEmpresaVO.SetFANTASIA(const Value: string);
begin
  FFANTASIA := Value;
end;

procedure tBaseLocalEmpresaVO.SetFONE(const Value: string);
begin
  FFONE := Value;
end;

procedure tBaseLocalEmpresaVO.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TBaseLocalEmpresaVO.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TBaseLocalEmpresaVO.SetLOGRADOURO(const Value: String);
begin
  FLOGRADOURO := Value;
end;

procedure TBaseLocalEmpresaVO.SetNUMERO(const Value: String);
begin
  FNUMERO := Value;
end;

procedure tBaseLocalEmpresaVO.SetRAZAO_SOCIAL(const Value: string);
begin
  FRAZAO_SOCIAL := Value;
end;

procedure tBaseLocalEmpresaVO.SetSITE(const Value: string);
begin
  FSITE := Value;
end;

procedure TBaseLocalEmpresaVO.SetTIPO_REGIME(const Value: Integer);
begin
  FTIPO_REGIME := Value;
end;

procedure TBaseLocalEmpresaVO.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
