<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
 
    <body>
        <div class="heading-container">
            <h1>SMO</h1>
            <!-- Search Bar -->
            <div class="searchbar-main">
                <form method="post" action="SearchContacts">
                    <div class="search">
                    <input name="search-input" id="search-input" type="text" class="searchTerm" placeholder="Search Number or Name...">
                    <button id="search-button" type="submit" class="searchButton">
                        <i class="fa fa-search"></i>
                    </button>
                    </div>
                </form>
            </div>
        </div>
        
        
        <div class="contact-main">
            <div class="contact-table">
                <!-- Contacts Viewing Table -->
                <table id="mytable" class="table table-bordred table-striped">
                        <thead>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </thead>

                        <tbody>
                        % for contact in contacts:
                            <tr>
                                <td>{{contact[2]}}</td>
                                <td>+91&nbsp{{contact[1]}}</td>
                                <td><button onclick="showEditModal({{contact[0]}}, '{{contact[1]}}','{{contact[2]}}')" id="EditButton" type="button" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" aria-hidden="true"></i></button></td>
                                <td><button onclick="showDeleteModal({{contact[0]}})" id="DeleteButton" type="button" class="btn btn-danger btn-xs" ><i class="fa fa-trash" aria-hidden="true"></i></button></td>
                            </tr>
                        % end
                        </tbody>
                </table>
            </div>

            <!-- App Functional Buttons -->
            <div class="contact-buttons">
                <div class="btn-group">
                    <button type="button" class="btn btn-primary" onclick="location.href = '/AddContact';"><i class="fa fa-plus" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-success" onclick="location.href = '/NewMessage';"><i class="fa fa-commenting" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-info" onclick="location.href = '/';"><i class="fa fa-refresh" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-danger" onclick="location.href = '/QuitApp';"><i class="fa fa-sign-out" aria-hidden="true"></i></button>
                </div>
            </div>
        </div>

        % if ADD_CONTACT:
            <!-- Modal for Adding New Contacts  -->
            % include('add_contact.tpl')
        % end

        % if NEW_MESSAGE:
            <!-- Modal for Message input for sending SMS  -->
            % include('message_box.tpl')
        % end

        <!-- Modal for Confirmation of Contact Removal  -->
        <div id="myModal" class="Deletemodal-overlay">
            <div class="Deletemodal">
                <div class="Deletemodal-headder">
                    <p>Confirmation</p>
                </div>
                <div class="Deletemodal-content">
                    <p>Are you sure you want to Delete this Contact?</p>
                </div>
                <div class="Deletemodal-footer">
                    <button id="delete-button" class="btn btn-outline-danger">Yes</button>
                    <button id="cancel-button" class="btn btn-outline-primary">No</button>
                </div>
            </div>
        </div>

        <!-- Modal To Update Contact  -->
        <div id="edit-modal" class="edit-modal-main">
            <div class="edit-modal-headder">
                <button type="button" id="edit-modal-remove-button" class="btn btn-danger"><i class="fa fa-times-circle-o" aria-hidden="true"></i></button>
            </div>
            <div class="edit-modal-body">
                <section class="get-in-touch">
                <h1 class="title">Update Contact</h1>
                <form class="contact-form row">
                    <div class="form-field col-lg-6">
                        <input name="name" id="edit-name" class="input-text js-input" type="text" required>
                        <label class="label" for="name">Name</label>
                    </div>
        
                    <div class="form-field col-lg-6 ">
                        <input name="number" id="edit-number" class="input-text js-input" type="text" required>
                        <label class="label" for="number">Phone Number</label>
                    </div>
                  
                    <div class="form-field col-lg-12">
                        <input id="edit-submit-button" class="submit-btn" type="button" value="Submit">
                    </div>
                </form>
                </section>
            </div>
            <div class="edit-modal-footer"></div>
        </div>

        <script>
           
            function showDeleteModal(contact_id){
                var modal = document.getElementById("myModal");
                modal.style.display = "block";


                var Deletebtn = document.getElementById("delete-button");
                Deletebtn.onclick = function() {
                    return handleRemoveContact(contact_id);
                }

                var Cancelbtn = document.getElementById("cancel-button");
                Cancelbtn.onclick = function() {
                    modal.style.display = "none"; 
                }
            }

            function showEditModal(id, number, name){
                console.log("Updating Contact: "+name);
                document.getElementById("edit-name").value=name;
                document.getElementById("edit-number").value=number;
                let modal = document.getElementById("edit-modal");
                modal.style.display = "block";

                let RemoveButton = document.getElementById('edit-modal-remove-button')
                RemoveButton.onclick = ()=>{
                    modal.style.display = "none";
                }

                let SubmitButton = document.getElementById('edit-submit-button')
                SubmitButton.onclick = ()=>{
                    console.log("Update Button Clicked")
                    const new_name = document.getElementById("edit-name").value;
                    const new_number = document.getElementById("edit-number").value;
                    handleUpdateContact(id, new_number, new_name);
                    modal.style.display = "none";
                }
                return null;
            }


           function handleRemoveContact(id){
               
                fetch('/RemoveContact/'+id, {
                    method: 'DELETE',
                })
                //Hides the Modal
                var modal = document.getElementById("myModal");
                modal.style.display = "none"; 
                return location.reload();//Reloads the Webpage
            }

            function handleUpdateContact(id, number, name){
                const port = window.location.port;
                let url = new URL(`http://localhost:${port}/UpdateContact/${id}`);
                url.search = new URLSearchParams({
                    number: number,
                    name: name
                });

                return fetch(url, {
                    method: 'PATCH',
                }).then(res=>{
                    if (res.status == 200){
                        alert("Successfully Updated")
                        location.reload();
                    }
                    else{
                        alert("Couldnt Update Contact")
                    }
                });
            }

            function handleSearch(){
                const input = document.getElementById('search-input').value;

                const port = window.location.port;
                let url = new URL(`http://localhost:${port}/SearchContacts`);
                url.search = new URLSearchParams({
                    input: input
                });

                return fetch(url);
            }

           
        </script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Rajdhani:wght@500&display=swap');

            .heading-container{
                background-color: #12232E;
                font-family: 'Quicksand', sans-serif;
                height: 100%;
                margin:0;
            }

            .heading-container h1{
                color: #EEFBFB;
                text-align: center;
            }

            /* Main Table View Styling */
            .contact-main{
                width: 100vw;
                z-index: 0;
                font-family: 'Rajdhani', sans-serif;
            }

            /* Search Bar */

            /*Resize the searchbar-main to see the search bar change!*/
            .searchbar-main{
                width: 100%;
                margin: auto;
                margin-top: 0;
            }

            .search {
            margin: auto;
            width: 99vw;
            position: relative;
            display: flex;
            height: 46px;
            }

            .searchTerm {
            width: 79vw; 
            border: 3px solid #00B4CC;
            border-right: none;
            padding: 5px;
            border-radius: 5px 0 0 5px;
            outline: none;
            color: #9DBFAF;
            }

            .searchTerm:focus{
            color: #00B4CC;
            }

            .searchButton {
            width: 20vw;
            height: 46px;
            border: 1px solid #00B4CC;
            background: #00B4CC;
            text-align: center;
            color: #fff;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 20px;
            }

            .contact-table{
                height: 75vh;
                overflow-y: scroll;
                overflow-x: hidden;
            }
            
            .contact-table td{
                text-align: justify;
                text-justify: inter-word;
                font-family: 'Rajdhani', sans-serif;

            }
            .contact-buttons{
                position: absolute;
                margin: auto;
                background-color: #12232E;

            }
            .contact-buttons button{
                width: 25vw;
                height: 13vh;
                font-size: 30px;
                background-color: #203647;
                color: white;
            }

            /* Delete Modal Contents */
            .Deletemodal-overlay {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100vw; /* Full width */
            height: 100vh; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            .Deletemodal{
                background-color: white;
                height: 30vh;
                width: 80vw;
                margin: auto;
                border-radius: 6px;
                font-family: 'Rajdhani', sans-serif;

            }

            .Deletemodal-headder {
                
                text-align: center;
                font-size: 32px;
                font-weight: bold;
            }

            /* Modal Content */
            .Deletemodal-content {
               
                text-align: center;
                font-weight: 300;
                font-size: 22px;
            }

             /* Modal Content */
            .Deletemodal-footer {
                width: 80vw;
                border-top: 1px solid grey;
            }

            .Deletemodal-footer button{
                margin-top: 20px;
                margin-left: 4vw;
                margin-right: 4vw;
                width: 30vw;
                height: 40px;
            }

            /* The Close Button */
            .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            }

            .close:hover,
            .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
            }


            .modal-center {
                display:table;
                height: 100%;
                width: 100%;
            }
            .modal-align-center {vertical-align: middle;}
            .modal-content {height:inherit;margin: 0 auto;}


           
            /* Edit Contact Modal CSS */
            .edit-modal-main{
                display: none;
                position: Fixed;
                width: 80vw;
                height: 80vh;
                left: 10vw;
                right: 10vw;
                top: 5vw;
                z-index: 2;
                background-color: white;
                box-shadow: -2px 5px 23px -1px rgba(0,0,0,0.75);
            }

            .edit-modal-headder button i{
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
    </body>
</html>