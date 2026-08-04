reportextension 54100 "Sales Invoice Ext" extends "Standard Sales - Invoice"
{
    dataset
    {
        add("Header")
        {
            column(Picture; CompanyInfo2.Picture) { }
            column(PaymentDueDateText; PaymentDueDateText) { }
            column(PenaltyInterestText; PenaltyInterestText) { }
        }

        modify("Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfo2.GET;
                CompanyInfo2.CALCFIELDS(Picture);
            end;

            // OnAfterAfterGetRecord: el reporte base fija CurrReport.Language y FormatRegion en su
            // propio OnAfterGetRecord, asi que el texto se arma despues para que el mes y las
            // etiquetas salgan en el idioma del documento.
            trigger OnAfterAfterGetRecord()
            begin
                PaymentDueDateText := PaymentTermsNotice.GetPaymentDueDateText("Payment Terms Code", "Bill-to Customer No.", "Due Date");
                PenaltyInterestText := PaymentTermsNotice.GetPenaltyInterestText("Payment Terms Code", "Bill-to Customer No.");
            end;
        }

        add(Line)
        {
            column(Description_2; "Description 2") { }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("WORD-MscloudExperts")
        {
            Type = WORD;
            LayoutFile = './src/ReportExt/SalesInvoice.docx';
        }
    }

    var
        CompanyInfo2: Record "Company Information";
        PaymentTermsNotice: Codeunit "Payment Terms Notice MSCE";
        PaymentDueDateText: Text;
        PenaltyInterestText: Text;

}