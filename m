From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/imx: Fix spi-imx when the hardware SPI chipselects
	are used
Date: Thu, 15 Sep 2011 15:27:59 -0300
Message-ID: <CAOMZO5DdXke9UyNnM2q2As1vJP0y9Ymug8neUTBDqbaR=00fvg@mail.gmail.com>
References: <1316103406-16401-1-git-send-email-fabio.estevam@freescale.com>
	<20110915181707.GC29357@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110915181707.GC29357-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

MjAxMS85LzE1IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+OgouLi4KPiBJIHRoaW5rIHRoaXMgaXMgd3JvbmcuIE15IGZpcnN0IGd1ZXNzIGlzIHlvdSBu
ZWVkIHRvIG1vdmUKPgo+IMKgIMKgIMKgIMKgc3BpX2lteC0+Y2hpcHNlbGVjdFtpXSA9IGNzX2dw
aW87Cj4KPiBiZWZvcmUKPgo+IMKgIMKgIMKgIMKgaWYgKGNzX2dwaW8gPCAwKQo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY29udGludWU7Cj4KPiBEb2VzIHRoYXQgbWFrZSBzZW5zZSBhbmQgd29y
a3M/CgpZZXMsIEkgd2FzIGFib3V0IHRvIHNlbmQgYSB2MiBldmVuIHByaW9yIHRvIGdldHRpbmcg
eW91ciBlbWFpbC4KClRoYW5rcywKCkZhYmlvIEVzdGV2YW0KCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpEb2luZyBNb3JlIHdpdGggTGVzczogVGhlIE5leHQgR2VuZXJhdGlvbiBWaXJ0dWFsIERlc2t0
b3AgCldoYXQgYXJlIHRoZSBrZXkgb2JzdGFjbGVzIHRoYXQgaGF2ZSBwcmV2ZW50ZWQgbWFueSBt
aWQtbWFya2V0IGJ1c2luZXNzZXMKZnJvbSBkZXBsb3lpbmcgdmlydHVhbCBkZXNrdG9wcz8gICBI
b3cgZG8gbmV4dC1nZW5lcmF0aW9uIHZpcnR1YWwgZGVza3RvcHMKcHJvdmlkZSBjb21wYW5pZXMg
YW4gZWFzaWVyLXRvLWRlcGxveSwgZWFzaWVyLXRvLW1hbmFnZSBhbmQgbW9yZSBhZmZvcmRhYmxl
CnZpcnR1YWwgZGVza3RvcCBtb2RlbC5odHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZm5s
LzExNC81MTQyNjQ3NC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
