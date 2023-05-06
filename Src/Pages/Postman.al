page 70000 Postman
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Postman;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            field(Method; Rec.Method)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Method field.';
            }
            field(URL; Rec.URL)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the URL field.';
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    Clear(Response);
                end;
            }

            group(Header)
            {

                field("Authorization Type"; Rec."Authorization Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorization Type field.';
                    trigger OnValidate()
                    var
                    // myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                group("Credientials")
                {
                    Visible = (Rec."Authorization Type" = Rec."Authorization Type"::"Basic Auth") OR (Rec."Authorization Type" = Rec."Authorization Type"::"NTLM Authentication");

                    field(Username; Rec.Username)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Username field.';
                    }
                    field(Password; Rec.Password)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Password field.';
                        ExtendedDatatype = Masked;
                    }
                }
                field(Token; Rec.Token)
                {
                    Visible = (Rec."Authorization Type" = Rec."Authorization Type"::"Brearer Token");
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Token field.';
                }

                field("Content-Type"; Rec."Content-Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Content-Type field.';
                }
                field("Content Format"; Rec."Content Format")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Content Format field.';
                }
            }
            group("Request Body")
            {
                usercontrol(Body; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddInReady(callbackUrl: Text)
                    begin
                        IsReady := true;
                        FillAddInRequest();
                    end;

                    trigger Callback(data: Text)
                    begin
                        Rec.RequestBody := data;

                    end;
                }
            }
            group(UserControlGroup)
            {
                Caption = 'Response';
                Editable = false;
                usercontrol(Response; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Send)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                Image = SendTo;
                trigger OnAction()
                var
                    HandleRequest: Codeunit HandleRequest;
                begin
                    Message(HandleRequest.SendRequest(Rec, response));
                    if Response <> '' then
                        FillAddInResponse();
                end;
            }
            action("Save Data")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                Image = Save;
                trigger OnAction()
                var
                    Postman: Record Postman;
                begin
                    Postman.Get(Rec.EntryNo);
                    Postman.Output := CopyStr(Response, 1, 2048);
                    Postman.Saved := true;
                    Postman.Modify();
                end;
            }
            action("View Saved Logs")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                Image = View;
                trigger OnAction()
                var
                    Postman: Record Postman;
                begin
                    Postman.Reset();
                    Postman.SetRange(Saved, true);
                    if NOT Postman.IsEmpty then
                        Page.RunModal(0, Postman);
                end;
            }
        }
    }

    var
        Response: Text;
        // RequestBody: Text;
        IsReady: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        if IsReady then
            FillAddInRequest();
        FillAddInResponse();
    end;

    trigger OnOpenPage()
    var
        RecPostman: Record Postman;
    begin
        RecPostman.Reset();
        RecPostman.SetRange(Saved, false);
        RecPostman.DeleteAll();
        if Rec.EntryNo = 0 then
            Rec.Insert(true);
    end;

    local procedure FillAddInRequest()
    begin
        CurrPage.Body.SetContent(StrSubstNo('<textarea Id="TextArea" maxlength="%2" style="width:100%;height:100%;resize: none; font-family:"Segoe UI", "Segoe WP", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important; font-size: 10.5pt !important;" OnChange="window.parent.WebPageViewerHelper.TriggerCallback(document.getElementById(''TextArea'').value)">%1</textarea>', Rec.RequestBody, MaxStrLen(Rec.RequestBody)));
    end;

    local procedure FillAddInResponse()
    begin
        CurrPage.Response.SetContent(StrSubstNo('<textarea Id="TextArea" maxlength="%2" style="width:100%;height:100%;resize: none; font-family:"Segoe UI", "Segoe WP", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important; font-size: 10.5pt !important;" OnChange="window.parent.WebPageViewerHelper.TriggerCallback(document.getElementById(''TextArea'').value)">%1</textarea>', Response, MaxStrLen(Response)));
    end;
}