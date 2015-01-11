package rize;


import rize.model.*;
import rize.view.*;
import rize.controller.*;
import mlkcca.MilkCocoa;

class Main{
	public var controller = null;

	public static function main(){
		js.Browser.window.addEventListener("load",function(e){
			var milkcocoa = new MilkCocoa("io-bi49l4chn");
			var dataStore = milkcocoa.dataStore("kanban3");
		
			var kanbanCollection = new KanbanCollection(dataStore);
			var kanbanTableView = new KanbanTableView();
			js.Browser.document.body.appendChild(kanbanTableView.nodes[0]);

			var controller = new KanbanTableController(kanbanTableView, kanbanCollection);


		});
	}
}