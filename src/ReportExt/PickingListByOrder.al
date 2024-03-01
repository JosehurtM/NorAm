reportextension 54110 PickinListByOrderExt extends "Picking List by Order"
{
    dataset
    {
        add("Sales Header")
        {
            column(External_Document_No_; "External Document No.") { }
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
}