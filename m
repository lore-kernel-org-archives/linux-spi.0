From: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Subject: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Tue, 24 May 2016 18:39:20 +0200
Message-ID: <1464107960-10775-1-git-send-email-christer@weinigel.se>
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Document how to use devicetree aliases to assign a stable
bus number to a spi bus.

Signed-off-by: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>

---

Trivial documentation change.

Not having used devicetree that much it was surprisingly hard to
figure out how to assign a stable bus number to a spi bus.  Add a
simple example that shows how to do that.

Mark Cced as the SPI maintainer.  Or should trivial documentation
fixes like this be addressed to someone else?

  /Christer

 Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 42d5954..c35c4c2 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
 			reg = <1>;
 		};
 	};
+
+Normally SPI buses are assigned dynamic bus numbers starting at 32766
+and counting downwards.  It is possible to assign the bus number
+statically using devicetee aliases.  For example, on the MPC5200 the
+"spi@f00" device above is connected to the "soc" bus.  To set its
+bus_num to 1 add an aliases entry like this:
+
+	aliases {
+		spi1 = "/soc/spi@f00";
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
