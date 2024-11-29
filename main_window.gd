extends Control

var MenuConfig := ConfigFile.new()

const defaultText := "Select One"

const Colors : Array[Color] = [
	Color.WEB_GRAY, Color.YELLOW, Color.GREEN, Color.BLUE,
	Color.REBECCA_PURPLE, Color.DARK_RED, Color.ORANGE ]

const Rarities : Array[String] = [
	"Common", "Uncommon", "Rare", "Epic", "Legendary",
	"Artifact", "Celestial"]

const Categories : Array[String] = [
	"Armor", "Food", "Storage", "Tool", "Weapon", "System" ]

const DamageTypes : Array[String] = [
	"Blunt", "Energy", "Piercing", "Slashing"]

var FormatString : String = "A {R} {C} of {D}."
var DescriptionString : String = ""

@export var lineItemName : LineEdit
var itemName : String
@export var menuRarities : MenuButton
var btnRare : PopupMenu
@export var menuCategories : MenuButton
var btnCat : PopupMenu
@export var menuDamageTypes : MenuButton
var btnDmgType : PopupMenu
@export var rtDescription : RichTextLabel

func _on_btn_rare_select(id:int)->void:
	menuRarities.text=Rarities[id]

func _on_btn_cat_select(id:int)->void:
	menuCategories.text=Categories[id]

func _on_btn_dmgType_select(id:int)->void:
	menuDamageTypes.text=DamageTypes[id]

func _ready():
	btnRare = menuRarities.get_popup()
	btnRare.connect("id_pressed", _on_btn_rare_select)
	for rarity in Rarities:
		btnRare.add_item(rarity)
	btnCat = menuCategories.get_popup()
	btnCat.connect("id_pressed", _on_btn_cat_select)
	for category in Categories:
		btnCat.add_item(category)
	btnDmgType = menuDamageTypes.get_popup()
	btnDmgType.connect("id_pressed", _on_btn_dmgType_select)
	for dmgType in DamageTypes:
		btnDmgType.add_item(dmgType)

func _on_le_item_name_text_changed(new_text:String):
	itemName = new_text.to_snake_case()

func _on_btn_random_pressed():
	_on_btn_rare_select( randi_range(0, Rarities.size()-1) )
	_on_btn_cat_select( randi_range(0, Categories.size()-1) )
	_on_btn_dmgType_select( randi_range(0, DamageTypes.size()-1) )

func _on_btn_reset_pressed():
	lineItemName.clear()
	menuRarities.text = defaultText
	menuCategories.text = defaultText
	menuDamageTypes.text = defaultText
	rtDescription.text = ""

func _on_btn_copy_pressed():
	DisplayServer.clipboard_set(rtDescription.text)
