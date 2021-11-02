({
	openMenu : function(component) {
		// open menu
		var triggerElement = component.find('trigger');
		$A.util.addClass(triggerElement, 'slds-is-open');
		// focus menu
		var menuElement = component.find('menu');
		menuElement.getElement().focus();
		// highlight input
		var input = component.find('input');
		$A.util.addClass(input, 'focused');
	},
    
    closeMenu : function(component) {
		// close menu
		var triggerElement = component.find('trigger');
		$A.util.removeClass(triggerElement, 'slds-is-open');
		// unhighlight input
		var input = component.find('input');
		$A.util.removeClass(input, 'focused');
	}
})