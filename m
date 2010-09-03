From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Fri, 3 Sep 2010 09:41:04 +0300
Message-ID: <20100903064104.GA2965@matterhorn.lan>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de>
	<4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
	<4C8068FD.1090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4C8068FD.1090705@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gMTAgU2VwIDAzLCBKYXNvbiBXYW5nIHdyb3RlOgo+IFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3Rl
Ogo+ID5IZWxsbyBKYXNvbiwKPiA+Cj4gPj4+QWN0dWFsbHkgSSB3b3VsZCBwcmVmZXIgb3VyIHBh
dGNoZXMsIGJ1dCBvZiBjb3Vyc2UgSSdtIGJpYXNlZCA6LSkKPiA+Pj4KPiA+Pj5JIGRvbid0IGtu
b3cgaG93IHdlIHNob3VsZCBoYW5kbGUgdGhpcy4gIEFuZCBTYXNjaGEgaXMgb24gdmFjYXRpb24g
dGhpcwo+ID4+PmFuZCBuZXh0IHdlZWsuICBJIHdpbGwgaW52ZXN0aWdhdGUgaWYgb3VyIHBhdGNo
ZXMgYXJlIGFscmVhZHkgZnJlZSB0byBiZQo+ID4+PnBvc3RlZC4KPiA+T0ssIEkgY2FuIHBvc3Qg
b3VyIHBhdGNoZXMuICBJIHRoaW5rIHRoZSBkcml2ZXIgcGFydCBpcyBxdWl0ZSBzaW1pbGFyLAo+
ID50aGUgcGxhdGZvcm0gcGFydCBpcyBub3QuICBCdXQgbG9vayBmb3IgeW91cnNlbGYsIEknbGwg
cG9zdCB0aGVtIGluIHJlcGx5IHRvCj4gPnRoaXMgbWFpbC4gIEhvcGVmdWxseSB3ZSBjYW4gam9p
biBmb3JjZXMgdG8gZ2V0IHRoZSBiZXN0IG91dCBvZiB0aGUgdHdvCj4gPmFwcHJvYWNoZXMuCj4g
T0ssIGdsYWQgdG8gc2VlIHRoZSByZWZpbmUgb2YgcGxhdGZvcm0gaGVhZGVyIGZpbGVzLgo+ID5C
VFcsIHdlJ3JlIHdvcmtpbmcgb24gbmFuZCAoRGF2aWQgbWVyZ2VkIGFuIGVhcmx5IHBhdGNoIHNl
cmllcyBieQo+ID5TYXNjaGEsIHdlIGhhdmUgc29tZSBmaXhlcyBwZW5kaW5nKSwgbWMxOTg5MiBh
bmQgaXB1djMsIHRvby4gIEp1c3QgdG8KPiA+bm90aWNlIHRoZSBwb3NzaWJpbGl0eSBmb3IgbW9y
ZSBjb29wZXJhdGlvbiBlYXJseS4gOi0pCj4gPgo+IEdvb2QgbmV3cywgYWZ0ZXIgYWRkIHNkbWEs
IG1jMTM4OTIgYW5kIGlwdXYzLCB0aGUgaS5NWDUxIHdpbGwKPiBiZSBsaWtlIGEgcmVhbCB1c2Vm
dWwgcGxhdGZvcm0uIDotKQoKSmFzb24sIFV3ZSwKCkNhbiB3ZSBwdXQgdXAgYSB3aWtpIHBhZ2Ug
b2Ygd2hhdCBkcml2ZXJzIGFyZSBiZWluZyB3b3JrZWQgb24gYnkgd2hvIHNvIHdlCmRvbid0IHdv
cmsgb24gdGhlIHNhbWUgZHJpdmVycz8KCldlIGFyZSBwbGFubmluZyB0byBsb29rIGF0IHRoZSBw
b3dlciBtYW5hZ2VtZW50IGFzcGVjdHMgb2YgdGhlIGkuTVg1MSBhdCBMaW5hcm8uCgovQW1pdAoK
LS0gCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KQW1pdCBLdWNoZXJpYSwgS2VybmVsIEVuZ2luZWVyIHx8IGFtaXQu
a3VjaGVyaWFAY2Fub25pY2FsLmNvbQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
