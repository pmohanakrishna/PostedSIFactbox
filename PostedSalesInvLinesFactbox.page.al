page 50100 "MPA Posted SI Lines Factbox"
{
    PageType = ListPart;
    SourceTable = "Sales Invoice Line";
    Caption = 'Posted Sales Invoice Lines';
    RefreshOnActivate = true;
    SourceTableTemporary = true;
    SourceTableView = SORTING("Posting Date", "Line No.") ORDER(Descending);
    ApplicationArea = All;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Quantity; Rec.Quantity) { ApplicationArea = All; }
                field("Unit Price"; Rec."Unit Price") { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(LoadDataFromOnFindRecord());
    end;

    procedure LoadDataFromOnFindRecord(): Boolean
    var
        SalesInvoiceLines: Record "Sales Invoice Line";
        NoFilter: Code[20];
        Counter: Integer;
        CurrentFilterGroup: Integer;
    begin
        Counter := 0;

        CurrentFilterGroup := Rec.FilterGroup();
        Rec.FilterGroup(4);
        NoFilter := Rec.GetFilter("No.");
        Rec.FilterGroup(CurrentFilterGroup);
        Rec.Reset();
        Rec.DeleteAll();
        SalesInvoiceLines.Reset();
        SalesInvoiceLines.SetRange("No.", NoFilter);
        SalesInvoiceLines.SetCurrentKey("Posting Date", "Line No.");
        SalesInvoiceLines.Ascending(false);

        if SalesInvoiceLines.FindSet() then
            repeat
                Rec := SalesInvoiceLines;
                Rec.Insert();
                Counter += 1;
            until (Counter >= 10) or (SalesInvoiceLines.Next() = 0);

        exit(not Rec.IsEmpty());
    end;
}
