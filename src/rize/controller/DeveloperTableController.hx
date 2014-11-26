package rize.controller;

import rize.model.*;
import rize.view.KanbanTableView;
import rize.view.DeveloperTableView;
import rize.view.TagTableView;
import mlkcca.MilkCocoa;

class DeveloperTableController{
	var milkcocoa : MilkCocoa;

	public function new (mlk:MilkCocoa){
		milkcocoa = mlk;
	}

	public function makeView(){
		var developerTableView = new DeveloperTableView();
		var developerCollection = new DeveloperCollection(milkcocoa);
		var tagCollection = new rize.model.TagCollection(milkcocoa);
		var kanbanCollection = new rize.model.KanbanCollection(milkcocoa);

		developerCollection.loadData(function(data:Array<rize.model.Developer>){
			trace("developer table size ::" + data.length);
			for(dev in data){
				var developerView = new DeveloperView({
					name:dev.name
				});
				developerView.id = dev.id;

				for(tagId in dev.tags){
					tagCollection.findById(tagId,function(tags){
						for(t in tags){
							var tagView = new TagView({title:t.title});
							tagView.id = t.id;
							trace(tagView.id);
							developerView.tag.appendChild(tagView.nodes[0]);
						}
					});
				}

				developerView.changeNameButton.addEventListener("click",function(e){
					developerCollection.change(developerView.id,{name:developerView.changeNameText.value},function(){
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

				developerTableView.children.appendChild(developerView.nodes[0]);
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
}