package rize.controller;

import rize.model.*;
import rize.view.KanbanTableView;
import rize.view.DeveloperTableView;
import mlkcca.MilkCocoa;

class DeveloperTableController{
	var milkcocoa : MilkCocoa;

	public function new (mlk:MilkCocoa){
		milkcocoa = mlk;
	}

	public function makeView(){
		var developerTableView = new DeveloperTableView();
		var developerCollection = new DeveloperCollection(milkcocoa);

		developerCollection.loadData(function(data:Array<rize.model.Developer>){
			trace("developer table size ::" + data.length);
			for(dev in data){
				var developerView = new DeveloperView({
					name:dev.name
				});
				developerView.id = dev.id;

				developerView.changeNameButton.addEventListener("click",function(e){
					developerCollection.change(developerView.id,{name:developerView.changeNameText.value},function(){
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