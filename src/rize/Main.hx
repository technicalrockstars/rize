package rize;


import rize.model.*;
import rize.view.*;
import rize.controller.*;
import mlkcca.MilkCocoa;

typedef Config = {
	milkcocoa_id : String,
	slack : {
		url : String,
		channel : String,
		name : String
	}
}

class Main{
	public var controller = null;

	public static var config : Config = CompileTime.parseJsonFile("config.json");

	public static function main(){
		js.Browser.window.addEventListener("load",function(e){


			var milkcocoa = new MilkCocoa(Main.config.milkcocoa_id);
			var dataStore = milkcocoa.dataStore("kanban");

			var kanbanTableView = new KanbanTableView();
			var kanbanCollection = new KanbanCollection(dataStore);
			var controller = new KanbanTableController(kanbanTableView, kanbanCollection);


			var account = new Account(milkcocoa);
			var accountView = new AccountView(account,kanbanTableView);
			var accountController = new AccountController(accountView,account);
			
			js.Browser.document.body.appendChild(accountView.nodes[0]);
		});
	}
}