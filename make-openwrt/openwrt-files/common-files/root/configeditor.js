'use strict';
'require view';

return view.extend({
	handleSaveApply: null,
	handleSave: null,
	handleReset: null,

	render: function() {
		return E('iframe', {
			src: '/tinyfm/nikki.php',
			style: 'width: 100%; min-height: 80vh; border: none; border-radius: 3px; resize: vertical;'
		});
	}
});