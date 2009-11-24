From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 20/38] move spidev_remove to
	.devexit.text
Date: Tue, 24 Nov 2009 22:07:15 +0100
Message-ID: <1259096853-18909-20-git-send-email-u.kleine-koenig@pengutronix.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1259096853-18909-19-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

VGhlIGZ1bmN0aW9uIHNwaWRldl9yZW1vdmUgaXMgdXNlZCBvbmx5IHdyYXBwZWQgYnkgX19kZXZl
eGl0X3Agc28gZGVmaW5lCml0IHVzaW5nIF9fZGV2ZXhpdC4KClNpZ25lZC1vZmYtYnk6IFV3ZSBL
bGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CkFja2VkLWJ5OiBT
YW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+CkNjOiBEYXZpZCBCcm93bmVsbCA8ZGJyb3du
ZWxsQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+CkNjOiBXb2xmZ2FuZyBPY2tlciA8d2VvQHJlY2Nvd2FyZS5kZT4KQ2M6
IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQHN1c2UuZGU+CkNjOiBzcGktZGV2ZWwtZ2VuZXJh
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IE1pa2UgRnJ5c2luZ2VyIDx2YXBpZXJAZ2VudG9vLm9yZz4KQ2M6IEFsZXhleSBEb2JyaXlh
biA8YWRvYnJpeWFuQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3NwaS9zcGlkZXYuYyB8ICAgIDIg
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaWRldi5jIGIvZHJpdmVycy9zcGkvc3BpZGV2LmMKaW5k
ZXggNWQyMzk4My4uNTQ3MWJmYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpZGV2LmMKKysr
IGIvZHJpdmVycy9zcGkvc3BpZGV2LmMKQEAgLTYxMCw3ICs2MTAsNyBAQCBzdGF0aWMgaW50IHNw
aWRldl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCXJldHVybiBzdGF0dXM7CiB9CiAK
LXN0YXRpYyBpbnQgc3BpZGV2X3JlbW92ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQorc3RhdGlj
IGludCBfX2RldmV4aXQgc3BpZGV2X3JlbW92ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogewog
CXN0cnVjdCBzcGlkZXZfZGF0YQkqc3BpZGV2ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7CiAKLS0g
CjEuNi41LjIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGV0IENyeXN0YWwgUmVwb3J0cyBoYW5k
bGUgdGhlIHJlcG9ydGluZyAtIEZyZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAtRGF5IAp0cmlh
bC4gU2ltcGxpZnkgeW91ciByZXBvcnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95bWVu
dCAtIGFuZCBmb2N1cyBvbiAKd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2Rp
bmcuIERpc2NvdmVyIHdoYXQncyBuZXcgd2l0aApDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDov
L3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1n
ZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
