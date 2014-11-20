package rize;

import rize.model.*;
import rize.controller.*;
import rize.view.KanbanTableView;
import rize.view.DeveloperTableView;
import mlkcca.MilkCocoa;


//登録　一覧　更新

class Main{
	public static function main(){
		var milkcocoa = new MilkCocoa("io-ui2316wnm");
		js.Browser.window.addEventListener("load",function(e){

			var messageDataStore = milkcocoa.dataStore('message');
			
			var developerTableController = new DeveloperTableController(milkcocoa);
			js.Browser.document.body.appendChild(developerTableController.makeView());
			
			var tagTableController = new TagTableController(milkcocoa);
			js.Browser.document.body.appendChild(tagTableController.makeView());
			
			var kanbanTableController = new KanbanTableController(milkcocoa);
			js.Browser.document.body.appendChild(kanbanTableController.makeView());
			
			
		});
	}
}