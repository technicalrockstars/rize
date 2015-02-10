package rize.controller;

import rize.model.KanbanCollection;
import rize.model.Kanban;
import rize.view.KanbanTableView;
import rize.view.KanbanTableView.ChildView;
using Lambda;

class KanbanTableController{
	private var model : KanbanCollection;
	private var view : KanbanTableView;

	public function new(view, model){
		this.view = view;
		this.model = model;
		this.setup();
	}

	public function setup(){
		this.view.setup(this.model,this);
		this.view.submitButton.addEventListener("click",function(e){
			var name = this.view.form.name.value;
			var comment = this.view.form.comment.value;
			var author = this.view.form.author.value;
			var developer = this.view.form.developer.value;
			if( this.validates([name,comment,author]) ){
				this.model.addKanban(name,comment,author,if(developer != null) developer else null);
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});

		for(c in this.view.radio.children){
			c.addEventListener("click",function(event){
				switch(event.target.value){
					case "regist" : this.model.changeState(Regist);
					case "work" : this.model.changeState(Work);
					case "finish" : this.model.changeState(Finish);
					case _ : 
				}
			});
		}
	}

	public function setEvent(childView : ChildView){
		childView.removeBtn.addEventListener("click",function(event){
			if( js.Browser.window.confirm("本当に削除するぽよ?") )
				this.model.removeKanban(childView.id);
		});
	}




	private function validate(input : String)
		return input != null && input != "";

	private function validates(inputs : Array<String>) 
		return inputs.map(this.validate).fold(function(input,acc) return input && acc, true);
	
}