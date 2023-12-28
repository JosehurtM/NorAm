reportextension 54108 SalesCreditMemoExt extends "Standard Sales - Credit Memo"
{
    dataset
    {

        add(Line)
        {
            column(Line_Discount_Amount; "Line Discount Amount") { }
        }

    }


    rendering
    {
        layout("WORD-MscloudExperts")
        {
            Type = Word;
            LayoutFile = './src/ReportExt/SalesCreditMemo.docx';
        }
    }

}