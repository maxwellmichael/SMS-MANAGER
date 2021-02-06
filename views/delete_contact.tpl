

<div class="modal-main">
    <div class="modal-headder"><button type="button" class="btn btn-danger" onclick="location.href = '/';"><i class="fa fa-times-circle-o" aria-hidden="true"></i>
</button>
</div>
    <div class="modal-body">
        <section class="get-in-touch">
        <h1 class="title">New Contact</h1>
        <form method="post" action="SaveContact" class="contact-form row">
            <div class="form-field col-lg-6">
                <label class="label" for="name">Are you sure you want to delete this Contact ?</label>
            </div>
            <div class="form-field col-lg-12">
               <button class="btn btn-success"><i class="fa fa-check" aria-hidden="true"></i></button>
               <button class="btn btn-danger"><i class="fa fa-times" aria-hidden="true"></i></button>
            </div>
        </form>
        </section>
    </div>
    <div class="modal-footer"></div>
<div>

<style>
.modal-main{
    position: fixed;
    width: 80vw;
    height: 80vh;
    left: 10vw;
    right: 10vw;
    top: 25vw;
    z-index: 99999;
    background-color: white;
    box-shadow: -2px 5px 23px -1px rgba(0,0,0,0.75);
}

.modal-headder button i{
  font-size: 26px;
  color: black;
}

.get-in-touch {
  width: 100%;
  margin: 30px auto;
  position: relative;

}
.get-in-touch .title {
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 3px;
  font-size: 2.2em;
  line-height: 48px;
  padding-bottom: 48px;
     color: #5543ca;
    background: #5543ca;
    background: -moz-linear-gradient(left,#f4524d  0%,#5543ca 100%) !important;
    background: -webkit-linear-gradient(left,#f4524d  0%,#5543ca 100%) !important;
    background: linear-gradient(to right,#f4524d  0%,#5543ca  100%) !important;
    -webkit-background-clip: text !important;
    -webkit-text-fill-color: transparent !important;
}

.contact-form .form-field {
  position: relative;
  margin: 32px 0;
}
.contact-form .input-text {
  display: block;
  width: 100%;
  height: 36px;
  border-width: 0 0 2px 0;
  border-color: #5543ca;
  font-size: 14px;
  line-height: 26px;
  font-weight: 400;
}
.contact-form .input-text:focus {
  outline: none;
}
.contact-form .input-text:focus + .label,
.contact-form .input-text.not-empty + .label {
          transform: translateY(-12px);
}
.contact-form .label {
  position: absolute;
  left: 20px;
  bottom: 26px;
  font-size: 18px;
  line-height: 26px;
  font-weight: 400;
  color: #5543ca;
  cursor: text;
  transition: -webkit-transform .2s ease-in-out;
  transition: transform .2s ease-in-out;
  transition: transform .2s ease-in-out, 
  -webkit-transform .2s ease-in-out;
}
.contact-form .submit-btn {
  display: inline-block;
  background-color: #000;
   background-image: linear-gradient(125deg,#a72879,#064497);
  color: #fff;
  text-transform: uppercase;
  letter-spacing: 2px;
  font-size: 16px;
  padding: 8px 16px;
  border: none;
  width: 40vw;
  margin-left: 30vw;
  cursor: pointer;
}


</style>
 