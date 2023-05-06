table 70000 Postman
{
    DataClassification = ToBeClassified;
    LookupPageId = "Saved Logs List";
    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Method; Enum Methods)
        {
            DataClassification = ToBeClassified;
        }
        field(3; URL; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Authorization Type"; Enum "Authorization Type")
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Content-Type"; Enum "Content-Type")
        {
            Caption = 'Content-Type';
            DataClassification = ToBeClassified;
        }
        field(6; RequestBody; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Username; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Password; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Token; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Access Key"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Key Value"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Add Key"; Option)
        {
            OptionMembers = " ","Header","Query Params";
            DataClassification = ToBeClassified;
        }
        field(13; "Content Format"; Enum "Content Format")
        {
            DataClassification = ToBeClassified;
        }
        field(14; Saved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Output; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        Postman: Record Postman;
    begin
        if Postman.FindLast() then
            EntryNo := Postman.EntryNo + 1
        else
            EntryNo := 1;
        "Authorization Type" := "Authorization Type"::"No Auth";
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}