pageextension 50101 "MPA Sales Order Ext" extends "Sales Order"
{
    layout
    {
        //Add changes to page layout here

        addfirst(factboxes)
        {
            part(PostedSalesInvoiceLinesFactbox; "MPA Posted SI Lines Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Provider = SalesLines;
            }
        }

    }
}