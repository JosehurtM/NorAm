tableextension 54101 PurchaseHeader extends "Purchase Header"
{
    trigger OnAfterInsert()
    begin

        if "Document Type" = "Document Type"::Order then begin
            Rec.Validate("Posting No.", Rec."No.");
            Rec.Modify(true);
        end;
    end;
}
