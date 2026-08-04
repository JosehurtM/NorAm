pageextension 54103 CustomerCardMSCE extends "Customer Card"
{
    layout
    {
        // Junto a Fin. Charge Terms Code, que es donde el usuario busca lo relacionado con mora.
        addafter("Fin. Charge Terms Code")
        {
            field("Exclude Late Fee Notice MSCE"; Rec."Exclude Late Fee Notice MSCE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that sales documents for this customer do not print the payment due date or the late payment interest notice. The payment terms are still printed.';
            }
        }
    }
}
