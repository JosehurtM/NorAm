// Textos del aviso de vencimiento e interes por mora que se imprimen en los documentos de venta.
// Centralizado aqui para que la redaccion, la tasa y la lista de terminos de prepago vivan en un
// solo lugar: lo consumen Sales Invoice (54100), Sales Quote (54105) y Order Conf. (54106).
//
// Los clientes marcados (cruise lines, shipyards, navieras, gobierno) no llevan ninguna de las
// dos lineas: su documento queda solo con los Payment Terms, sin fecha limite ni intereses.
codeunit 54120 "Payment Terms Notice MSCE"
{
    /// <summary>
    /// Aviso de vencimiento.
    /// </summary>
    procedure GetPaymentDueDateText(PaymentTermsCode: Code[10]; CustomerNo: Code[20]; DueDate: Date): Text
    begin
        if DueDate = 0D then
            exit('');
        if not ShowPaymentNotice(PaymentTermsCode, CustomerNo) then
            exit('');

        exit(StrSubstNo(PaymentDueDateLbl, Format(DueDate, 0, 4)));
    end;

    /// <summary>
    /// Aviso de interes por mora.
    /// </summary>
    procedure GetPenaltyInterestText(PaymentTermsCode: Code[10]; CustomerNo: Code[20]): Text
    begin
        if not ShowPaymentNotice(PaymentTermsCode, CustomerNo) then
            exit('');

        exit(PenaltyInterestLbl);
    end;

    // Puerta comun a las dos lineas: si el documento es prepagado o el cliente esta excluido,
    // no se imprime ninguna de las dos y solo quedan los Payment Terms.
    local procedure ShowPaymentNotice(PaymentTermsCode: Code[10]; CustomerNo: Code[20]): Boolean
    var
        Customer: Record Customer;
    begin
        if IsPrepaidTerms(PaymentTermsCode) then
            exit(false);
        if Customer.Get(CustomerNo) and Customer."Exclude Late Fee Notice MSCE" then
            exit(false);

        exit(true);
    end;

    // Terminos de prepago: el documento ya esta pagado, asi que no lleva aviso de vencimiento
    // ni de interes por mora. Para excluir mas terminos, agrega su codigo a esta lista.
    local procedure IsPrepaidTerms(PaymentTermsCode: Code[10]): Boolean
    begin
        exit(PaymentTermsCode in ['PP']);
    end;

    var
        PaymentDueDateLbl: Label 'Payment is due by %1';
        // Tasa fija de politica de la empresa. Si cambia, se ajusta aqui y se republica.
        PenaltyInterestLbl: Label 'Late payment will result in an interest rate of 18.00%.';
}
