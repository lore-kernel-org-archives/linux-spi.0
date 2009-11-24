From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 32/38] don't use __exit_p to wrap
	plat_mpc8xxx_spi_remove
Date: Tue, 24 Nov 2009 22:07:27 +0100
Message-ID: <1259096853-18909-32-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-23-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-24-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-25-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-26-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-27-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-29-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-30-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-31-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1259096853-18909-31-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

VGhlIGZ1bmN0aW9uIHBsYXRfbXBjOHh4eF9zcGlfcmVtb3ZlIGlzIGRlZmluZWQgdXNpbmcgX19k
ZXZleGl0LCBzbyBkb24ndAp1c2UgX19leGl0X3AgYnV0IF9fZGV2ZXhpdF9wIHRvIHdyYXAgaXQu
CgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlPgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4K
Q2M6IEt1bWFyIEdhbGEgPGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc+CkNjOiBBbnRvbiBWb3Jv
bnRzb3YgPGF2b3JvbnRzb3ZAcnUubXZpc3RhLmNvbT4KQ2M6IEdyYW50IExpa2VseSA8Z3JhbnQu
bGlrZWx5QHNlY3JldGxhYi5jYT4KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKQ2M6
IGRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnCkNjOiBEYXZpZCBCcm93bmVsbCA8
ZGJyb3duZWxsQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4KQ2M6IHNwaS1kZXZlbC1nZW5lcmFsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldAotLS0KIGRyaXZlcnMvc3BpL3NwaV9tcGM4eHh4LmMgfCAgICAy
ICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGlfbXBjOHh4eC5jIGIvZHJpdmVycy9zcGkvc3BpX21w
Yzh4eHguYwppbmRleCAwZmQwZWM0Li4xZDk4YmU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9z
cGlfbXBjOHh4eC5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaV9tcGM4eHh4LmMKQEAgLTkwMCw3ICs5
MDAsNyBAQCBzdGF0aWMgaW50IF9fZGV2ZXhpdCBwbGF0X21wYzh4eHhfc3BpX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogTU9EVUxFX0FMSUFTKCJwbGF0Zm9ybTptcGM4eHh4
X3NwaSIpOwogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXBjOHh4eF9zcGlfZHJpdmVy
ID0gewogCS5wcm9iZSA9IHBsYXRfbXBjOHh4eF9zcGlfcHJvYmUsCi0JLnJlbW92ZSA9IF9fZXhp
dF9wKHBsYXRfbXBjOHh4eF9zcGlfcmVtb3ZlKSwKKwkucmVtb3ZlID0gX19kZXZleGl0X3AocGxh
dF9tcGM4eHh4X3NwaV9yZW1vdmUpLAogCS5kcml2ZXIgPSB7CiAJCS5uYW1lID0gIm1wYzh4eHhf
c3BpIiwKIAkJLm93bmVyID0gVEhJU19NT0RVTEUsCi0tIAoxLjYuNS4yCgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVl
IENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKdHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0
IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQg
eW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3
IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCnNwaS1kZXZl
bC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRl
dmVsLWdlbmVyYWwK
