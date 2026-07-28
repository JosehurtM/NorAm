// Textos del aviso de vencimiento e interes por mora que se imprimen en los documentos de venta.
// Centralizado aqui para que la redaccion, la tasa y la lista de terminos de prepago vivan en un
// solo lugar: lo consumen Sales Invoice (54100), Sales Quote (54105) y Order Conf. (54106).
codeunit 54120 "Payment Terms Notice MSCE"
{
    /// <summary>
    /// Arma las dos lineas del aviso de pago. Ambas van juntas: no tiene sentido avisar del
    /// interes por mora sin decir desde cuando corre, asi que o salen las dos o no sale ninguna.
    /// </summary>
    procedure GetNoticeTexts(PaymentTermsCode: Code[10]; DueDate: Date; var PaymentDueDateText: Text; var PenaltyInterestText: Text)
    begin
        if (DueDate <> 0D) and (not IsPrepaidTerms(PaymentTermsCode)) then begin
            PaymentDueDateText := StrSubstNo(PaymentDueDateLbl, Format(DueDate, 0, 4));
            PenaltyInterestText := PenaltyInterestLbl;
        end else begin
            PaymentDueDateText := '';
            PenaltyInterestText := '';
        end;
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
        PenaltyInterestLbl: Label 'Late payment will result in an interest rate of 18.00% per week.';
}
