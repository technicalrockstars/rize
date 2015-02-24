package rize.view;

import rize.model.Account;
import rize.controller.AccountController;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input(email) type=text /></dd>
		<dt>password</dt>
		<dd><input(pass) type=password  ></dd>
		<dt>comfirm</dt>
		<dd><input(confirm) type=password ></dd>
		<dt>username</dt>
		<dd><input(username) type=text /></dd>

		<button(submitBtn)>送信</button>
	</dl>
</div>"
))
class SignUp{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input(email) type=text /></dd>
		<dt>password</dt>
		<dd><input(pass) type=password ></dd>

		<button(submitBtn) >送信</button>
	</dl>
</div>"
))
class SignIn{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>

	<div(signup) ></div>
	<div(signin) ></div>
</div>"
))
class NoLoginedView{
	public var signInView: SignIn;
	public var signUpView : SignUp;

	public function new(){
		this.signInView = new SignIn();
		this.signUpView = new SignUp();
		this.signin.appendChild(this.signInView.root);
		this.signup.appendChild(this.signUpView.root);
	}
}

typedef ContentView = { nodes : Array<js.html.Node> }

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<p>ログイン中です</p>
	<button(logoutBtn)>ログアウト</button>
	<input(tokentext) type=text />
	<button(tokenbtn)>トークンをセットする</button>
	<div(child)></div>
</div>
"
))
class LoginedView<T:ContentView> {
	public function new(contentView:T){
		this.child.appendChild(contentView.nodes[0]);
	}
}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<div(render)></div>
</div>"
))
class AccountView<T:ContentView>{
	public var model : Account;
	public var nologinedView : NoLoginedView;
	public var loginedView :  LoginedView<T>;


	public function new(model, contentView : T){
		this.model = model;
		this.nologinedView = new NoLoginedView();
		this.loginedView = new LoginedView(contentView);
	}

	public function update(){
		if( this.model.logined ){
			this.renderLoginedView();
		}else{
			this.renderLoginForm();
		}
	}

	private function renderLoginedView(){
		(cast (this.nologinedView.nodes[0], js.html.Element)).remove();
		this.render.appendChild(this.loginedView.nodes[0]);
	}

	private function renderLoginForm(){
		(cast (this.loginedView.nodes[0], js.html.Element)).remove();
		this.render.appendChild(this.nologinedView.nodes[0]);
	}
}