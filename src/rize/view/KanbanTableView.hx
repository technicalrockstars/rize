package rize.view;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	input new kanban name:<input type=text mage-var=input>
	<input type=button mage-var=makeButton value=make>
	<input type=button mage-var=reloadButton value=reload>
	<div mage-var=children></div>
</div>"
))
class KanbanTableView{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<ul>
		title :: <bar>{{name}}</bar><br>
		state :: <bar>{{state}}</bar><br>
		auth  :: <bar>{{authName}}</bar><br>
		<input type=button mage-var=removeButton value=remove>
	</ul>
</div>"
))
class KanbanView{
	public var id : Int;
}