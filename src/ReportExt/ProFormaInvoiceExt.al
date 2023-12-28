reportextension 54107 ProFormaInvoiceExt extends "Standard Sales - Pro Forma Inv"
{
    dataset
    {
        add("Header")
        {
            column(SalesEmail; SalesEmail) { }

        }

        modify("Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesPeople: Record "Salesperson/Purchaser";
            begin
                SalesPeople.Reset();
                SalesPeople.SetRange(Code, "Salesperson Code");
                if SalesPeople.FindLast() then begin
                    SalesEmail := SalesPeople."E-Mail";
                end;
            end;
        }
    }
    rendering
    {
        layout("WORD-MscloudExperts")
        {
            Type = WORD;
            LayoutFile = './src/ReportExt/ProFormaInvoice.docx';
        }
    }

    var
        SalesEmail: Text;
}
