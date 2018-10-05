all: install

install:
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/
	@cp -fr tr.org.etap.audioandtools $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/

	mkdir -p $(DESTDIR)/usr/share/kde4/services
	@cp -fr eta-widget-audioandtools.desktop $(DESTDIR)/usr/share/kde4/services/

uninstall:
	@rm -fr $(DESTDIR)/usr/share/kde4/services/eta-widget-audioandtools.desktop
	@rm -fr $(DESTDIR)/usr/share/kde4/apps/plasma/plasmoids/tr.org.etap.audioandtools

.PHONY: install uninstall
