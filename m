From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
Date: Mon, 11 Jul 2011 09:49:07 +0200
Message-ID: <19994.43763.88454.662575@ipc1.ka-ro>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
	<20110711073136.GA13840@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110711073136.GA13840@pengutronix.de>
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

VXdlIEtsZWluZS1Lw7ZuaWcgd3JpdGVzOgo+IE9uIE1vbiwgSnVsIDExLCAyMDExIGF0IDA5OjE1
OjM0QU0gKzAyMDAsIExvdGhhciBXYcOfbWFubiB3cm90ZToKPiA+IEhpLAo+ID4gCj4gPiBTaGF3
biBHdW8gd3JpdGVzOgo+ID4gPiBzcGlfaW14X2RldnR5cGVfZGF0YSBoYXMgYWxyZWFkeSBiZWVu
IGRyaXZlciBwcml2YXRlIGRhdGEuICBUaGVyZSBpcwo+ID4gPiByZWFsbHkgbm8gbmVlZCB0byBt
YWtlIGEgY29weSBpbiBzcGlfaW14X2RhdGEuICBJbnN0ZWFkLCBhIHJlZmVyZW5jZQo+ID4gPiBw
b2ludGVyIHdvcmtzIHBlcmZlY3RseSBmaW5lLgo+ID4gPiAKPiA+IFlvdSBvYnZpb3VzbHkgb3Zl
cmxvb2tlZCwgdGhhdCB0aGUgY29weSBpcyBkb25lIG9uIHB1cnBvc2UgdG8ga2VlcAo+ID4gb25s
eSB0aGUgZGF0YSB0aGF0IGlzIGFjdHVhbGx5IG5lZWRlZCBhbmQgZGlzY2FyZCBldmVyeXRoaW5n
IGVsc2UKPiA+IGFmdGVyIGluaXRpYWxpc2F0aW9uLgo+IHRob3VnaCB5b3UgY291bGQgYXJndWUg
dGhhdCBfX2RldmluaXRkYXRhIGlzbid0IGRpc2NhcmRlZCBvbiBtb2Rlcm4KPiBzeXN0ZW1zIGFu
eWhvdyAoYW5kIFNoYXduJ3MgcGF0Y2ggdGFrZXMgY2FyZSBvZiByZW1vdmluZyB0aGF0Cj4gYW5u
b3RhdGlvbikuCj4gClNoYXduJ3MgY29tbWVudCBzaG91bGQgcHJvYmFibHkgaGF2ZSByZWZsZWN0
ZWQgdGhhdC4uLgoKCkxvdGhhciBXYcOfbWFubgotLSAKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KCkthLVJvIGVsZWN0cm9uaWNzIEdt
YkggfCBQYXNjYWxzdHJhw59lIDIyIHwgRCAtIDUyMDc2IEFhY2hlbgpQaG9uZTogKzQ5IDI0MDgg
MTQwMi0wIHwgRmF4OiArNDkgMjQwOCAxNDAyLTEwCkdlc2Now6RmdHNmw7xocmVyOiBNYXR0aGlh
cyBLYXVzc2VuCkhhbmRlbHNyZWdpc3RlcmVpbnRyYWc6IEFtdHNnZXJpY2h0IEFhY2hlbiwgSFJC
IDQ5OTYKCnd3dy5rYXJvLWVsZWN0cm9uaWNzLmRlIHwgaW5mb0BrYXJvLWVsZWN0cm9uaWNzLmRl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
