using System;
using System.Collections.Generic;

namespace LabCorpWeb
{
    public interface IEmployee
    {
        int EmpId { get;}
        string EmployeeType { get; }

        float AccumulatedVacation { get; }
        int DaysWorked { get; }
        float TotalTakenVacation { get; }

        int MaxWorkDays();
        void Work(int days);
        void TakeVacation(float timeTaken);
    }

    public abstract class Employee : IEmployee
    {
        public int EmpId { get; private set; }

        public abstract int AnnualAccrualRate { get; }
        public abstract string EmpType { get; }

        // I am using float here as it was specific in the instructions
        // I would typically use double 

        public float AccumulatedVacation { get; private set; } = 0;
        public float TotalTakenVacation { get; private set; } = 0;

        public string EmployeeType => EmpType;

        private const int MaxAnnualWorkDays = 260; // Max annual work days
        private float DailyAccrual => (float)Math.Round(((float)AnnualAccrualRate / (float)MaxAnnualWorkDays),7);

        protected Employee()
        {
            this.EmpId = Id.GetNextId();
        }

        public int DaysWorked
        {
            get;
            private set;
        }

        public int MaxWorkDays()
        {
            return MaxAnnualWorkDays;
        }

        public void Work(int days)
        {
            if (days < 0 || days > MaxAnnualWorkDays)
            {
                //days must be between 0 and max days
                throw new ArgumentException("days argument out of range");
            }

            if ((DaysWorked + days) > MaxAnnualWorkDays)
            {
                throw new ArgumentException("value exceeds max total work days");
            }

            DaysWorked += days;
            // Add accrued vacation based on new work days
            AccumulatedVacation += (float)Math.Round((days * DailyAccrual),7);  //Make sure precision is matched across all calculations
        }

        public void TakeVacation(float timeTaken)
        {
            // In testing we have to be careful of precision here (tested as double) - In this scenario I have a failure because the
            // arg passed is:       9.92615384615385 (The rounded value in the control) and the
            // avail vacation is:   9.9261538461538468 (So rounding at 14 precision vs. 16)

            // The control set the max value allowed to the rounded value which exceeds the available vacation 

            // To solve I am going to force rounding when adding to the Vacation Available in the Work method
            
            timeTaken = (float)Math.Round((float)timeTaken, 7);

            if (timeTaken < 0)
            {
                throw new ArgumentException("timeTaken argument cannot be negative");
            }

            if (timeTaken > this.AccumulatedVacation)
            {
                // Throw error - not enough vacation
                throw new ArgumentException("timeTaken argument exceeds available vacation");
            }

            AccumulatedVacation -= timeTaken;
            TotalTakenVacation += timeTaken;
        }
    }

    public class NonExempt : Employee
    {
        public override int AnnualAccrualRate => 10;
        public override string EmpType => "Hourly";

        public NonExempt()
        {
        }
    }

    public class Exempt : Employee
    {
        public override int AnnualAccrualRate => 15;
        public override string EmpType => "Salaried";

        public Exempt()
        {
        }
    }

    public class Manager : Exempt
    {
        public override int AnnualAccrualRate => 30;
        public override string EmpType => "Manager";

        public Manager()
        {
        }
    }

    public static class Id
    {
        private static int _empId = 0;

        public static int GetNextId()
        {
            // Simulate a sequenced PK
            return _empId++;
        }
    }

    public static class Employees
    {
        public static List<IEmployee> AllEmployees = new List<IEmployee>();

        public static List<IEmployee> GetAllEmployees()
        {
            if(AllEmployees.Count > 0)
                return AllEmployees;

            //Instantiate 10 of each class of employee
            for (var i = 0; i < 10; i++)
            {
                AllEmployees.Add(new NonExempt());
                AllEmployees.Add(new Exempt());
                AllEmployees.Add(new Manager());
            }
            return AllEmployees;
        }
    }
}