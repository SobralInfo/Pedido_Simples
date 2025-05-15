unit BaseLocalProdutosVO;

interface

Type TBaseLocalProdutosVO = class
  private
    Fvalor_unitario: double;
    Fcodigo_barras: string;
    Fdescricao: string;
    Fid: integer;
    Fstatus: string;
    Fqtde_estoque: double;
    Fid_unidade: integer;
    Freferencia: string;
    FImprimirCozinha: String;
    FCST_PIS: String;
    FCST_COFINS: String;
    FTAXA_PIS: Double;
    FTAXA_COFINS: Double;
    FCEST: String;
    FCFOP: String;
    FCST_CSOSN: String;
    FNCM: String;
    FORIGEM: integer;
    FTAXA_ICMS: Double;
    FFISCAL: String;
    procedure Setcodigo_barras(const Value: string);
    procedure Setdescricao(const Value: string);
    procedure Setid(const Value: integer);
    procedure Setid_unidade(const Value: integer);
    procedure Setqtde_estoque(const Value: double);
    procedure Setreferencia(const Value: string);
    procedure Setstatus(const Value: string);
    procedure Setvalor_unitario(const Value: double);
    procedure SetImprimirCozinha(const Value: String);
    procedure SetCEST(const Value: String);
    procedure SetCFOP(const Value: String);
    procedure SetCST_COFINS(const Value: String);
    procedure SetCST_CSOSN(const Value: String);
    procedure SetCST_PIS(const Value: String);
    procedure SetNCM(const Value: String);
    procedure SetORIGEM(const Value: integer);
    procedure SetTAXA_COFINS(const Value: Double);
    procedure SetTAXA_ICMS(const Value: Double);
    procedure SetTAXA_PIS(const Value: Double);
    procedure SetFISCAL(const Value: String);
  published

   property id: integer read Fid write Setid;
   property status: string read Fstatus write Setstatus;
   property descricao: string read Fdescricao write Setdescricao;
   property qtde_estoque: double read Fqtde_estoque write Setqtde_estoque;
   property referencia: string read Freferencia write Setreferencia;
   property id_unidade: integer read Fid_unidade write Setid_unidade;
   property codigo_barras: string read Fcodigo_barras write Setcodigo_barras;
   property valor_unitario: double read Fvalor_unitario write Setvalor_unitario;
   property ImprimirCozinha: String read FImprimirCozinha write SetImprimirCozinha;
   property NCM: String read FNCM write SetNCM;
   property CEST: String read FCEST write SetCEST;
   property TAXA_PIS: Double read FTAXA_PIS write SetTAXA_PIS;
   property TAXA_COFINS: Double read FTAXA_COFINS write SetTAXA_COFINS;
   property TAXA_ICMS: Double read FTAXA_ICMS write SetTAXA_ICMS;
   property CST_CSOSN: String read FCST_CSOSN write SetCST_CSOSN;
   property CST_PIS: String read FCST_PIS write SetCST_PIS;
   property CST_COFINS: String read FCST_COFINS write SetCST_COFINS;
   property ORIGEM: integer read FORIGEM write SetORIGEM;
   property CFOP: String read FCFOP write SetCFOP;
   property FISCAL: String read FFISCAL write SetFISCAL;

end;

implementation

{ TBaseLocalProdutosVO }

procedure TBaseLocalProdutosVO.SetCEST(const Value: String);
begin
  FCEST := Value;
end;

procedure TBaseLocalProdutosVO.SetCFOP(const Value: String);
begin
  FCFOP := Value;
end;

procedure TBaseLocalProdutosVO.Setcodigo_barras(const Value: string);
begin
  Fcodigo_barras := Value;
end;

procedure TBaseLocalProdutosVO.SetCST_COFINS(const Value: String);
begin
  FCST_COFINS := Value;
end;

procedure TBaseLocalProdutosVO.SetCST_CSOSN(const Value: String);
begin
  FCST_CSOSN := Value;
end;

procedure TBaseLocalProdutosVO.SetCST_PIS(const Value: String);
begin
  FCST_PIS := Value;
end;

procedure TBaseLocalProdutosVO.Setdescricao(const Value: string);
begin
  Fdescricao := Value;
end;

procedure TBaseLocalProdutosVO.SetFISCAL(const Value: String);
begin
  FFISCAL := Value;
end;

procedure TBaseLocalProdutosVO.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TBaseLocalProdutosVO.Setid_unidade(const Value: integer);
begin
  Fid_unidade := Value;
end;

procedure TBaseLocalProdutosVO.SetImprimirCozinha(const Value: String);
begin
  FImprimirCozinha := Value;
end;

procedure TBaseLocalProdutosVO.SetNCM(const Value: String);
begin
  FNCM := Value;
end;

procedure TBaseLocalProdutosVO.SetORIGEM(const Value: integer);
begin
  FORIGEM := Value;
end;

procedure TBaseLocalProdutosVO.Setqtde_estoque(const Value: double);
begin
  Fqtde_estoque := Value;
end;

procedure TBaseLocalProdutosVO.Setreferencia(const Value: string);
begin
  Freferencia := Value;
end;

procedure TBaseLocalProdutosVO.Setstatus(const Value: string);
begin
  Fstatus := Value;
end;

procedure TBaseLocalProdutosVO.SetTAXA_COFINS(const Value: Double);
begin
  FTAXA_COFINS := Value;
end;

procedure TBaseLocalProdutosVO.SetTAXA_ICMS(const Value: Double);
begin
  FTAXA_ICMS := Value;
end;

procedure TBaseLocalProdutosVO.SetTAXA_PIS(const Value: Double);
begin
  FTAXA_PIS := Value;
end;

procedure TBaseLocalProdutosVO.Setvalor_unitario(const Value: double);
begin
  Fvalor_unitario := Value;
end;

end.
