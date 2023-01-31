<%@ Page Title="Web Form Test" Language="C#" AutoEventWireup="true" CodeBehind="WebForm.aspx.cs" Inherits="TelerikWebForm" MasterPageFile="~/Site.Master" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
    
    <%--<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" />--%>

    <div class="jumbotron">
        <h1>LabCorp Coding Test - WebForms</h1>
    </div>
    <script type="text/javascript">
        (function (global, undefined) {
            var test = {};

            function showDialogInitially() {
                var wnd = getModalWindow();
                wnd.show();
                Sys.Application.remove_load(showDialogInitially);
            }

            Sys.Application.add_load(showDialogInitially);

            function getModalWindow() { return $find(test.modalWindowID); }

            global.$modalWindow = test;
        })(window);
        
    </script>

    <telerik:RadCodeBlock runat="server" ID="rdbScripts">
        <script type="text/javascript">
            $modalWindow.modalWindowID = "<%=empWnd.ClientID %>";
        </script>
    </telerik:RadCodeBlock>

    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>--%>
    <telerik:RadWindow RenderMode="Lightweight" ID="empWnd" runat="server" Width="400px" Height="200px" Modal="true" OffsetElementID="main" Style="z-index: 100001;" Visible="False"
        Skin="Outlook" Behaviors="Close,Move" Title="Edit Employee" IconUrl="users16x16.png" VisibleStatusbar="False">
        <ContentTemplate>
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <telerik:RadLabel runat="server" Text="ID: " />
                            </td>
                            <td style="width: 100px">
                                <telerik:RadLabel runat="server" ID="wndEmpIDLbl" Text="" CssClass="top-right" />
                            </td>
                            <td style="width: 160px"></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Type: " />
                            </td>
                            <td>
                                <telerik:RadLabel runat="server" ID="wndEmpTypeLbl" Text="" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Work Days:  
                            </td>
                            <td>
                                <telerik:RadNumericTextBox RenderMode="Lightweight" ID="WorkTxtBx" Enabled="False" Width="70px"
                                    MinValue="0" MaxValue="260" runat="server" ShowSpinButtons="true">
                                    <NumberFormat GroupSeparator="" DecimalDigits="0" />
                                    <ClientEvents OnValueChanged=""></ClientEvents>
                                </telerik:RadNumericTextBox>
                            </td>
                            <td>
                                <telerik:RadButton RenderMode="Lightweight" ID="AddWorkBtn" runat="server" Text="Add Work Days" OnClick="AddWorkBtn_OnClick" Enabled="False" Width="140px"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td>Vac. Days: 
                            </td>
                            <td>
                                <telerik:RadNumericTextBox RenderMode="Lightweight" ID="VacTxtBx" Enabled="False" Width="70px"
                                    MinValue="0" MaxValue="60" runat="server" ShowSpinButtons="true">
                                    <NumberFormat GroupSeparator="" DecimalDigits="2" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td>
                                <telerik:RadButton RenderMode="Lightweight" ID="TakeVacBtn" runat="server" Text="Take Vacation" OnClick="TakeVacBtn_OnClick" Enabled="False" Width="140px"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
            <br />
                    <div style="align-content: center">
                        <b>
                            <telerik:RadLabel ID="ErrorMsg" runat="server" ForeColor="red" Text="" Visible="False"></telerik:RadLabel>
                        </b>
                    </div>
        </ContentTemplate>
    </telerik:RadWindow>
    <div>
        <telerik:RadGrid RenderMode="Auto" ID="EmpRadGrid" OnNeedDataSource="EmpRadGrid_OnNeedDataSource" AllowPaging="True" Width="550px" runat="server" AutoGenerateColumns="False"
            AllowSorting="True" PageSize="30" AllowMultiRowSelection="false" OnSelectedIndexChanged="EmpRadGrid_OnSelectedIndexChanged">
            <ClientSettings Selecting-AllowRowSelect="true" EnablePostBackOnRowClick="true">
            </ClientSettings>
            <MasterTableView DataKeyNames="EmpId">
                <Columns>
                    <telerik:GridBoundColumn UniqueName="EmpId" SortExpression="EmpId" HeaderText="Employee Id" DataField="EmpId">
                        <HeaderStyle Width="75px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="EmployeeType" SortExpression="EmployeeType" HeaderText="Employee Type" DataField="EmployeeType">
                        <HeaderStyle Width="75px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridNumericColumn UniqueName="TotalTakenVacation" SortExpression="TotalTakenVacation" HeaderText="Vacation Taken" DataField="TotalTakenVacation" NumericType="Number" DecimalDigits="2"
                        DataFormatString="{0:### ##0.00}">
                        <HeaderStyle Width="75px" />
                    </telerik:GridNumericColumn>
                    <telerik:GridNumericColumn UniqueName="AccumulatedVacation" SortExpression="AccumulatedVacation" HeaderText="Available Vacation" DataField="AccumulatedVacation" NumericType="Number" DecimalDigits="2"
                        DataFormatString="{0:### ##0.00}">
                        <HeaderStyle Width="75px" />
                    </telerik:GridNumericColumn>
                    <telerik:GridNumericColumn UniqueName="DaysWorked" SortExpression="DaysWorked" HeaderText="Days Worked" DataField="DaysWorked" DecimalDigits="0" NumericType="Number">
                        <HeaderStyle Width="75px" />
                    </telerik:GridNumericColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="true"></Selecting>
            </ClientSettings>
        </telerik:RadGrid>
    </div>
</asp:Content>
