unit DImages;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TdmImages = class(TDataModule)
    ImageCollection1: TImageCollection;
    im32: TVirtualImageList;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  dmImages: TdmImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
