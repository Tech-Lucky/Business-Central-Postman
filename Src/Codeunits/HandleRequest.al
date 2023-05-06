codeunit 70000 HandleRequest
{
    trigger OnRun()
    begin

    end;

    procedure SendRequest(Var Postman: Record Postman; var Reponse: Text) Status: text;
    var
        TokenURLTxt: Text[2048];
        // RequestBody: Label 'grant_type=password&username=%1&password=%2';
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeader: HttpHeaders;
        Content: HttpContent;
        Base64Convert: Codeunit "Base64 Convert";
        AuthString: Text;
    begin
        HttpClient.Clear();
        RequestHeader.Clear();
        clear(ResponseMessage);
        Content.Clear();
        //HTTP GET/ POST Request
        case Postman.Method
        of
            Postman.Method::GET:
                begin
                    Set_Authorization(Postman, HttpClient);
                    HttpClient.Get(Postman.URL, ResponseMessage);
                end;
            Postman.Method::POST:
                begin
                    RequestMessage.Method(Format(Postman.method));
                    Set_Authorization(Postman, HttpClient);
                    RequestMessage.SetRequestUri(Postman.URL);
                    Content.GetHeaders(RequestHeader);
                    Content.WriteFrom(Postman.RequestBody);
                    RequestHeader.Remove(Postman.FieldCaption("Content-Type"));
                    IF postman."Content-Type" = Postman."Content-Type"::"X-www-form-urlencoded" THEN
                        RequestHeader.Add(Postman.FieldCaption("Content-Type"), 'application/' + Format(Postman."Content-Type"))
                    else
                        RequestHeader.Add(Postman.FieldCaption("Content-Type"), 'application/' + Format(Postman."Content Format"));
                    RequestMessage.Content := Content;
                    HttpClient.Send(RequestMessage, ResponseMessage);
                end;
            else
                Error('Development is Pending for the Selected Method');
        end;
        ResponseMessage.Content().ReadAs(Reponse);
        IF ResponseMessage.IsSuccessStatusCode then
            Status := 'Success : ' + format(ResponseMessage.HttpStatusCode)
        else
            Status := 'Failed : ' + format(ResponseMessage.HttpStatusCode);
    end;

    local procedure Set_Authorization(Var Postman: Record Postman; var HttpClient: HttpClient)
    var
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        //Creating Authorization Header
        Clear(AuthString);
        Case postman."Authorization Type"
        of
            postman."Authorization Type"::"No Auth":
                exit;
            postman."Authorization Type"::"Basic Auth":
                begin
                    AuthString := StrSubstNo('%1:%2', Postman.Username, Postman.Password);
                    AuthString := Base64Convert.ToBase64(AuthString);
                    AuthString := StrSubstNo('Basic %1', AuthString);
                    HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
                    HttpClient.DefaultRequestHeaders().Add('User-Agent', 'Tech-Lucky_Postman');
                end;
            postman."Authorization Type"::"Brearer Token":
                begin
                    HttpClient.DefaultRequestHeaders().Add('Authorization', StrSubstNo('Bearer %1', Postman.Token));
                    HttpClient.DefaultRequestHeaders().Add('User-Agent', 'Tech-Lucky_Postman');
                end;
            else
                Error('Development is Pending for the Selected Authorization Type');
        end;

    end;
}