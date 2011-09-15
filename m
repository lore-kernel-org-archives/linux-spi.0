From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI chipselects
	are used
Date: Thu, 15 Sep 2011 18:24:46 -0300
Message-ID: <CAOMZO5DWaP0r=fRvR-VpaRWF1hLm4Cg8FF+etMpGniT8tb5O8g@mail.gmail.com>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
	<20110915210108.GG3523@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110915210108.GG3523-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

R3JhbnQsCgpPbiBUaHUsIFNlcCAxNSwgMjAxMSBhdCA2OjAxIFBNLCBHcmFudCBMaWtlbHkgPGdy
YW50Lmxpa2VseUBzZWNyZXRsYWIuY2E+IHdyb3RlOgouLi4KPiBJdCBsb29rcyBsaWtlIHRoZSBy
ZW1vdmFsIG9mIHRoaXMgbGluZSB3aWxsIGJyZWFrIERUIHVzZXJzLiDCoFBlcmhhcHMKPiB0aGUg
c3BpX2lteC0+Y2hpcHNlbGVjdFtpXSBsaW5lIHNob3VsZCBqdXN0IGJlIG1vdmVkIGJlZm9yZSB0
aGUKPiAnaWYgKGNwX2dwaW8gPCAwKScgbGluZS4KClllcywgdGhpcyBpcyBhZGRyZXNzZWQgaW4g
djMgbm93LgoKVGhhbmtzLAoKRmFiaW8gRXN0ZXZhbQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRv
aW5nIE1vcmUgd2l0aCBMZXNzOiBUaGUgTmV4dCBHZW5lcmF0aW9uIFZpcnR1YWwgRGVza3RvcCAK
V2hhdCBhcmUgdGhlIGtleSBvYnN0YWNsZXMgdGhhdCBoYXZlIHByZXZlbnRlZCBtYW55IG1pZC1t
YXJrZXQgYnVzaW5lc3Nlcwpmcm9tIGRlcGxveWluZyB2aXJ0dWFsIGRlc2t0b3BzPyAgIEhvdyBk
byBuZXh0LWdlbmVyYXRpb24gdmlydHVhbCBkZXNrdG9wcwpwcm92aWRlIGNvbXBhbmllcyBhbiBl
YXNpZXItdG8tZGVwbG95LCBlYXNpZXItdG8tbWFuYWdlIGFuZCBtb3JlIGFmZm9yZGFibGUKdmly
dHVhbCBkZXNrdG9wIG1vZGVsLmh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3NmbmwvMTE0
LzUxNDI2NDc0LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpzcGktZGV2ZWwtZ2VuZXJhbCBtYWlsaW5nIGxpc3QKc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL3NwaS1kZXZlbC1nZW5lcmFsCg==
