From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 5/5] spi-imx: don't access struct device
	directly but use dev_get_platdata
Date: Tue,  8 Dec 2009 22:14:10 +0100
Message-ID: <1260306850-14945-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1260306850-14945-4-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

QWxzbyB0aGVyZSBpcyBubyBjYXN0aW5nIG5lZWRlZCB0byBhc3NpZ24gYSB2b2lkIHBvaW50ZXIu
CgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlPgpDYzogRGF2aWQgQnJvd25lbGwgPGRicm93bmVsbEB1c2Vycy5zb3VyY2Vmb3Jn
ZS5uZXQ+CkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzog
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvc3BpL3Nw
aV9pbXguYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaV9pbXguYyBiL2RyaXZlcnMv
c3BpL3NwaV9pbXguYwppbmRleCA1OWIzYTMwLi5lYTZkNzAxIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3NwaS9zcGlfaW14LmMKKysrIGIvZHJpdmVycy9zcGkvc3BpX2lteC5jCkBAIC00OTIsNyArNDky
LDcgQEAgc3RhdGljIGludCBfX2luaXQgc3BpX2lteF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCXN0cnVjdCByZXNvdXJjZSAqcmVzOwogCWludCBpLCByZXQ7CiAKLQlteGNf
cGxhdGZvcm1faW5mbyA9IChzdHJ1Y3Qgc3BpX2lteF9tYXN0ZXIgKilwZGV2LT5kZXYucGxhdGZv
cm1fZGF0YTsKKwlteGNfcGxhdGZvcm1faW5mbyA9IGRldl9nZXRfcGxhdGRhdGEoJnBkZXYtPmRl
dik7CiAJaWYgKCFteGNfcGxhdGZvcm1faW5mbykgewogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJj
YW4ndCBnZXQgdGhlIHBsYXRmb3JtIGRhdGFcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsKLS0gCjEu
Ni41LjIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUmV0dXJuIG9uIEluZm9ybWF0aW9uOgpHb29n
bGUgRW50ZXJwcmlzZSBTZWFyY2ggcGF5cyB5b3UgYmFjawpHZXQgdGhlIGZhY3RzLgpodHRwOi8v
cC5zZi5uZXQvc2Z1L2dvb2dsZS1kZXYyZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2
ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
