reportextension 54109 "Pick Instructions Ext" extends "Pick Instruction"
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
        layout("RDLC-MscloudExperts")
        {
            Type = RDLC;
            LayoutFile = './src/ReportExt/PickInstructionsExt.rdl';
        }
    }

    var
}
