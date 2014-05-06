(function() {
    I18n.defaultScope = undefined;
    var _lookup = I18n.lookup;
    I18n.lookup = function(scope, options) {
        if (typeof scope === 'object')
            scope = scope.join(this.defaultSeparator);
        if (typeof scope === 'string' && scope.substr(0, this.defaultSeparator.length) === this.defaultSeparator) {
            scope = scope.substr(this.defaultSeparator.length);
            options.scope = I18n.defaultScope;
        }
        return _lookup.call(this, scope, options);
    };
})();
var t = I18n.t.bind(I18n);