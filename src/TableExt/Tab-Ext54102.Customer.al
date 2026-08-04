tableextension 54102 CustomerMSCE extends Customer
{
    fields
    {
        // Cruise lines, shipyards, navieras y entidades de gobierno a las que no se les cobra
        // mora. Sus documentos no imprimen ni la fecha limite ni el aviso de intereses; los
        // Payment Terms (Net 30) siguen saliendo normal.
        field(54100; "Exclude Late Fee Notice MSCE"; Boolean)
        {
            Caption = 'Exclude Payment Notices';
            DataClassification = CustomerContent;
        }
    }
}
