 <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default_Old.aspx.cs" Inherits="LabCorpWeb.WebForm_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>LabCorp Coding Test - WebForms</h1>
    </div>

    <div class="row">
        <div class="col-md-4">
            <asp:gridview id="EmployeesGridView"
                          datasourceid="EmployeeODS" 
                          autogeneratecolumns="False"
                          AutoGenerateSelectButton="false" 
                          emptydatatext="No data available." 
                          allowpaging="false" 
                          OnSelectedIndexChanged="EmployeesGridView_OnSelectedIndexChanged"
                          OnRowCommand="EmployeesGridView_OnRowCommand"
                          runat="server">
                <Columns>
                <asp:BoundField DataField="EmpId" HeaderText="Employee ID" ><HeaderStyle Width="20"></HeaderStyle></asp:BoundField>
                <asp:BoundField DataField="EmployeeType" HeaderText="Employee Type"><HeaderStyle Width="200"></HeaderStyle></asp:BoundField>
                <asp:BoundField DataField="DaysWorked" HeaderText="Days Worked"><HeaderStyle Width="200"></HeaderStyle></asp:BoundField>
                <asp:BoundField DataField="AccumulatedVacation" HeaderText="Vacation Available"><HeaderStyle Width="200"></HeaderStyle></asp:BoundField>
                    <asp:buttonfield buttontype="Button" 
                                     commandname="Select"
                                     headertext="Select Employee" 
                                     text="Select"/>
                </Columns>                    
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />  
                <SelectedRowStyle BackColor="Teal" ForeColor="Maroon" Font-Bold="True" />  
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />  
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />  
                <AlternatingRowStyle BackColor="White" />  
                <RowStyle BackColor="#EFF3FB" />  
                <EditRowStyle BackColor="#2461BF" />  
            </asp:gridview>

            <asp:objectdatasource
                id="EmployeeODS"
                runat="server"
                selectmethod="GetAllEmployees"
                typename="LabCorpWeb.Employees" />
            
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" Height="200px" Width="300px" style="display:none">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        EmployeeID:<asp:TextBox ID="tbEmployeeID" runat="server"></asp:TextBox> <br/>
                        Reason:<asp:TextBox ID="tbReason" runat="server"></asp:TextBox>
                        <asp:Button ID="btnSubmit" runat="server" Text="Button" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
            </asp:Panel>
            <div style="display: none">
                <asp:Button ID="Button1" runat="server" Text="Button" /></div>

        </div>
        <div class="col-md-4">
        
        <ContentTemplate>
            <asp:TextBox ID="txtempid" runat="server" Style="z-index: 101; left: 365px; position: absolute;top: 251px" ReadOnly="True" Width="150px"></asp:TextBox> 
            
            <asp:TextBox ID="txtemptype" runat="server" Style="z-index: 102; left: 365px; position: absolute;top: 283px" ReadOnly="True" Width="150px"></asp:TextBox>  

            <asp:TextBox ID="txtworkdays" runat="server" Style="z-index: 103; left: 365px; position: absolute; top: 315px" Width="150px" TextMode="Number"></asp:TextBox>  
            
            <asp:RangeValidator ID="txtworkValidator" runat="server" 
                                Style="top: 194px; left: 365px; position: absolute; height: 22px; width: 105px" ForeColor="Red" 
                                ErrorMessage="Invalid Work Day Range" ControlToValidate="txtworkdays" MaximumValue="260" MinimumValue="1" Type="Integer"></asp:RangeValidator>

            <asp:Button ID="btnaddwork" runat="server" Style="z-index: 105; left: 550px; position: absolute;
                                                               top: 315px" Text="Add Work Days" OnClick="btnaddwork_OnClick"/>

            <asp:TextBox ID="txtvacdays" runat="server" Style="z-index: 104; left: 365px; position: absolute; top: 347px" Width="150px" TextMode="Number"></asp:TextBox>  

            <asp:Button ID="btntakevac" runat="server" Style="z-index: 106; left: 550px; position: absolute;
                                                           top: 347px" Text="Take Vacation" OnClick="btntakevac_OnClick"/>

            <asp:Label ID="Label1" runat="server" Style="z-index: 109; left: 290px; position: absolute;
                                                         top: 253px" Text="EmpId"></asp:Label>  
            <asp:Label ID="Label2" runat="server" Style="z-index: 107; left: 290px; position: absolute;  
                                                         top: 287px" Text="Type"></asp:Label>  
            <asp:Label ID="Label3" runat="server" Style="z-index: 108; left: 290px; position: absolute;  
                                                         top: 318px" Text="Work Days"></asp:Label>  
            <asp:Label ID="Label4" runat="server" Style="z-index: 110; left: 290px; position: absolute;  
                                                         top: 349px" Text="Vac. Days"></asp:Label>  
            </ContentTemplate>
        
        </div>
    </div>

</asp:Content>
