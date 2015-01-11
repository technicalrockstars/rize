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
			var dataStore = milkcocoa.dataStore("kanban");

			var accountView = new AccountView();
			Account.milkcocoa = milkcocoa;
			var accountController = new AccountController(accountView);

			var kanbanTableView = new KanbanTableView();


			accountController.onNotLogined = function(){
				var view : js.html.Element = cast kanbanTableView.nodes[0];
				view.remove();
				js.Browser.document.body.appendChild(accountView.nodes[0]);
			}

			accountController.onLogin = function(){
				kanbanTableView = new KanbanTableView();
				js.Browser.document.body.appendChild(kanbanTableView.nodes[0]);
				var kanbanCollection = new KanbanCollection(dataStore);
				var controller = new KanbanTableController(kanbanTableView, kanbanCollection);
			}
			accountController.getCurrentUser();

		});
	}
}