reportextension 54101 "Purchase Order Ext" extends "Purchase Order"
{
    dataset
    {
        add("Purchase Header")
        {
            column(Picture; CompanyInfo.Picture) { }

        }
        modify("Purchase Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }

    }

    rendering
    {
        layout("RDLC-MscloudExperts")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/PurchaseOrderExt.rdl';
        }
    }

    var
        CompanyInfo: Record "Company Information";

}