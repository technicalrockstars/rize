package rize.controller;

import rize.controller.KanbanTableController;

import rize.model.*;
import rize.view.KanbanTableView;
import rize.view.DeveloperTableView;
import rize.view.TagTableView;
import mlkcca.MilkCocoa;

class DeveloperTableController{
	var milkcocoa : MilkCocoa;
	var developerCollection:DeveloperCollection;
	var tagCollection:rize.model.TagCollection;
	var kanbanCollection:rize.model.KanbanCollection;
	
	public function new (mlk:MilkCocoa){
		milkcocoa = mlk;
		developerCollection = new DeveloperCollection(milkcocoa);
		tagCollection = new rize.model.TagCollection(milkcocoa);
		kanbanCollection = new rize.model.KanbanCollection(milkcocoa);
	}

	public function makeView(){
		var developerTableView = new DeveloperTableView();

		developerCollection.loadData(function(data:Array<rize.model.Developer>){
			trace("developer table size ::" + data.length);
			for(dev in data){
				developerTableView.children.appendChild(makeDeveloperView(dev));
			}

			developerTableView.devMakeButton.addEventListener("click",function(e){
				developerCollection.push(new Developer(developerTableView.input.value),function(){
					js.Browser.window.location.reload();
				});
			});

			developerTableView.reloadButton.addEventListener("click",function(e){
				js.Browser.window.location.reload();
			});

		});
		return developerTableView.nodes[0];
	}

	public function makeDeveloperView(dev:rize.model.Developer){
		var developerView = new DeveloperView({
			name:dev.name
		});
		developerView.id = dev.id;
		
		var tagTableController = new rize.controller.TagTableController(milkcocoa);
		for(tagId in dev.tags){
			tagCollection.findById(tagId,function(tags){
				for(t in tags){
					developerView.tag.appendChild(tagTableController.makeTagView(t));
				}
			});
		}

		var kanbanTablecontroller = new rize.controller.KanbanTableController(milkcocoa);

		for(kanbanID in dev.kanbans){
			kanbanCollection.findById(kanbanID,function(kanbans){
				for(k in kanbans){
					developerView.kanban.appendChild(kanbanTablecontroller.makeKanbanView(k));
				}
			});
		}

		developerView.changeNameButton.addEventListener("click",function(e){
			developerCollection.change(developerView.id,{name:developerView.changeNameText.value},function(){
				js.Browser.window.location.reload();
			});
		});

		developerView.newKanbanButton.addEventListener("click",function(e){
			kanbanCollection.find(developerView.newKanbanText.value,function(data:Array<Dynamic>){
				for(d in data){
					developerCollection.addKanban(developerView.id,d);
				}
				js.Browser.window.location.reload();
			});
		});

		developerView.newTagButton.addEventListener("click",function(e){
			tagCollection.find(developerView.newTagText.value,function(data:Array<Dynamic>){
				for(d in data){
					developerCollection.addTag(developerView.id,d);
				}
				js.Browser.window.location.reload();
			});
		});

		developerView.removeButton.addEventListener("click",function(e){
			developerCollection.remove(developerView.id,function(){
				js.Browser.window.location.reload();
			});
		});

		return developerView.nodes[0];

	}
}