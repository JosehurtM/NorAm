reportextension 54105 SalesQuoteExt extends "Standard Sales - Quote"
{
    dataset
    {
        add("Header")
        {
            column(Picture; CompanyInfo2.Picture) { }
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
            LayoutFile = './src/ReportExt/SalesQuote.docx';
        }
    }

    var
        CompanyInfo2: Record "Company Information";

}
