using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class signin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            drzava();
            grad();
            pol();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            webshop upis_kor = new webshop();
            int rez_upis;
            rez_upis = upis_kor.Upis_Korisnika(txtime.Text, txtprezime.Text, txtlozinka.Text, txtemail.Text, dddrzava.SelectedItem.Value, ddgrad.SelectedItem.Value, txtopstina.Text, Convert.ToInt32(txtpostbr.Text), txtadresa.Text, 2, ddpol.SelectedItem.Value);

            if (rez_upis == 0)
            {
                Session["Korisnik_Email"] = txtemail.Text;
                Response.Redirect("default.aspx");
            }
            else
            {
                Response.Redirect("greska.aspx");
            }
        }
        public void drzava ()
        {
            if(!IsPostBack)
            {
                dddrzava.Items.Add("Srbija");
            }
        }
        public void grad()
        {
            if (!IsPostBack)
            {
                ddgrad.Items.Add("Novi Sad");
                ddgrad.Items.Add("Beograd");
                ddgrad.Items.Add("Nis");
                ddgrad.Items.Add("Kragujevac");
                ddgrad.Items.Add("Krajevo");
                ddgrad.Items.Add("Leskovac");
            }
        }
        public void pol()
        {
            if (!IsPostBack)
            {
                ddpol.Items.Add("Musko");
                ddpol.Items.Add("Zensko");
              
            }
        }
    }
}