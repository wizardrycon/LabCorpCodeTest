using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;


namespace LabCorpWeb
{
    public partial class WebForm_Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void EmployeesGridView_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                txtempid.Text = EmployeesGridView.SelectedRow.Cells[0].Text;
                txtemptype.Text = EmployeesGridView.SelectedRow.Cells[1].Text;

                txtworkdays.Text = "";
                txtvacdays.Text = "";

                var selectedEmployee = Employees.AllEmployees.Find(id =>
                    id.EmpId == Convert.ToInt32(EmployeesGridView.SelectedRow.Cells[0].Text));

                var Limit = selectedEmployee.MaxWorkDays() - selectedEmployee.DaysWorked;
                
                if (Limit > 1)
                    txtworkValidator.MaximumValue = Limit.ToString();
                else
                {
                    txtworkValidator.MinimumValue = "0";
                    txtworkValidator.MaximumValue = "0";
                }

            }
            catch (ArgumentException)
            {

            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
             //   throw;
            }

            EmployeesGridView.DataBind();
        }

        protected void EmployeesGridView_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            // If multiple ButtonField column fields are used, use the
                // CommandName property to determine which button was clicked.
                if (e.CommandName == "Select")
                {
                    // Convert the row index stored in the CommandArgument
                    // property to an Integer.
                    int index = Convert.ToInt32(e.CommandArgument);

                    // Get the last name of the selected author from the appropriate
                    // cell in the GridView control.
                    GridViewRow selectedRow = EmployeesGridView.Rows[index];
                    string SelectedEmpID = selectedRow.Cells[0].Text;
                }
        }

        protected void btnaddwork_OnClick(object sender, EventArgs e)
        {
            var selectedEmployee = Employees.AllEmployees.Find(id =>
                id.EmpId == Convert.ToInt32(EmployeesGridView.SelectedRow.Cells[0].Text));

            var WorkDaysToAdd = Convert.ToInt32(txtworkdays.Text);
            if (WorkDaysToAdd > 0 && WorkDaysToAdd <= (selectedEmployee.MaxWorkDays() - selectedEmployee.DaysWorked))
            {
                selectedEmployee.Work(WorkDaysToAdd);
            }

            EmployeesGridView.DataBind();
        }

        protected void btntakevac_OnClick(object sender, EventArgs e)
        {
            
        }
    }
}