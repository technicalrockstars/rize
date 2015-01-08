package rize.controller;

import rize.view.KanbanView;
import rize.model.Developer;
import rize.model.Kanban;

class KanbanVC{
	private var view : KanbanView;
	private var model : Kanban;

	public function new(view : KanbanView, kanban : Kanban){
		this.view = view;
		this.model = kanban;
		this.setup();
	}

	public function setup(){
		this.view.setup(this.model);
		this.view.updateBtn.addEventListener("click",function(e){
			if(this.model.developer == null){
				var developerName = this.view.developer.value;
				if(developerName == "" || developerName == null ){
					js.Browser.window.alert("開発者名を入力してください");
					return;
				}
				var developer = new Developer(developerName);
				this.model.developer = developer;
			}
			this.model.nextState();
		});
	}



}