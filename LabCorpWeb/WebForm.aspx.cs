using System;
using System.Linq;
using LabCorpWeb;
using Telerik.Web.UI;

public partial class TelerikWebForm : System.Web.UI.Page
{
    private IEmployee _selectedEmployee;

    protected IEmployee GetSelectedEmployee(int Key)
    {
        return (Employees.AllEmployees.FirstOrDefault(k => k.EmpId == Key));
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // Typically I would have SelectedEmployee passed as a session variable
        // between postbacks - Since in this demo it is just a static collection 
        // of our objects, we can fetch the particular object each time we need
        // it from the index captured in the grid selection
    }

    protected void EmpRadGrid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        EmpRadGrid.DataSource = Employees.GetAllEmployees();
    }

    protected void EmpRadGrid_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        var item = (GridDataItem)EmpRadGrid.SelectedItems[0];
        var key = Convert.ToInt32(item.GetDataKeyValue("EmpId"));

        _selectedEmployee = GetSelectedEmployee(key);

        if (_selectedEmployee == null)
        {
            // We have an issue with the key/object - typically we would raise an exception for it
            // For the sake of this test we will return without doing anything as this SHOULD NOT happen in this limited scenario...
            return;
        }

        wndEmpIDLbl.Text = _selectedEmployee.EmpId.ToString();
        wndEmpTypeLbl.Text = _selectedEmployee.EmployeeType;
        ErrorMsg.Text = "";
        ErrorMsg.Visible = false;

        WorkTxtBx.MaxValue = _selectedEmployee.MaxWorkDays() - _selectedEmployee.DaysWorked;
        WorkTxtBx.Enabled = true;
        AddWorkBtn.Enabled = true;

        VacTxtBx.MaxValue = Math.Round(_selectedEmployee.AccumulatedVacation,7);
        VacTxtBx.Enabled = true;
        TakeVacBtn.Enabled = true;

        empWnd.Visible = true;
    }

    protected void TakeVacBtn_OnClick(object sender, EventArgs e)
    {
        if (VacTxtBx.Value > 0)
        {
            var vacToTake = (float)VacTxtBx.Value;
            GetSelectedEmployee(Convert.ToInt32(wndEmpIDLbl.Text)).TakeVacation(vacToTake);
            
            CloseWindow();
            RebindGrid();
        }
        else
        {
            ErrorMsg.Text = "Please enter a valid vacation taken number...";
            ErrorMsg.Visible = true;
        }
    }

    protected void AddWorkBtn_OnClick(object sender, EventArgs e)
    {
        if (WorkTxtBx.Value > 0)
        {
            var worked = (int)WorkTxtBx.Value;
            GetSelectedEmployee(Convert.ToInt32(wndEmpIDLbl.Text)).Work(worked);
            
            CloseWindow();
            RebindGrid();
        }
        else
        {
            ErrorMsg.Text = "Please enter a valid work day number...";
            ErrorMsg.Visible = true;
        }
    }

    protected void ResetWindow()
    {
        //Reset the edit window...

        VacTxtBx.Text = "";
        WorkTxtBx.Text = "";

        wndEmpIDLbl.Text = "";
        wndEmpTypeLbl.Text = "";

        ErrorMsg.Text = "";
        ErrorMsg.Visible = false;

        VacTxtBx.Enabled = false;
        WorkTxtBx.Enabled = false;
        AddWorkBtn.Enabled = false;
        TakeVacBtn.Enabled = false;
    }

    protected void CloseWindow()
    {
        ResetWindow();
        empWnd.Visible = false;
    }

    protected void RebindGrid()
    {
        EmpRadGrid.Rebind();
    }
}
