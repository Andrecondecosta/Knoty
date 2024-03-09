(function mobileFooter(i18n) {
  var i18n = i18n ? i18n : { current: 'current' },
    navs = document.querySelectorAll('nav.mobile-footer');

  [].forEach.call(navs, function (nav, index) {
    var links = nav.getElementsByTagName('a');

    [].forEach.call(links, function (link, index) {
      // Check if link href matches current URL
      if (window.location.href === link.href) {
        // Add 'active' class to the matching link
        link.classList.add('active');
      }

      link.addEventListener('click', function (e) {
        // Remove 'active' class from all links
        [].forEach.call(links, function (link) {
          link.classList.remove('active');
        });

        // Add 'active' class to the clicked link
        link.classList.add('active');
      });
    });
  });
})();
