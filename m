From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Thu, 11 Apr 2019 18:42:33 +0200
Message-ID: <20190411164235.49771-3-noralf@tronnes.org>
References: <20190411164235.49771-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, meghana.madhyastha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190411164235.49771-1-noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
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

RnJvbTogTWVnaGFuYSBNYWRoeWFzdGhhIDxtZWdoYW5hLm1hZGh5YXN0aGFAZ21haWwuY29tPgoK
U29tZSBkcml2ZXJzIGxpa2Ugc3BpX2JjbTI4MzUgaGF2ZSBhIG1heCBzaXplIG9uIERNQSB0cmFu
c2ZlcnMuIFdvcmsKYXJvdW5kIHRoaXMgYnkgc3BsaXR0aW5nIHVwIHRoZSB0cmFuc2ZlciBpZiBu
ZWNlc3NhcnkuCgotPm1heF90cmFuc2Zlcl9zaXplIGlzIE1BWF9JTlQgaWYgdGhlIGRyaXZlciBk
b2Vzbid0IHNldCBpdCwgc28gdGhpcyBjaGFuZ2UKd2lsbCBvbmx5IGFmZmVjdCBkcml2ZXJzIHRo
YXQgc2V0IHRoZSB2YWx1ZS4KClNpZ25lZC1vZmYtYnk6IE1lZ2hhbmEgTWFkaHlhc3RoYSA8bWVn
aGFuYS5tYWRoeWFzdGhhQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTm9yYWxmIFRyw7hubmVz
IDxub3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQogZHJpdmVycy9zcGkvc3BpLmMgfCA1ICsrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkv
c3BpLmMgYi9kcml2ZXJzL3NwaS9zcGkuYwppbmRleCAwNTg3NWU2M2JlNDMuLjIyYmM2NTgwMzJi
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpLmMKKysrIGIvZHJpdmVycy9zcGkvc3BpLmMK
QEAgLTEyOTksNiArMTI5OSwxMSBAQCBzdGF0aWMgdm9pZCBfX3NwaV9wdW1wX21lc3NhZ2VzKHN0
cnVjdCBzcGlfY29udHJvbGxlciAqY3RsciwgYm9vbCBpbl9rdGhyZWFkKQogCiAJdHJhY2Vfc3Bp
X21lc3NhZ2Vfc3RhcnQoY3Rsci0+Y3VyX21zZyk7CiAKKwlyZXQgPSBzcGlfc3BsaXRfdHJhbnNm
ZXJzX21heHNpemUoY3RsciwgY3Rsci0+Y3VyX21zZywgY3Rsci0+bWF4X2RtYV9sZW4sCisJCQkJ
CSAgR0ZQX0tFUk5FTCB8IEdGUF9ETUEpOworCWlmIChyZXQpCisJCWdvdG8gb3V0OworCiAJaWYg
KGN0bHItPnByZXBhcmVfbWVzc2FnZSkgewogCQlyZXQgPSBjdGxyLT5wcmVwYXJlX21lc3NhZ2Uo
Y3RsciwgY3Rsci0+Y3VyX21zZyk7CiAJCWlmIChyZXQpIHsKLS0gCjIuMjAuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJwaS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LXJwaS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJwaS1rZXJuZWwK
