reportextension 54103 "Purchase Invoice Extent" extends "Purchase Invoice NA"
{
    dataset
    {
        add("Purch. Inv. Header")
        {
            column(Picture; CompanyInfoBlanket.Picture) { }
        }
        modify("Purch. Inv. Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfoBlanket.GET;
                CompanyInfoBlanket.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("RDLC-MscloudExperts")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/PurchaseInvoice.rdl';
        }
    }

    var

        CompanyInfoBlanket: Record "Company Information";

}