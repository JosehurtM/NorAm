reportextension 54110 PickinListByOrderExt extends "Picking List by Order"
{
    dataset
    {
        add("Sales Header")
        {
            column(External_Document_No_; "External Document No.") { }
            column(Picture; CompanyInfo.Picture) { }
        }
        modify("Sales Header")
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
        layout("PickingListByOrder MSC RDL")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/PickinListByOrderExt.rdl';
        }
    }

    var
        CompanyInfoBlanket: Record "Company Information";
}