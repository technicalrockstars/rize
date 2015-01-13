package rize.view;

import rize.model.Account;
import rize.controller.AccountController;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input type=text mage-var=email /></dd>
		<dt>password</dt>
		<dd><input type=password mage-var=pass ></dd>
		<dt>comfirm</dt>
		<dd><input type=password mage-var=confirm ></dd>
		<dt>username</dt>
		<dd><input type=text mage-var=username/></dd>

		<button mage-var=submitBtn>送信</button>
	</dl>
</div>"
))
class SignUp{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input type=text mage-var=email /></dd>
		<dt>password</dt>
		<dd><input type=password mage-var=pass ></dd>

		<button mage-var=submitBtn>送信</button>
	</dl>
</div>"
))
class SignIn{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>

	<div mage-var=signup></div>
	<div mage-var=signin></div>
</div>"
))
class NoLoginedViewFrame{}


class NoLoginedView extends NoLoginedViewFrame{
	public var signInView: SignIn;
	public var signUpView : SignUp;

	public function new(){
		super();
		this.signInView = new SignIn();
		this.signUpView = new SignUp();
		this.signin.appendChild(this.signInView.nodes[0]);
		this.signup.appendChild(this.signUpView.nodes[0]);
	}
}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<button mage-var=logoutBtn>ログアウト</button>
	<input type=text mage-var=tokentext />
	<button mage-var=tokenbtn>トークンをセットする</button>
	<div mage-var=child></div>
</div>
"
))
class LoginedViewFrame{}

typedef ChildView = { nodes : Array<js.html.Node> }

class LoginedView<T:ChildView> extends LoginedViewFrame{
	public function new(childView:T){
		super();
		this.child.appendChild(childView.nodes[0]);
	}
}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<div mage-var=render></div>
</div>"
))
class AccountViewFrame{}

class AccountView<T:ChildView> extends AccountViewFrame{
	public var model : Account;
	public var nologinedView : NoLoginedView;
	public var loginedView :  LoginedView<T>;


	public function new(model, childView : T){
		super();
		this.model = model;
		this.nologinedView = new NoLoginedView();
		this.loginedView = new LoginedView(childView);
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