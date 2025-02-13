pageextension 54102 SalesOrderList extends "Sales Order List"
{
    actions
    {

        addafter("Work Order")
        {
            action(CommercialInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Commercial Invoice';
                Ellipsis = true;
                Image = ViewPostedOrder;
                ToolTip = 'View or print the Commercial Invoice.';

                trigger OnAction()
                begin
                    PrintProformaSalesInvoice(Rec);
                end;
            }
        }

        // Luego, añadimos la referencia en el área promocionada
        addafter("Work Order_Promoted")
        {
            actionref(CommercialInvoiceRef; CommercialInvoice)
            {
            }
        }
    }


    procedure PrintProformaSalesInvoice(SalesHeader: Record "Sales Header")
    var
        ReportSelections: Record "Report Selections";
    begin
        SalesHeader.SetRecFilter();
        ReportSelections.PrintForCust(
            ReportSelections.Usage::"Pro Forma S. Invoice", SalesHeader, SalesHeader.FieldNo("Bill-to Customer No."));
    end;
}
