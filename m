From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Date: Fri, 28 Jun 2019 17:23:54 +0200
Message-ID: <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
References: <20190628123023.4696-1-nuno.sa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: f.fainelli@gmail.com, sbranden@broadcom.com, rjui@broadcom.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
To: =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>, broonie@kernel.org,
 eric@anholt.net, Martin Sperl <kernel@martin.sperl.org>,
 Lukas Wunner <lukas@wunner.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190628123023.4696-1-nuno.sa@analog.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

SGkgTnVubywKCkFtIDI4LjA2LjE5IHVtIDE0OjMwIHNjaHJpZWIgTnVubyBTw6E6Cj4gQXMgc3Rh
dGVkIGluCj4gaHR0cHM6Ly93d3cucmFzcGJlcnJ5cGkub3JnL2RvY3VtZW50YXRpb24vaGFyZHdh
cmUvcmFzcGJlcnJ5cGkvc3BpL1JFQURNRS5tZCwKPiBvbmUgb2Ygcnggb3IgdHggYnVmZmVyJ3Mg
bXVzdCBiZSBudWxsLiBIb3dldmVyLCBpZiBETUEgaXMgZW5hYmxlZCwgdGhlCj4gZHJpdmVyIHNl
dHMgdGhlIFNQSV9DT05UUk9MTEVSX01VU1RfUlggfCBTUElfQ09OVFJPTExFUl9NVVNUX1RYIG9u
IHRoZQo+IGNvbnRyb2xsZXIgZmxhZ3MuIEhlbmNlLCB0aGUgc3BpIGNvcmUgd2lsbCBwcm92aWRl
IGR1bW15IGJ1ZmZlcnMgZXZlbiBpZgo+IG9uZSBvZiB0aGUgYnVmZmVycyB3YXMgc2V0IHRvIG51
bGwgYnkgdGhlIGRldmljZSBkcml2ZXIuIFRodXMsIHRoZQo+IGNvbW11bmljYXRpb24gd2l0aCB0
aGUgMy13aXJlIGRldmljZSBmYWlscy4KPgo+IFRoaXMgcGF0Y2ggdXNlcyB0aGUgcHJlcGFyZV9t
ZXNzYWdlIGNhbGxiYWNrIHRvIGxvb2sgZm9yIHRoZSBkZXZpY2UgbW9kZQo+IGFuZCBzZXRzL2Ns
ZWFycyB0aGUgU1BJX0NPTlRST0xMRVJfTVVTVF9SWCB8IFNQSV9DT05UUk9MTEVSX01VU1RfVFgg
b24gYQo+IHBlciBzcGkgbWVzc2FnZSBiYXNpcy4gSXQgYWxzbyBhc3N1bWVzIHRoYXQgRE1BIGlz
IG5vdCBzdXBwb3J0ZWQgb24KPiBoYWxmLWR1cGxleCBkZXZpY2VzLgo+Cj4gU2lnbmVkLW9mZi1i
eTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4KCmkgbmV2ZXIgdGVzdGVkIHRoZSAzLXdp
cmUgbW9kZS4gQ291bGQgeW91IHBsZWFzZSBkZXNjcmliZSB5b3VyIHRlc3Qgc2V0dXA/CgpATWFy
dGluLCBATHVrYXMgQXJlIHlvdSBmaW5lIHdpdGggdGhpcyBwYXRjaD8KCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
