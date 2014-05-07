function ModalDialog(cls, title, content) {
    var calcFixPoint = function(factor, objectSz, spaceSz) {
        var fp = (factor * spaceSz) - (objectSz / 2);
        if (fp < 0)
            return 0;
        return fp;
    };

    if (typeof content === 'string')
        content = $('<div class="dialog-content"></div>').append(document.createTextNode(content));
    else {
        if (!(content instanceof jQuery)) {
            if (content instanceof Element)
                content = $(content);
            else
                throw new TypeError('Unrecognized type of ModalDialog content');
        }
    }
    var body = content;

    this.dialog = null;

    this.close = null;

    this.show = function(onCloseListener, onShowListener) {
        var self = this;
        var dimmer = $('<div id="dialog-dimmer" class="dimmer" />');
        var dialog = $('<div class="modal-dialog"><div class="dialog-title-bar"><span>' + title + '</span><span class="dialog-close-button glyphicon glyphicon-remove"></span></div></div>');
        if (cls !== null)
            dialog.addClass(cls);
        dialog.append(body);
        var resize_fn = function() {
            var wnd = $(window);
            dimmer.width(wnd.width());
            dimmer.height(wnd.height());
            if (dialog.width() > wnd.width() || dialog.height() > wnd.height()) {
                var body = $('body');
                dialog.css({
                    position: 'absolute',
                    left: calcFixPoint(0.5, dialog.width(), $(document).width()) + 'px',
                    top: 0
                });
                return;
            }
            dialog.css({
                position: 'fixed',
                left: calcFixPoint(0.5, dialog.width(), wnd.width()) + 'px',
                top: calcFixPoint(0.3, dialog.height(), wnd.height()) + 'px'
            });
        };
        $(window).on('resize', resize_fn);
        $('body').append(dimmer).append(dialog);
        resize_fn();
        this.close = function() {
            dimmer.fadeOut('fast');
            dialog.fadeOut('fast', function() {
                body.detach();
                dimmer.remove();
                dialog.remove();
                self.dialog = null;
                self.close = null;
                $(window).off('resize', resize_fn);
                resize_fn = undefined;
                if (typeof onCloseListener === 'function')
                    onCloseListener();
            });
        };
        dialog.find('.dialog-close-button').click(this.close);
        dimmer.click(function(e) {
            e.stopPropagation();
            self.close();
        });
        dimmer.mousemove(function(e) {
            e.stopPropagation();
            return false;
        });
        dimmer.fadeIn('fast');
        dialog.fadeIn('fast', function() {
            if (typeof onShowListener === 'function')
                onShowListener();
        });
        this.dialog = dialog;
        return this;
    };
}

var DialogFactory = {
    infoDialog: function(content) {
        return new ModalDialog('info-dialog', t('dialogs.titles.info'), content);
    },
    noticeDialog: function(content) {
        return new ModalDialog('notice-dialog', t('dialogs.titles.notice'), content);
    },
    alertDialog: function(content) {
        return new ModalDialog('alert-dialog', t('dialogs.titles.alert'), content);
    }
};

$(document).ready(function(){
    $('.dialog-content').detach().each(function() {
        var info = $(this);
        var dialog = null;
        if (info.hasClass('alert-dialog'))
            dialog = DialogFactory.alertDialog(info);
        else if (info.hasClass('notice-dialog'))
            dialog = DialogFactory.noticeDialog(info);
        else
            dialog = DialogFactory.infoDialog(info);
        info.removeClass('info-dialog notice-dialog alert-dialog');
        dialog.show();
    });
});