/*
 *	jQuery Sliding Menu Plugin
 *	Mobile app list-style navigation in the browser
 *
 *	Written by Ali Zahid
 *	http://designplox.com/jquery-sliding-menu
 */
! function (a) {
  var e = [];
  a.fn.slidingMenu = function (t) {
    function n(e) {
      var t = a("ul", e),
        n = [];
      return a(t).each(function (e, t) {
        var r = a(t),
          s = r.prev(),
          l = i();
        if (1 == s.length && (s.addClass("nav-has-children dropdown-item").attr("href", "#menu-panel-" + l), s.append('<i class="ft-arrow-right children-in"></i>')), r.attr("id", "menu-panel-" + l), 0 == e) r.addClass("menu-panel-root");
        else {
          r.addClass("menu-panel");
          var d = (a("<li></li>"), a("<a></a>").addClass("nav-has-parent back primary dropdown-item").attr("href", "#menu-panel-back"));
          r.prepend(d)
        }
        n.push(t)
      }), n
    }

    function r(e, t) {
      var n = {
          id: "menu-panel-" + i(),
          children: [],
          root: t ? !1 : !0
        },
        s = [];
      return t && n.children.push({
        styleClass: "back",
        href: "#" + t.id
      }), a(e).each(function (a, e) {
        if (n.children.push(e), e.children) {
          var t = r(e.children, n);
          e.href = "#" + t[0].id, e.styleClass = "nav", s = s.concat(t)
        }
      }), [n].concat(s)
    }

    function i() {
      var a;
      do a = Math.random().toString(36).substring(3, 8); while (e.indexOf(a) >= 0);
      return e.push(a), a
    }

    function s() {
      var e = a(".sliding-menu-wrapper"),
        t = a(".sliding-menu-wrapper ul");
      t.length && setTimeout(function () {
        var n = a(l).width();
        e.width(t.length * n), t.each(function (e, t) {
          var r = a(t);
          r.width(n)
        }), e.css("margin-left", "")
      }, 300)
    }
    var l = this.selector,
      d = !1;
    "rtl" == a("html").data("textdirection") && (d = !0);
    var h = a.extend({
      dataJSON: !1,
      backLabel: "Back"
    }, t);
    return this.each(function () {
      var e, t = this,
        i = a(t);
      if (i.hasClass("sliding-menu")) return void s();
      var l = i.outerWidth();
      e = h.dataJSON ? r(h.dataJSON) : n(i), i.empty().addClass("sliding-menu");
      var p;
      h.dataJSON ? a(e).each(function (e, t) {
        var n = a("<ul></ul>");
        t.root && (p = "#" + t.id), n.attr("id", t.id), n.addClass("menu-panel"), n.width(l), a(t.children).each(function (e, t) {
          var r = a("<a></a>");
          r.attr("class", t.styleClass), r.attr("href", t.href), r.text(t.label);
          var i = a("<li></li>");
          i.append(r), n.append(i)
        }), i.append(n)
      }) : a(e).each(function (e, t) {
        var n = a(t);
        n.hasClass("menu-panel-root") && (p = "#" + n.attr("id")), n.width(l), i.append(t)
      }), p = a(p), p.addClass("menu-panel-root");
      var c = p;
      i.height(p.height());
      var u = a("<div></div>").addClass("sliding-menu-wrapper").width(e.length * l);
      return i.wrapInner(u), u = a(".sliding-menu-wrapper", i), a("a", t).on("click", function (e) {
        var t = a(this).attr("href"),
          n = a(this).text();
        if (u.is(":animated")) return void e.preventDefault();
        if ("#" == t) e.preventDefault();
        else if (0 == t.indexOf("#menu-panel")) {
          var r, s, l = a(t),
            o = a(this).hasClass("back");
          d === !0 ? s = parseInt(u.css("margin-right")) : r = parseInt(u.css("margin-left"));
          var f = i.width();
          a(this).closest("ul").hasClass("menu-panel-root") && (c = p), o ? ("#menu-panel-back" == t && (l = c.prev()), d === !0 ? properties = {
            marginRight: s + f
          } : properties = {
            marginLeft: r + f
          }, u.stop(!0, !0).animate(properties, "fast")) : (l.insertAfter(c), h.backLabel === !0 ? a(".back", l).html('<i class="fa fa-arrow-circle-o-left back-in"></i>' + n) : a(".back", l).text(h.backLabel), d === !0 ? properties = {
            marginRight: s - f
          } : properties = {
            marginLeft: r - f
          }, u.stop(!0, !0).animate(properties, "fast")), c = l, i.stop(!0, !0).animate({
            height: l.height()
          }, "fast"), e.preventDefault()
        }
      }), this
    })
  }
}(jQuery);
