reportextension 54106 "Sales Order Confirmation" extends "Standard Sales - Order Conf."
{
    dataset
    {
        add("Header")
        {
            column(Picture; CompanyInfo2.Picture) { }

        }
        add(Line)
        {
            column(Location_Code; "Location Code") { }
        }

        modify("Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfo2.GET;
                CompanyInfo2.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("WORD-MscloudExperts")
        {
            Type = WORD;
            LayoutFile = './src/ReportExt/SalesOrderConfirmation.docx';
        }
    }

    var
        CompanyInfo2: Record "Company Information";

}

