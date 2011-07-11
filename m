From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
Date: Mon, 11 Jul 2011 09:15:34 +0200
Message-ID: <19994.41750.920408.162356@ipc1.ka-ro>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
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

SGksCgpTaGF3biBHdW8gd3JpdGVzOgo+IHNwaV9pbXhfZGV2dHlwZV9kYXRhIGhhcyBhbHJlYWR5
IGJlZW4gZHJpdmVyIHByaXZhdGUgZGF0YS4gIFRoZXJlIGlzCj4gcmVhbGx5IG5vIG5lZWQgdG8g
bWFrZSBhIGNvcHkgaW4gc3BpX2lteF9kYXRhLiAgSW5zdGVhZCwgYSByZWZlcmVuY2UKPiBwb2lu
dGVyIHdvcmtzIHBlcmZlY3RseSBmaW5lLgo+IApZb3Ugb2J2aW91c2x5IG92ZXJsb29rZWQsIHRo
YXQgdGhlIGNvcHkgaXMgZG9uZSBvbiBwdXJwb3NlIHRvIGtlZXAKb25seSB0aGUgZGF0YSB0aGF0
IGlzIGFjdHVhbGx5IG5lZWRlZCBhbmQgZGlzY2FyZCBldmVyeXRoaW5nIGVsc2UKYWZ0ZXIgaW5p
dGlhbGlzYXRpb24uCgoKTG90aGFyIFdhw59tYW5uCi0tIApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwoKS2EtUm8gZWxlY3Ryb25pY3Mg
R21iSCB8IFBhc2NhbHN0cmHDn2UgMjIgfCBEIC0gNTIwNzYgQWFjaGVuClBob25lOiArNDkgMjQw
OCAxNDAyLTAgfCBGYXg6ICs0OSAyNDA4IDE0MDItMTAKR2VzY2jDpGZ0c2bDvGhyZXI6IE1hdHRo
aWFzIEthdXNzZW4KSGFuZGVsc3JlZ2lzdGVyZWludHJhZzogQW10c2dlcmljaHQgQWFjaGVuLCBI
UkIgNDk5NgoKd3d3Lmthcm8tZWxlY3Ryb25pY3MuZGUgfCBpbmZvQGthcm8tZWxlY3Ryb25pY3Mu
ZGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
