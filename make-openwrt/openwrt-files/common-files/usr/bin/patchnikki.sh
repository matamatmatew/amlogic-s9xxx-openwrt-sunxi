#!/bin/bash
if [ ! -f /www/luci-static/resources/view/nikki/configeditor.js ]; then
	cat << 'EOF' > /www/luci-static/resources/view/nikki/configeditor.js
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
EOF
fi

if ! grep -q "Config Editor" /usr/share/luci/menu.d/luci-app-nikki.json && [ -f "/www/tinyfm/nikki.php" ]; then
	mv /usr/share/luci/menu.d/luci-app-nikki.json /usr/share/luci/menu.d/luci-app-nikki.json.bak
	cat << EOF > /usr/share/luci/menu.d/luci-app-nikki.json
{
    "admin/services/nikki": {
        "title": "Nikki",
        "action": {
            "type": "firstchild"
        },
        "depends": {
            "acl": [ "luci-app-nikki" ],
            "uci": { "nikki": true }
        }
    },
    "admin/services/nikki/config": {
        "title": "App Config",
        "order": 10,
        "action": {
            "type": "view",
            "path": "nikki/app"
        }
    },
    "admin/services/nikki/profile": {
        "title": "Profile",
        "order": 20,
        "action": {
            "type": "view",
            "path": "nikki/profile"
        }
    },
    "admin/services/nikki/mixin": {
        "title": "Mixin Config",
        "order": 30,
        "action": {
            "type": "view",
            "path": "nikki/mixin"
        }
    },
    "admin/services/nikki/proxy": {
        "title": "Proxy Config",
        "order": 40,
        "action": {
            "type": "view",
            "path": "nikki/proxy"
        }
    },
    "admin/services/nikki/configeditor": {
        "title": "Config Editor",
        "order": 45,
        "action": {
            "type": "view",
            "path": "nikki/configeditor"
        }
    },
    "admin/services/nikki/editor": {
        "title": "Editor",
        "order": 50,
        "action": {
            "type": "view",
            "path": "nikki/editor"
        }
    },
    "admin/services/nikki/log": {
        "title": "Log",
        "order": 60,
        "action": {
            "type": "view",
            "path": "nikki/log"
        }
    }
}
EOF
fi

echo 'done'






