<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="WebShop.signin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Star Admin2 </title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="../../vendors/feather/feather.css">
  <link rel="stylesheet" href="../../vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="../../vendors/typicons/typicons.css">
  <link rel="stylesheet" href="../../vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../../images/favicon.png" />
<body>
    <form id="form1" runat="server">
      <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                Slika
              </div>
              <h4>Korisnicki Panel</h4>
              <h6 class="fw-light">Upisite se...</h6>
              <form class="pt-3">
                <div class="form-group">
             

                 <asp:TextBox ID="txtime" runat="server" type="text" class="form-control form-control-lg"  placeholder="Korisničko ime"></asp:TextBox>
                </div>
                <div class="form-group">
                <asp:TextBox ID="txtprezime" runat="server" type="text" class="form-control form-control-lg"  placeholder="Prezime"></asp:TextBox>
                </div>
                    <div class="form-group">
                <asp:TextBox ID="txtlozinka" runat="server" type="password" class="form-control form-control-lg"  placeholder="Lozinka"></asp:TextBox>
                </div>
                    <div class="form-group">
                <asp:TextBox ID="txtemail" runat="server" type="email" class="form-control form-control-lg"  placeholder="Email"></asp:TextBox>
                </div>
                    <div class="form-group">Drzava:
                        <asp:DropDownList ID="dddrzava" runat="server"></asp:DropDownList>
                </div>
                     <div class="form-group">Grad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                        <asp:DropDownList ID="ddgrad" runat="server"></asp:DropDownList>
                </div>
                  <div class="form-group">
              <asp:TextBox ID="txtopstina" runat="server" type="text" class="form-control form-control-lg"  placeholder="Opstina"></asp:TextBox>
                </div>
                      <div class="form-group">
              <asp:TextBox ID="txtpostbr" runat="server" type="text" class="form-control form-control-lg"  placeholder="Postanski broj"></asp:TextBox>
                </div>
                      <div class="form-group">
              <asp:TextBox ID="txtadresa" runat="server" type="text" class="form-control form-control-lg"  placeholder="Adresa"></asp:TextBox>
                </div>
                       <div class="form-group">Pol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                        <asp:DropDownList ID="ddpol" runat="server"></asp:DropDownList>
                </div>

                <div class="mt-3">
                  <asp:Button ID="Button1" runat="server" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" Text="Sign In" OnClick="Button1_Click"/>
                </div>
                <div class="my-2 d-flex justify-content-between align-items-center">
                  <div class="form-check">
                    <label class="form-check-label text-muted">
                    
                  </div>
                 
                </div>
                <div class="mb-2">
                  
                </div>
               
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="../../vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="../../vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="../../js/off-canvas.js"></script>
  <script src="../../js/hoverable-collapse.js"></script>
  <script src="../../js/template.js"></script>
  <script src="../../js/settings.js"></script>
  <script src="../../js/todolist.js"></script>
    </form>
</body>
</html>
