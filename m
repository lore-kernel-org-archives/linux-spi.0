From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
Date: Mon, 11 Jul 2011 09:32:32 +0200
Message-ID: <19994.42768.316833.688381@ipc1.ka-ro>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
	<20110711073523.GA19105@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110711073523.GA19105-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGksCgpTaGF3biBHdW8gd3JpdGVzOgo+IE9uIE1vbiwgSnVsIDExLCAyMDExIGF0IDA5OjE1OjM0
QU0gKzAyMDAsIExvdGhhciBXYcOfbWFubiB3cm90ZToKPiA+IEhpLAo+ID4gCj4gPiBTaGF3biBH
dW8gd3JpdGVzOgo+ID4gPiBzcGlfaW14X2RldnR5cGVfZGF0YSBoYXMgYWxyZWFkeSBiZWVuIGRy
aXZlciBwcml2YXRlIGRhdGEuICBUaGVyZSBpcwo+ID4gPiByZWFsbHkgbm8gbmVlZCB0byBtYWtl
IGEgY29weSBpbiBzcGlfaW14X2RhdGEuICBJbnN0ZWFkLCBhIHJlZmVyZW5jZQo+ID4gPiBwb2lu
dGVyIHdvcmtzIHBlcmZlY3RseSBmaW5lLgo+ID4gPiAKPiA+IFlvdSBvYnZpb3VzbHkgb3Zlcmxv
b2tlZCwgdGhhdCB0aGUgY29weSBpcyBkb25lIG9uIHB1cnBvc2UgdG8ga2VlcAo+ID4gb25seSB0
aGUgZGF0YSB0aGF0IGlzIGFjdHVhbGx5IG5lZWRlZCBhbmQgZGlzY2FyZCBldmVyeXRoaW5nIGVs
c2UKPiA+IGFmdGVyIGluaXRpYWxpc2F0aW9uLgo+ID4gCj4gSSBkaWQgbm90IG92ZXJsb29rIHRo
YXQsIGFzIEkgcmVtb3ZlZCBfX2RldmluaXRkYXRhIHRoZXJlLgo+IApCdXQgbm93IHlvdSBrZWVw
IHRoZSB3aG9sZSBhcnJheSBvZiB3aGljaCBvbmx5IG9uZSBlbnRyeSBpcyBiZWluZwp1c2VkIGlu
c3RlYWQgb2Ygb25seSB0aGUgdXNlZCBlbnRyeS4KCgpMb3RoYXIgV2HDn21hbm4KLS0gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCgpL
YS1SbyBlbGVjdHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAyMiB8IEQgLSA1MjA3NiBBYWNo
ZW4KUGhvbmU6ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0MDggMTQwMi0xMApHZXNjaMOk
ZnRzZsO8aHJlcjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVnaXN0ZXJlaW50cmFnOiBBbXRz
Z2VyaWNodCBBYWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVjdHJvbmljcy5kZSB8IGluZm9A
a2Fyby1lbGVjdHJvbmljcy5kZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFsbCBvZiB0aGUg
ZGF0YSBnZW5lcmF0ZWQgaW4geW91ciBJVCBpbmZyYXN0cnVjdHVyZSBpcyBzZXJpb3VzbHkgdmFs
dWFibGUuCldoeT8gSXQgY29udGFpbnMgYSBkZWZpbml0aXZlIHJlY29yZCBvZiBhcHBsaWNhdGlv
biBwZXJmb3JtYW5jZSwgc2VjdXJpdHkgCnRocmVhdHMsIGZyYXVkdWxlbnQgYWN0aXZpdHksIGFu
ZCBtb3JlLiBTcGx1bmsgdGFrZXMgdGhpcyBkYXRhIGFuZCBtYWtlcyAKc2Vuc2Ugb2YgaXQuIElU
IHNlbnNlLiBBbmQgY29tbW9uIHNlbnNlLgpodHRwOi8vcC5zZi5uZXQvc2Z1L3NwbHVuay1kMmQt
YzIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kc3BpLWRl
dmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9zcGkt
ZGV2ZWwtZ2VuZXJhbAo=
