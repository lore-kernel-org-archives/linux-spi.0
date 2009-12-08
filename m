From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/5] spi-imx: use positive logic to
	distinguish cpu variants
Date: Tue,  8 Dec 2009 22:14:08 +0100
Message-ID: <1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1260306850-14945-2-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

VGhpcyBpcyBtdWNoIHNhZmVyIHdoZW4gc3VwcG9ydCBmb3IgbmV3IHZhcmlhbnRzIGlzIGFkZGVk
LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4KQ2M6IERhdmlkIEJyb3duZWxsIDxkYnJvd25lbGxAdXNlcnMuc291cmNlZm9y
Z2UubmV0PgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6
IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3NwaS9z
cGlfaW14LmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGlfaW14LmMgYi9kcml2ZXJz
L3NwaS9zcGlfaW14LmMKaW5kZXggZDhkOWEzNS4uMGNjYmQxYyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9zcGkvc3BpX2lteC5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaV9pbXguYwpAQCAtNTkzLDcgKzU5
Myw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHNwaV9pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKIAljbGtfZW5hYmxlKHNwaV9pbXgtPmNsayk7CiAJc3BpX2lteC0+c3BpX2Ns
ayA9IGNsa19nZXRfcmF0ZShzcGlfaW14LT5jbGspOwogCi0JaWYgKCFjcHVfaXNfbXgzMSgpIHx8
ICFjcHVfaXNfbXgzNSgpKQorCWlmIChjcHVfaXNfbXgxKCkgfHwgY3B1X2lzX214MjEoKSB8fCBj
cHVfaXNfbXgyNygpKQogCQl3cml0ZWwoMSwgc3BpX2lteC0+YmFzZSArIE1YQ19SRVNFVCk7CiAK
IAkvKiBkcmFpbiByZWNlaXZlIGJ1ZmZlciAqLwotLSAKMS42LjUuMgoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpSZXR1cm4gb24gSW5mb3JtYXRpb246Ckdvb2dsZSBFbnRlcnByaXNlIFNlYXJjaCBw
YXlzIHlvdSBiYWNrCkdldCB0aGUgZmFjdHMuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvZ29vZ2xlLWRl
djJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kc3Bp
LWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9z
cGktZGV2ZWwtZ2VuZXJhbAo=
