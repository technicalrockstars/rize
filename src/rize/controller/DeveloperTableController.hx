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
		var developerTable = new DeveloperTable(milkcocoa);

		developerTable.loadData(function(data:Array<rize.model.Developer>){
			trace("developer table size ::" + data.length);
			for(dev in data){
				var developerView = new DeveloperView({
					name:dev.name
				});
				developerView.id = dev.id;
			}
			
			developerTableView.devMakeButton.addEventListener("click",function(e){
				developerTable.push(new Developer(developerTableView.input.value),function(){
					js.Browser.window.location.reload();
				});
			});
		});
		return developerTableView.nodes[0];

	}
}