<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="LabCorpWeb.Employee1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Edit</title>
</head>
<body>
    <form id="EmpEditFrm" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <div>
            <telerik:RadLabel runat="server" Text="Employee ID: "/> 
            <telerik:RadLabel runat="server" ID="EmpIDLbl" Text="" />
        </div>
        <div>
            <telerik:RadLabel runat="server" Text="Employee Type: "/> 
            <telerik:RadLabel runat="server" ID="EmpTypeLbl" Text="" />
        </div>
        <div>
            <telerik:RadTextBox ID="WorkTxtBx" Label="Add Work Days: " runat="server"></telerik:RadTextBox>
            <telerik:RadButton  ID="AddWorkBtn" runat="server" Text="Add Work Days"></telerik:RadButton>
        </div>
        <div>
            <telerik:RadTextBox ID="VacTxtBx" Label="Take Vacation Days: " runat="server"></telerik:RadTextBox>
            <telerik:RadButton  ID="TakeVacBtn" runat="server" Text="Take Vacation Days"></telerik:RadButton>
        </div>
        <br/>
        <div>
            <telerik:RadButton  ID="CloseBtn" runat="server" Text="Close"></telerik:RadButton>
        </div>
    </form>
</body>
</html>
