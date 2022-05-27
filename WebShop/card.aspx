<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="card.aspx.cs" Inherits="WebShop.card" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <%
      int broj_artikla = Convert.ToInt32(Request.QueryString["id"]);

      Session["Broj_Artikla"] = Convert.ToString(broj_artikla);


      WebShop.webshop zapis_artikal = new WebShop.webshop();
      DataSet ds = new DataSet();

      ds = zapis_artikal.Artikal_Id(broj_artikla);
      %>
    <div class="col-md-12 grid-margin stretch-card">
        <div class="glavno" >
              <div class="card">
                  
                <div class="card-body">
                    <div class="glavnolevo">
                  <h4 class="card-title">Naziv Arikla :</h4>
                
                  <div class="form-group">
                    
                   <% 
                       Response.Write(ds.Tables[0].Rows[0]["Ime"]);

                    %>
                      </div>
            
                  <div class="form-group">
                    <label>Cena :</label>
                   <% 
                       Response.Write(ds.Tables[0].Rows[0]["Cena"]);

                    %> Eura
                  </div>

                         <p class="card-description">
                    Opis Arikla : </code>.
                  </p>
                  <div class="form-group">
                    
                   <% 
                       Response.Write(ds.Tables[0].Rows[0]["Opis"]);

                    %>
                      </div>
            
                  <div class="form-group">
                    <label>Kategorija :</label>
                   <% 
                       Response.Write(ds.Tables[0].Rows[0]["Kategorija_ime"]);

                    %> 
                  </div>

                         <div class="form-group">
                    
                   <% 
                       Response.Write("<img src="+ ds.Tables[0].Rows[0]["slika_ref"] +" width=200 />");

                    %> 
                  </div>
<asp:Button ID="Button1" runat="server" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" Text="Korpa" />                </div>
              </div>
                      </div>
             
        <br />
            <!-- -->
           
           
    
</asp:Content>
