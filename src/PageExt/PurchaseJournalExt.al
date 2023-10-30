pageextension 54101 PurchaseJournalExt extends "Purchase Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("F&unctions")
        {

            action("Consigment Report")
            {
                ApplicationArea = All;
                Image = TestReport;
                Caption = 'Consigment Report';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'General Journal Test for Miami ';

                trigger OnAction()
                var
                    GJTestReport: Report "Consigment Report MSCE";
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    // if GenJournalLine."Journal Template Name" <> 'CONSIGNMEN' then begin
                    //     Message('Para ejecutar este mensaje el Gen Journal Template debe ser "Consigment');
                    // end else begin
                    //GJTestReport.Run();
                    //end;
                    GJTestReport.Run(); // Como podria hacer esta condicion
                end;
            }

        }
    }

    var
        myInt: Integer;
}