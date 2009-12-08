From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/5] spi-imx: correct check for
	platform_get_irq failing
Date: Tue,  8 Dec 2009 22:14:07 +0100
Message-ID: <1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1260306850-14945-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

cGxhdGZvcm1fZ2V0X2lycSByZXR1cm5zIC1FTlhJTyBpZiB0aGVyZSBpcyBubyBlbnRyeS4gIFNv
IGRvbid0IGNoZWNrCnJldHVybiB2YWx1ZSBiZWluZyBub256ZXJvIGJ1dCBncmVhdGVyIG9yIGVx
dWFsIHRvIHplcm8uCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlPgpDYzogRGF2aWQgQnJvd25lbGwgPGRicm93bmVsbEB1c2Vy
cy5zb3VyY2Vmb3JnZS5uZXQ+CkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnPgpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgotLS0KIGRy
aXZlcnMvc3BpL3NwaV9pbXguYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaV9pbXgu
YyBiL2RyaXZlcnMvc3BpL3NwaV9pbXguYwppbmRleCBjODNjYTA1Li5kOGQ5YTM1IDEwMDY0NAot
LS0gYS9kcml2ZXJzL3NwaS9zcGlfaW14LmMKKysrIGIvZHJpdmVycy9zcGkvc3BpX2lteC5jCkBA
IC01NTQsNyArNTU0LDcgQEAgc3RhdGljIGludCBfX2luaXQgc3BpX2lteF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCXNwaV9pbXgtPmlycSA9IHBsYXRmb3JtX2dl
dF9pcnEocGRldiwgMCk7Ci0JaWYgKCFzcGlfaW14LT5pcnEpIHsKKwlpZiAoc3BpX2lteC0+aXJx
IDwgMCkgewogCQlyZXQgPSAtRUlOVkFMOwogCQlnb3RvIG91dF9pb3VubWFwOwogCX0KLS0gCjEu
Ni41LjIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUmV0dXJuIG9uIEluZm9ybWF0aW9uOgpHb29n
bGUgRW50ZXJwcmlzZSBTZWFyY2ggcGF5cyB5b3UgYmFjawpHZXQgdGhlIGZhY3RzLgpodHRwOi8v
cC5zZi5uZXQvc2Z1L2dvb2dsZS1kZXYyZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2
ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
