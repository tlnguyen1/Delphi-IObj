unit CircularRef;

interface
uses
  LN.Obj, LN.ObjList;

// Not being sexist .. just want to demonstrate the circular reference issue.

type
  TBPerson = class(TBObj)
  public
    Name : string;
    constructor Create(Name : string);
  end;

  TWoman = class;
  TMan = class(TBPerson)
  private
    FPartner: IObj<TWoman>;

    function getPartner: IObj<TWoman>;
    procedure setPartner(const Value: IObj<TWoman>);
  public
    property Partner : IObj<TWoman> read getPartner write setPartner;
  end;

  TWoman = class(TBPerson)
  private
    FPartner: IObj<TMan>;


    function getPartner: IObj<TMan>;
    procedure setPartner(const Value: IObj<TMan>);
  public
    property Partner : IObj<TMan> read getPartner write setPartner;
  end;

  TCouples = class
  private
    fPersonList : IObj<TObjList<TBPerson>>;
    procedure createPersonList;
    procedure populatePersonList;
  public
    constructor Create;
    procedure execute;
  end;



implementation


{ TMan }

function TMan.getPartner: IObj<TWoman>;
begin
  result := FPartner;
end;

procedure TMan.setPartner(const Value: IObj<TWoman>);
begin
  FPartner := Value;
end;

{ TWoman }

function TWoman.getPartner: IObj<TMan>;
begin
  result := FPartner;
end;

procedure TWoman.setPartner(const Value: IObj<TMan>);
begin
  FPartner := Value;
end;


{ TCouples }

constructor TCouples.Create;
begin
  createPersonList;
end;

procedure TCouples.createPersonList;
begin
  fPersonList := TObjList.CreateObjList<TBPerson>;
end;

procedure TCouples.execute;
begin
  populatePersonList;
end;

procedure TCouples.populatePersonList;
var
  m1, m2, m3 : IObj<TMan>;
  w1, w2, w3 : IObj<TWoman>;
begin
  fPersonList.Obj.clear;

  m1 := TObj.Create(TMan.Create('Man 1'));
  m2 := TObj.Create(TMan.Create('Man 1'));
  m3 := TObj.Create(TMan.Create('Man 1'));

  w1 := TObj.Create(TWoman.Create('Woman 1'));
  w2 := TObj.Create(TWoman.Create('Woman 2'));
  w3 := TObj.Create(TWoman.Create('Woman 3'));

  m1.Obj.Partner := w1;
  m2.Obj.Partner := w2;
  m3.Obj.Partner := w3;

  w1.Obj.Partner := m1;
  w2.Obj.Partner := m2;
  w3.Obj.Partner := m3;

  fPersonList.Obj.add(TObj.Create(TBPerson(m1.Obj)));
  fPersonList.Obj.add(TObj.Create(TBPerson(w1.Obj)));
  fPersonList.Obj.add(TObj.Create(TBPerson(m2.Obj)));
  fPersonList.Obj.add(TObj.Create(TBPerson(w2.Obj)));
  fPersonList.Obj.add(TObj.Create(TBPerson(m3.Obj)));
  fPersonList.Obj.add(TObj.Create(TBPerson(w3.Obj)));

end;

{ TBPerson }

constructor TBPerson.Create(Name: string);
begin
  self.Name := Name;
end;

end.
