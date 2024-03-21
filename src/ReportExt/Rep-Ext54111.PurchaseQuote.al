reportextension 54111 PurchaseQuote extends "Purchase Quote NA"
{
    dataset
    {
        add("Purchase Header")
        {
            column(Picture; CompanyInfoBlanket.Picture) { }
        }
        add("Purchase Line")
        {
            column(Line_No_; "Line No.") { }
        }

        modify("Purchase Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfoBlanket.GET;
                CompanyInfoBlanket.CALCFIELDS(Picture);
            end;
        }
    }

    rendering
    {
        layout("RDLC-MscloudExperts")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/PurchaseQuote.rdl';
        }
    }
    var
        CompanyInfoBlanket: Record "Company Information";
}
