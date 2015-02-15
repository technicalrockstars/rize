package rize.view;


import rize.model.KanbanCollection;
import rize.controller.KanbanVC;
import rize.controller.KanbanTableController;

@:build(mage.CompileCSS.generate(
"package rize.view.kanban.child;

.record {
	float : left;
}"))
@:build(mage.CompileHTML.generate(
"package rize.view.kanban.child;

<div(content) class=record>
	<button(removeBtn)>削除</button>
</div>"
))
class ChildView{
	public var id : String;
}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<div(inputform)></div>
	<div(radio)>
		<input type=radio name=state value=regist checked=true>regist
		<input type=radio name=state value=work>work
		<input type=radio name=state value=finish>finish
	</div>
	<div(children)></div>

</div>"
))
class KanbanTableFrame{}

class KanbanTableView extends KanbanTableFrame{
	private var model : KanbanCollection = null;
	private var controller : KanbanTableController;
	public var submitButton : js.html.ButtonElement;
	public var form : KanbanFormView;

	public function new(){
		super();
		this.form = new KanbanFormView();
		this.inputform.appendChild(form.nodes[0]);
		this.submitButton = form.updateBtn;
	}

	public function setup(model, controller){
		this.controller = controller;
		this.model = model;
		this.model.addObserver(this);
		this.update();
	}


	public function update(){
		this.removeAll();
		var childrenView = this.model.collection.map(function(kanban){
			var kanbanView = new KanbanView();
			var kanbanVC = new KanbanVC(kanbanView, kanban);
			var childView = new ChildView();
			childView.id = kanban.id;
			childView.content.insertBefore(kanbanView.nodes[0],childView.removeBtn);
			this.controller.setEvent(childView);
			return childView;
		});


		for(c in childrenView){
			this.children.appendChild(c.nodes[0]);
		}

	}

	private function removeAll(){
		if(this.children.hasChildNodes()){
			this.children.removeChild(this.children.firstChild);
			this.removeAll();
		}
	}

}