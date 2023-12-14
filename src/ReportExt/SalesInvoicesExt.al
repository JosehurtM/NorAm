reportextension 54100 "Sales Invoice Ext" extends "Standard Sales - Invoice"
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
            LayoutFile = './src/ReportExt/SalesInvoice.docx';
        }
    }

    var
        CompanyInfo2: Record "Company Information";

}