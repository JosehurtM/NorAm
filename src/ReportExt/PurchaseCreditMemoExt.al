reportextension 54104 "Purchase Credit Memo Extent" extends "Purchase Credit Memo NA"
{
    dataset
    {
        add("Purch. Cr. Memo Hdr.")
        {
            column(Picture; CompanyInfoBlanket.Picture) { }
        }
        modify("Purch. Cr. Memo Hdr.")
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
            LayoutFile = './src/ReportExt/PurchaseCreditMemo.rdl';
        }
    }

    var

        CompanyInfoBlanket: Record "Company Information";

}