pageextension 54100 ItemJournalExt extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        moveafter("Location Code"; "Gen. Bus. Posting Group")
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
    }

}