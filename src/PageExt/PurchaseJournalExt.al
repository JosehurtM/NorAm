// pageextension 54101 PurchaseJournalExt extends "Purchase Journal"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addafter("F&unctions")
//         {

//             action("Consigment Report")
//             {
//                 ApplicationArea = All;
//                 Enabled = ReportVisible;
//                 Image = TestReport;
//                 Caption = 'Consigment Report';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'General Journal Test for Miami ';
//                 Visible = ReportVisible;

//                 trigger OnAction()
//                 var
//                     GJTestReport: Report "Consigment Report MSCE";
//                     GenJournalLine: Record "Gen. Journal Line";
//                 begin
//                     GJTestReport.Run();
//                 end;
//             }

//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ReportVisible := false;
//         if Rec."Journal Template Name" = 'CONSIGNMEN' then begin
//             ReportVisible := true;
//         end else begin
//             ReportVisible := false;
//         end;
//     end;

//     var
//         ReportVisible: Boolean;

//}