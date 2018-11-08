From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 5/7] spi: bcm2835: Document struct bcm2835_spi
Date: Thu, 8 Nov 2018 08:06:10 +0100
Message-ID: <2a61673f69aaa6d1f98c0dd81fc33d4365b0bbdd.1541659680.git.lukas@wunner.de>
References: <cover.1541659680.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1541659680.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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

RG9jdW1lbnQgdGhlIGRyaXZlcidzIGRhdGEgc3RydWN0dXJlIHRvIGxvd2VyIHRoZSBiYXJyaWVy
IHRvIGVudHJ5IGZvcgpjb250cmlidXRvcnMuCgpTaWduZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIg
PGx1a2FzQHd1bm5lci5kZT4KQ2M6IE1hdGhpYXMgRHVja2VjayA8bS5kdWNrZWNrQGt1bmJ1cy5k
ZT4KQ2M6IEZyYW5rIFBhdmxpYyA8Zi5wYXZsaWNAa3VuYnVzLmRlPgpDYzogTWFydGluIFNwZXJs
IDxrZXJuZWxAbWFydGluLnNwZXJsLm9yZz4KQ2M6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRy
b25uZXMub3JnPgotLS0KIGRyaXZlcnMvc3BpL3NwaS1iY20yODM1LmMgfCAxMSArKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9zcGktYmNtMjgzNS5jIGIvZHJpdmVycy9zcGkvc3BpLWJjbTI4MzUuYwppbmRleCBiMmZl
YmQ4ZTgwNmUuLjliOWI5OTI2YTk1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpLWJjbTI4
MzUuYworKysgYi9kcml2ZXJzL3NwaS9zcGktYmNtMjgzNS5jCkBAIC04MCw2ICs4MCwxNyBAQAog
CiAjZGVmaW5lIERSVl9OQU1FCSJzcGktYmNtMjgzNSIKIAorLyoqCisgKiBzdHJ1Y3QgYmNtMjgz
NV9zcGkgLSBCQ00yODM1IFNQSSBjb250cm9sbGVyCisgKiBAcmVnczogYmFzZSBhZGRyZXNzIG9m
IHJlZ2lzdGVyIG1hcAorICogQGNsazogY29yZSBjbG9jaywgZGl2aWRlZCB0byBjYWxjdWxhdGUg
c2VyaWFsIGNsb2NrCisgKiBAaXJxOiBpbnRlcnJ1cHQsIHNpZ25hbHMgVFggRklGTyBlbXB0eSBv
ciBSWCBGSUZPIMK+IGZ1bGwKKyAqIEB0eF9idWY6IHBvaW50ZXIgd2hlbmNlIG5leHQgdHJhbnNt
aXR0ZWQgYnl0ZSBpcyByZWFkCisgKiBAcnhfYnVmOiBwb2ludGVyIHdoZXJlIG5leHQgcmVjZWl2
ZWQgYnl0ZSBpcyB3cml0dGVuCisgKiBAdHhfbGVuOiByZW1haW5pbmcgYnl0ZXMgdG8gdHJhbnNt
aXQKKyAqIEByeF9sZW46IHJlbWFpbmluZyBieXRlcyB0byByZWNlaXZlCisgKiBAZG1hX3BlbmRp
bmc6IHdoZXRoZXIgYSBETUEgdHJhbnNmZXIgaXMgaW4gcHJvZ3Jlc3MKKyAqLwogc3RydWN0IGJj
bTI4MzVfc3BpIHsKIAl2b2lkIF9faW9tZW0gKnJlZ3M7CiAJc3RydWN0IGNsayAqY2xrOwotLSAK
Mi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtcnBpLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtcnBpLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtcnBpLWtlcm5lbAo=
