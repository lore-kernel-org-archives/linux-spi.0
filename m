From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
	370/XP
Date: Mon, 4 Feb 2013 13:51:20 -0300
Message-ID: <20130204165119.GA2440@localhost>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359995888-2385-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGksCgpUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFNQSSBjb250cm9sbGVyCmF2
YWlsYWJsZSBpbiBBcm1hZGEgMzcwIGFuZCBBcm1hZGEgWFAgU29DLgoKVGhlIHBhdGNoZXMgYXJl
IGJhc2VkIGluIEphc29uIENvb3BlcidzIG12ZWJ1L2R0IGJyYW5jaC4KCkZlZWwgZnJlZSB0byB0
ZXN0IGFuZC9vciBwcm92aWRlIGZlZWRiYWNrLgoKRXplcXVpZWwgR2FyY2lhICgyKToKIEFSTTog
bXZlYnU6IFVwZGF0ZSBkZWZjb25maWcgdG8gc2VsZWN0IFNQSSBzdXBwb3J0CiBBUk06IG12ZWJ1
OiBBZGQgc3VwcG9ydCBmb3IgU1BJIGNvbnRyb2xsZXIgaW4gQXJtYWRhIDM3MC9YUAoKIGFyY2gv
YXJtL2Jvb3QvZHRzL2FybWFkYS0zNzAteHAuZHRzaSB8ICAgMjIgKysrKysrKysrKysrKysrKysr
KysrKwogYXJjaC9hcm0vY29uZmlncy9tdmVidV9kZWZjb25maWcgICAgIHwgICAgMiArKwogMiBm
aWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKVGhhbmtzLAoK
LS0gCkV6ZXF1aWVsIEdhcmPDrWEsIEZyZWUgRWxlY3Ryb25zCkVtYmVkZGVkIExpbnV4LCBLZXJu
ZWwgYW5kIEFuZHJvaWQgRW5naW5lZXJpbmcKaHR0cDovL2ZyZWUtZWxlY3Ryb25zLmNvbQoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkV2ZXJ5b25lIGhhdGVzIHNsb3cgd2Vic2l0ZXMuIFNvIGRvIHdl
LgpNYWtlIHlvdXIgd2ViIGFwcHMgZmFzdGVyIHdpdGggQXBwRHluYW1pY3MKRG93bmxvYWQgQXBw
RHluYW1pY3MgTGl0ZSBmb3IgZnJlZSB0b2RheToKaHR0cDovL3Auc2YubmV0L3NmdS9hcHBkeW5f
ZDJkX2phbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpz
cGktZGV2ZWwtZ2VuZXJhbCBtYWlsaW5nIGxpc3QKc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L3NwaS1kZXZlbC1nZW5lcmFsCg==
