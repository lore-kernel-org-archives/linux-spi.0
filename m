From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Sun, 5 Jul 2015 11:14:59 +1000
Message-ID: <1400E1A3-43E1-4D0E-A54D-E5D668A4C516@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
 <20150622165529.1b758b07@north>
 <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org>
 <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org>
 <20150630094232.GM11162@sirena.org.uk>
 <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540@martin.sperl.org>
 <55945448.7010502@tronnes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 =?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>
To: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <55945448.7010502-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Cj4gT24gMDIuMDcuMjAxNSwgYXQgMDY6NTcsIE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25u
ZXMub3JnPiB3cm90ZToKPiAKPiAKPiBEZW4gMDEuMDcuMjAxNSAyMTozOSwgc2tyZXYgTWFydGlu
IFNwZXJsOgo+Pj4gT24gMzAuMDYuMjAxNSwgYXQgMTk6NDIsIE1hcmsgQnJvd24gPGJyb29uaWVA
a2VybmVsLm9yZz4gd3JvdGU6Cj4+PiAKPj4+IFRoaXMgbG9va3MgcmVsZXZhbnQ6Cj4+PiAKPj4+
Pj4+IE9uIDIyLjA2LjIwMTUsIGF0IDE2OjU1LCBKYWt1YiBLaWNpxYRza2kgPG1vb3JyYXkzQHdw
LnBsPiB3cm90ZToKPj4+Pj4+IEFzIG1lbnRpb25lZCBieSBOb3JhbGYgVUFSVDEgaXMgcXVpdGUg
Y29tbW9ubHkgdXNlZCBvbiBDb21wdXRlIE1vZHVsZXMuCj4+Pj4+PiBQcm9wZXIgZHJpdmVyIC0g
cGVyaGFwcyBtb2RlbGxlZCBhcyBhIGJ1cyAtIHNlZW1zIGxpa2UgYSBwcmVyZXF1aXNpdGUKPj4+
Pj4+IGZvciB0aGlzIHdvcmsuICBZb3UgYXJlIGFsc28gbm90IHVzaW5nIElSUSBtdXggaW4gRFQg
YmluZGluZyBleGFtcGxlCj4+Pj4+PiB3aGljaCBpcyB2ZXJ5IG1pc2xlYWRpbmcuCj4gCj4gWy4u
Ll0KPiAKPj4gRmluYWxseSBhc2tpbmcgZm9yIGEgcmVjb21tZW5kYXRpb24gd2l0aCByZWdhcmRz
IHRvIHVzaW5nIGEgYnVzCj4+IHRvIGFyYml0cmF0ZSBhY2Nlc3MgdG8gdGhlIGVuYWJsZSByZWdp
c3RlciB0aGVyZSB3YXMgbm8gZmVlZGJhY2sKPj4gaG93IHRoaXMgY291bGQgYmUgZ2V0IGltcGxl
bWVudGVkLi4uCj4gCj4gTWF5YmUgeW91IGNhbiB1c2UgZHJpdmVycy9tZmQvc3lzY29uLmMgdG8g
ZW5hYmxlIHNoYXJlZCBhY2Nlc3MgdG8gdGhlCj4gYXV4IGVuYWJsZSByZWdpc3Rlci4gVGhlbiB0
aGUgc3BpIGRyaXZlciBjb3VsZCBnZXQgdGhlIHJlZ21hcCB3aXRoOgo+IGF1eF9yZWdtYXAgPSBz
eXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKG5wLCAic3lzY29uIik7CgpTZWVtcyBhcyBp
ZiB5b3UgZm91bmQgYW4gYW5zd2VyIHRvIG15IG9yaWdpbmFsIHF1ZXN0aW9uIG9mIGlmCnRoZXJl
IGlzIGEgZnJhbWV3b3JrIHRvIGhhbmRsZSB0aGlzLgoKPiBBYm91dCBzaGFyaW5nIHRoZSBhdXgg
aW50ZXJydXB0LCBjb3VsZCB0aGlzIGJlIGltcGxlbWVudGVkIGluIGlycS1iY20yODM1Cj4gYXMg
YSBCYW5rIDM/Ck9idmlvdXNseSBpdCBjb3VsZCwgYnV0IHRoZSBxdWVzdGlvbiBpcyBpZiBpdCBp
cyBub3QgbW9yZSBvdmVyaGVhZCB0aGFuIHVzaW5nCmEgc2hhcmVkIGludGVycnVwdCAocmVxdWVz
dGluZyBhbiBpbnRlcnJ1cHQgd2l0aCB0aGUgc2hhcmVkIGZsYWcgc2V0KSBpbiB0aGUKZmlyc3Qg
cGxhY2UgKGxpa2UgdGhpcyBkcml2ZXIgY3VycmVudGx5IGRvZXMgb3IgaTJjIGFuZCBVU0IgZG8p
LgoKSSBhbSB3b3JraW5nIG9uIGEgbmV3IHZlcnNpb24gdG8gbWFrZSB1c2Ugb2Ygc3lzY29uLgoK
VGhhbmtzLCBNYXJ0aW4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtcnBpLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtcnBpLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtcnBpLWtlcm5lbAo=
