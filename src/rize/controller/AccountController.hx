package rize.controller;

import rize.model.Account;
import rize.view.AccountView;

class AccountController<T>{
	public var model(default, null) : Account;
	public var view : AccountView<T>;

	public function new(view, ?model){
		this.view = view;
		this.model = model;
		this.model.addObserver(this.view);

		var signInView = this.view.nologinedView.signInView;
		var signUpView = this.view.nologinedView.signUpView;
		var loginedView = this.view.loginedView;

		signInView.submitBtn.addEventListener("click",function(event){
			var email = signInView.email.value;
			var password = signInView.pass.value;
			if( email != null && password != null){
				model.signIn(email,password);
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});

		signUpView.submitBtn.addEventListener("click",function(event){
			var email = signUpView.email.value;
			var password = signUpView.pass.value;
			var comfirm = signUpView.confirm.value;
			var username = signUpView.username.value;
			if( email != null && password != null && comfirm != null && username != null && password == comfirm ){
				model.signUp(email,password,username);
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});


		loginedView.logoutBtn.addEventListener("click",function(event){
			this.model.logout();
		});

		loginedView.tokenbtn.addEventListener("click",function(event){
			var text = loginedView.tokentext.value;
			this.model.setToken(text);
		});

	}

}