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
                Caption = 'Consigment Report ';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'General Journal Test for Miami ';

                trigger OnAction()
                var
                // ExcelACH: Codeunit "EXCEL ACH";
                begin
                    // Llama a la función correspondiente en el codeunit ExcelACH.
                    //ExcelACH.PrintACHHeritage(Rec);
                end;
            }

        }
    }

    var
        myInt: Integer;
}