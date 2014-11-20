package rize.view;

import mlkcca.MilkCocoa;

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	input new Developer name:<input type=text mage-var=input>
	<input type=button mage-var=devMakeButton value=make>
	<input type=button mage-var=reloadButton value=reload>
	<div mage-var=children></div>
</div>"
))
class DeveloperTableView{}


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<ul>
		name :: <bar>{{name}}</bar>
			<input type=text mage-var=changeNameText>
			<input type=button mage-var=changeNameButton value=changeTitle>
		<br>
		<input type=button mage-var=removeButton value=remove>
	</ul>
</div>"
))
class DeveloperView{
	public var id : String;
}