pageextension 54101 SalesOrder extends "Sales Order"
{
    layout
    {

        modify(Control297)  // Este es el grupo que contiene el campo Ship-to County
        {
            Visible = true;
        }

        modify("Ship-to County")
        {
            Visible = true;
            ApplicationArea = all;
        }
    }
    actions
    {
        modify(ProformaInvoice)
        {
            Visible = false;
        }

        addafter(ProformaInvoice)
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
