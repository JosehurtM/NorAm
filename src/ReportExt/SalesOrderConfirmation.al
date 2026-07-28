reportextension 54106 "Sales Order Confirmation" extends "Standard Sales - Order Conf."
{
    dataset
    {
        add("Header")
        {
            column(Picture; CompanyInfo2.Picture) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Name_2; "Ship-to Name 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Contac; "Ship-to Contact") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(PaymentDueDateText; PaymentDueDateText) { }
            column(PenaltyInterestText; PenaltyInterestText) { }

        }
        add(Line)
        {
            column(Location_Code; "Location Code") { }
            column(Description_2; "Description 2") { }
        }

        modify("Header")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompanyInfo2.GET;
                CompanyInfo2.CALCFIELDS(Picture);

                if ("Ship-to Country/Region Code" <> '') and ("Ship-to Country/Region Code" <> 'US') then begin
                    "Ship-to County" := '';
                end;

            end;

            // OnAfterAfterGetRecord: el reporte base fija CurrReport.Language en su propio
            // OnAfterGetRecord, asi que el texto se arma despues para que el mes y las etiquetas
            // salgan en el idioma del documento.
            trigger OnAfterAfterGetRecord()
            begin
                PaymentTermsNotice.GetNoticeTexts(
                    "Payment Terms Code", "Due Date", PaymentDueDateText, PenaltyInterestText);
            end;
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
            LayoutFile = './src/ReportExt/SalesOrderConfirmation.docx';
        }
    }

    var
        CompanyInfo2: Record "Company Information";
        PaymentTermsNotice: Codeunit "Payment Terms Notice MSCE";
        PaymentDueDateText: Text;
        PenaltyInterestText: Text;

}

