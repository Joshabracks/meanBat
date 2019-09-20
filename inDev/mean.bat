call ng new public --style=css
call npm init -y
call npm install express --save
call npm install socket.io --save
call npm install express-session --save
call npm install mongoose --save
type nul > server.js
:: BUILD server.js
echo const express = require('express'), app = express(), session = require('express-session'); >> server.js
echo app.use(express.static(__dirname + "/public/dist/public")); >> server.js
echo app.use(express.json()); >> server.js
echo app.use(session({secret: 'keyboardkitteh', resave: false, saveUninitialized: true, cookie: { maxAge: null }})); >> server.js
echo const server = app.listen(1337); >> server.js
echo require('./server/config/routes')(app); >> server.js
mkdir server
cd server
mkdir config
cd config
type nul > mongoose.js
:: BUILD mongoose.js
echo const mongoose = require('mongoose'); >> mongoose.js
echo mongoose.connect('mongodb://localhost/db', { useNewUrlParser: true, useUnifiedTopology: true }); >> mongoose.js
echo const fs = require('fs'); >> mongoose.js
echo const path = require('path'); >> mongoose.js
echo var models_path = path.join(__dirname, './../models'); >> mongoose.js
echo fs.readdirSync(models_path).forEach(function (file) { >> mongoose.js
echo     if (file.indexOf('.js') ^>= 0){ >> mongoose.js
echo        require('./../models/' + file); >> mongoose.js
echo    } >> mongoose.js
echo }); >> mongoose.js
type nul > routes.js
:: BUILD routes.js || this serves to public/src/app/http.service.ts
echo module.exports = function (app) { >> routes.js
echo const path = require('path'); >> routes.js
echo const main = require("../controllers/main"); >> routes.js
echo app.get('/', function(req, res){main.index(req, res)}); >> routes.js
echo app.get('/users', function (req, res){main.getUsers(req, res)}); >> routes.js
echo // || ALWAYS LAST || >> routes.js
echo app.all("*", (req,res,next) =^> {  >> routes.js
echo     console.log('inside all: ', req.params); >> routes.js
echo     res.sendFile(path.resolve("./public/dist/public/index.html")); >> routes.js
echo   }); >> routes.js
echo // || ALWAYS LAST || >> routes.js
echo }  >> routes.js
cd ..
mkdir controllers
cd controllers
type nul > main.js
:: BUILD main.js || this serves to routes.js
echo require("../config/mongoose"); >> main.js
echo module.exports = { >> main.js
echo     index: function (req, res){ >> main.js
echo 		res.render('index'); >> main.js
echo     }, >> main.js
echo   getUsers: function (req, res) { >> main.js
echo     User.find() >> main.js
echo       .then(data =^> { >> main.js
echo         res.json(data); >> main.js
echo       }) >> main.js
echo       .catch(err =^> { >> main.js
echo         console.log(err); >> main.js
echo       }) >> main.js
echo   }, >> main.js
echo }  >> main.js
cd ..
mkdir models
cd models
type nul > user.js
:: BUILD user.js || This is the user model ||
echo const mongoose = require('mongoose'); >> user.js
echo UserSchema = new mongoose.Schema({  >> user.js
echo     fname: String,  >> user.js
echo     lname: String,  >> user.js
echo     email: String,  >> user.js
echo     password: String,  >> user.js
echo }, { timestamps: true });  >> user.js
echo User = mongoose.model('User', UserSchema);  >> user.js
cd ..
cd ..
mkdir static
cd static
type nul style.css
echo *{ >> style.css
echo     padding: 0px; >> style.css
echo     margin: 0px; >> style.css
echo     font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; >> style.css
echo     box-sizing: border-box; >> style.css
echo } >> style.css
cd ..
mkdir views
cd views
type nul > index.ejs
:: This creates the ejs index page || DEPRECATED when using an angular app
echo ^<!DOCTYPE html^> >> index.ejs
echo ^<html lang="en"^> >> index.ejs
echo ^<head^> >> index.ejs
echo     ^<meta charset="UTF-8"^> >> index.ejs
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> index.ejs
echo     ^<meta http-equiv="X-UA-Compatible" content="ie=edge"^> >> index.ejs
echo     ^<title^>Document^</title^> >> index.ejs
echo     ^<link rel="stylesheet" href="/style.css"^> >> index.ejs
echo ^</head^> >> index.ejs
echo ^<body^> >> index.ejs
echo     ^<h1^>Hello World^</h1^> >> index.ejs
echo ^</body^> >> index.ejs
echo ^</html^> >> index.ejs
cd ..
start cmd /k nodemon server.js
cd public
call ng g s http
cd src
cd app
call del /f http.service.ts
call type nul > http.service.ts
:: REBUILD http.service.ts
echo import { Injectable } from '@angular/core'; >> http.service.ts
echo import { HttpClient } from '@angular/common/http'; >> http.service.ts
echo @Injectable({ >> http.service.ts
echo   providedIn: 'root' >> http.service.ts
echo }) >> http.service.ts
echo export class HttpService { >> http.service.ts
echo   constructor(private _http: HttpClient) { } >> http.service.ts
echo   index(){ >> http.service.ts
echo     return this._http.get('/'); >> http.service.ts
echo   } >> http.service.ts
echo getUsers(){ >> http.service.ts
echo       let tempObservable = this._http.get('/users'); >> http.service.ts
echo       tempObservable.subscribe(data =^> { >> http.service.ts
echo           return data; >> http.service.ts
echo       }) >> http.service.ts
echo   } >> http.service.ts
echo } >> http.service.ts >> http.service.ts
call ng generate component alpha
call ng generate component beta
call ng generate component gamma
call ng generate component pagenotfound
call del /f app.module.ts
call type nul > app.module.ts
:: REBUILD app.module.ts
echo import { BrowserModule } from '@angular/platform-browser'; >> app.module.ts
echo import { NgModule } from '@angular/core'; >> app.module.ts
echo import { HttpService } from './http.service'; >> app.module.ts
echo import { AppComponent } from './app.component'; >> app.module.ts
echo import { HttpClientModule } from '@angular/common/http'; >> app.module.ts
echo import { FormsModule } from '@angular/forms'; >> app.module.ts
echo import { AppRoutingModule } from './app-routing.module'; >> app.module.ts
echo import { AlphaComponent } from './alpha/alpha.component'; >> app.module.ts
echo import { BetaComponent } from './beta/beta.component'; >> app.module.ts
echo import { GammaComponent } from './gamma/gamma.component'; >> app.module.ts
echo @NgModule({ >> app.module.ts
echo   declarations: [AppComponent, AlphaComponent, BetaComponent, GammaComponent], >> app.module.ts
echo   imports: [BrowserModule, HttpClientModule, FormsModule, AppRoutingModule], >> app.module.ts
echo   providers: [HttpService], >> app.module.ts
echo   bootstrap: [AppComponent] >> app.module.ts
echo }) >> app.module.ts
echo export class AppModule { } >> app.module.ts
call del /f app.component.ts
call type nul > app.component.ts
::REBUILD app.component.ts
echo import { Component, OnInit } from '@angular/core'; >> app.component.ts
echo import { HttpService } from './http.service'; >> app.component.ts
echo @Component({ >> app.component.ts
echo   selector: 'app-root', >> app.component.ts
echo   templateUrl: './app.component.html', >> app.component.ts
echo   styleUrls: ['./app.component.css'] >> app.component.ts
echo }) >> app.component.ts
echo export class AppComponent implements OnInit { >> app.component.ts
echo   title = 'MANLY APP'; >> app.component.ts
echo   constructor(private _httpService: HttpService){} >> app.component.ts
echo   ngOnInit() { } >> app.component.ts
echo } >> app.component.ts
call del /f app-routing.module.ts
call type nul > app-routing.module.ts
:: REBUILD app.routing-module.ts
echo import { NgModule } from '@angular/core'; >> app-routing.module.ts
echo import { Routes, RouterModule } from '@angular/router'; >> app-routing.module.ts
echo import { AlphaComponent } from './alpha/alpha.component'; >> app-routing.module.ts
echo import { BetaComponent } from './beta/beta.component'; >> app-routing.module.ts
echo import { GammaComponent } from './gamma/gamma.component'; >> app-routing.module.ts
echo import { PageNotFoundComponent } from './pagenotfound/pagenotfound.component'; >> app-routing.module.ts
echo const routes: Routes = [ >> app-routing.module.ts
echo   { path: 'alpha', component: AlphaComponent }, >> app-routing.module.ts
echo   { path: 'beta', component: BetaComponent }, >> app-routing.module.ts
echo   { path: 'gamma', component: GammaComponent }, >> app-routing.module.ts
echo   { path: '', pathMatch: 'full', redirectTo: '/alpha' }, >> app-routing.module.ts
echo   { path: '**', component: PageNotFoundComponent } >> app-routing.module.ts
echo ]; >> app-routing.module.ts
echo @NgModule({ >> app-routing.module.ts
echo   imports: [RouterModule.forRoot(routes)], >> app-routing.module.ts
echo   exports: [RouterModule] >> app-routing.module.ts
echo }) >> app-routing.module.ts
echo export class AppRoutingModule { } >> app-routing.module.ts
cd gamma
call del /f gamma.component.ts
call type nul > gamma.component.ts
:: REBUILD gamma.component.ts
echo import { Component, OnInit } from '@angular/core'; >> gamma.component.ts
echo import { ActivatedRoute, Params, Router } from '@angular/router'; >> gamma.component.ts
echo @Component({ >> gamma.component.ts
echo   selector: 'app-gamma', >> gamma.component.ts
echo   templateUrl: './gamma.component.html', >> gamma.component.ts
echo   styleUrls: ['./gamma.component.css'] >> gamma.component.ts
echo }) >> gamma.component.ts
echo export class GammaComponent implements OnInit { >> gamma.component.ts
echo   constructor( >> gamma.component.ts
echo     private _route: ActivatedRoute, >> gamma.component.ts
echo     private _router: Router >> gamma.component.ts
echo   ) {} >> gamma.component.ts
echo   ngOnInit() { >> gamma.component.ts
echo     this._route.params.subscribe((params: Params) =^> { >> gamma.component.ts
echo         console.log(params['id']) >> gamma.component.ts
echo     }); >> gamma.component.ts
echo   } >> gamma.component.ts
echo   goHome() { >> gamma.component.ts
echo     this._router.navigate(['/home']); >> gamma.component.ts
echo   } >> gamma.component.ts
echo } >> gamma.component.ts
call ng build --watch