package rize.controller;

import rize.model.KanbanCollection;
import rize.model.Kanban;
import rize.view.KanbanTableView;
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
		this.view.setup(this.model);
		this.view.submitButton.addEventListener("click",function(e){
			var name = this.view.form.name.value;
			var comment = this.view.form.comment.value;
			var author = this.view.form.author.value;
			var developer = this.view.form.developer.value;
			if( this.validates([name,comment,author]) ){
				this.model.addKanban(name,comment,author,developer);
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});
	}


	private function validate(input : String)
		return input != null && input != "";

	private function validates(inputs : Array<String>) 
		return inputs.map(this.validate).fold(function(input,acc) return input && acc, true);
	
}