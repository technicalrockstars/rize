package rize.view;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<div mage-var=children></div>
	<input type=text mage-var=input >
</div>"
))
class KanbanTableView{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<ul>
		<li>{{name}}</li>
		<li>{{state}}</li>
		<button type=submit name=b mage-var=button >test</button>
	</ul>
</div>"
))
class KanbanView{}