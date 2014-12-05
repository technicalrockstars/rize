package rize.controller;

import rize.model.*;
import rize.view.KanbanTableView;
import rize.view.DeveloperTableView;
import mlkcca.MilkCocoa;

class KanbanTableController{
	var milkcocoa : MilkCocoa;
	var kanbanCollection: KanbanCollection;

	public function new(mlk:MilkCocoa){
		milkcocoa = mlk;
		kanbanCollection = new KanbanCollection(milkcocoa);
	}

	public function makeView(){
		var kanbanTableView = new KanbanTableView();
			
		kanbanCollection.loadData(function(kanbanArray){
			trace("response data size ::"+kanbanArray.length);
			for(kanban in kanbanArray){
				kanbanTableView.children.appendChild(makeKanbanView(kanban));
			}
		});

		kanbanTableView.input.addEventListener("change",function(e){
			var kanban = new Kanban(kanbanTableView.input.value);
			kanbanCollection.push(kanban,function(){
				js.Browser.window.location.reload();
			});
		});

		kanbanTableView.makeButton.addEventListener("click",function(e){
			var kanban = new Kanban(kanbanTableView.input.value);
			kanbanCollection.push(kanban,function(){
				js.Browser.window.location.reload();
			});
		});

		kanbanTableView.reloadButton.addEventListener("click",function(e){
			js.Browser.window.location.reload();
		});
		
		return (kanbanTableView.nodes[0]);	
	}

	public function makeKanbanView(kanban:rize.model.Kanban){
		var developerCollection = new rize.model.DeveloperCollection(milkcocoa);
		var authName = kanban.auth;

	
		var kanbanView = new KanbanView({
			startDate : kanban.getStartString(),
			endDate : kanban.getEndString(),
			title:kanban.title,
			authName:authName,
			entry:kanban.getEntryString(),
			state:kanban.stateString(),
		});

		developerCollection.findById(kanban.auth,function(data){
			developerCollection.notify(data);
		});
		kanbanView.id = kanban.id;
		developerCollection.addListener(kanbanView);
		
		var reload = function(){
			js.Browser.window.location.reload();
		};

		kanbanView.changeTitleButton.addEventListener("click",function(e){
			kanbanCollection.change(kanbanView.id,{title:kanbanView.changeTitleText.value},reload);
		});
				
		kanbanView.nextStateButton.addEventListener("click",function(e){
			kanbanCollection.changeState(kanbanView.id,reload);
		});
				
		kanbanView.changeAuthButton.addEventListener("click",function(e){
			var developerCollection = new rize.model.DeveloperCollection(milkcocoa);
			developerCollection.findName(kanbanView.changeAuthText.value,function(id){
				kanbanCollection.changeAuth(kanbanView.id,id[0],reload);
			});
		});
				
		kanbanView.setStartDate.addEventListener("click",function(e){
			kanbanCollection.change(kanbanView.id,{start:Date.now()},reload);
		});

		kanbanView.setEndDate.addEventListener("click",function(e){
			kanbanCollection.change(kanbanView.id,{end:Date.now()},reload);
		});

		kanbanView.removeButton.addEventListener("click",function(e){
			kanbanCollection.remove(kanbanView.id,reload);
		});
		return kanbanView.nodes[0];
	}
}