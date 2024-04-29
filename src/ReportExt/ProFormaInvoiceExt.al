reportextension 54107 ProFormaInvoiceExt extends "Standard Sales - Pro Forma Inv"
{
    dataset
    {
        add("Header")
        {
            column(SalesEmail; SalesEmail) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Name_2; "Ship-to Name 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Contac; "Ship-to Contact") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }

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
