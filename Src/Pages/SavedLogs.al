page 70001 "Saved Logs List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Postman;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }

                field(Method; Rec.Method)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Method field.';
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the URL field.';
                }
                field("Authorization Type"; Rec."Authorization Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorization Type field.';
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
                field(Token; Rec.Token)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Token field.';
                }
                field(RequestBody; Rec.RequestBody)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RequestBody field.';
                }
                field(Output; Rec.Output)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output field.';
                }
                field("Add Key"; Rec."Add Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add Key field.';
                }
                field("Access Key"; Rec."Access Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Access Key field.';
                }
                field("Key Value"; Rec."Key Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Value field.';
                    ExtendedDatatype = Masked;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}