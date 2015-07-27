From: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Subject: [RESEND PATCH v2 1/2] dt: snps,dw-apb-ssi: Document new I/O data register width property
Date: Mon, 27 Jul 2015 13:37:14 +0200
Message-ID: <1437997035-3046-2-git-send-email-michael@smart-africa.com>
References: <1435163696-14767-1-git-send-email-michael@smart-africa.com>
 <1437997035-3046-1-git-send-email-michael@smart-africa.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437997035-3046-1-git-send-email-michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This change documents a new property for the snps,dw-apb-ssi device,
allowing an implementer to specify either four byte or two bytes
access to the SPI controller data register.

This supports a change that unbreaks this driver on picoXcell
platforms.

Signed-off-by: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
---

Changes in v2:
  - Incorporate review feedback from Andy Shevchenko, reworking the
    bindings to reflect common practice.

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bd99193..b4f1086 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - cs-gpios : Specifies the gpio pis to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
+- snps,reg-io-width : The I/O register width (in bytes) implemented by
+  this device.  Supported values are 2 or 4 (the default).
 
 Child nodes as per the generic SPI binding.
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
