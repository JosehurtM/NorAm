reportextension 54102 "Blanket Purchase Order Ext" extends "Blanket Purchase Order"
{
    dataset
    {
        add("Purchase Header")
        {
            column(Picture; CompanyInfoBlanket.Picture) { }
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

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("RDLC-MscloudExperts")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/BlanketPO.rdl';
        }
    }

    var

        CompanyInfoBlanket: Record "Company Information";

}