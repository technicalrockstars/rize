package rize.view;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	input new tag name:<input type=text mage-var=input>
	<input type=button mage-var=makeButton value=make>
	<input type=button mage-var=reloadButton value=reload>
	<div mage-var=children></div>
</div>"
))
class TagTableView{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<ul>
		title :: <bar>{{title}}</bar>
			<input type=text mage-var=changeTitleText>
			<input type=button mage-var=changeTitleButton value=changeTitle>
		<br>
	</ul>
</div>"
))
class TagView{
	public var id : String;
}