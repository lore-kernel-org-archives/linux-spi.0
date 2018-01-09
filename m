From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCHv1 1/3] dt-bindings: spi: Add DT bindings for Synquacer
Date: Tue,  9 Jan 2018 18:40:32 +0530
Message-ID: <1515503432-8971-1-git-send-email-jassisinghbrar@gmail.com>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515503383-8909-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch adds documentation for Device-Tree bindings for the
Socionext Synquacer spi driver.

Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-synquacer.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
new file mode 100644
index 0000000..d013cfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
@@ -0,0 +1,24 @@
+* Socionext Synquacer HS-SPI bindings
+
+Required Properties:
+- compatible: should be "socionext,synquacer-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- clocks: Must contain an entry for rate source clock(s).
+- clock-names: Shall be "iHCLK" or "iPCLK". iHCLK is preferred over iPCLK
+
+Optional Properties:
+- num-cs: total number of chipselects
+- socionext,use-rtm: boolean, if required to use "retimed clock" for RX
+- socionext,set-aces: boolean, if same active clock edges field to be set.
+
+Example:
+
+	spi0: spi@ff110000 {
+		compatible = "socionext,synquacer-spi";
+		reg = <0xff110000 0x1000>;
+		clocks = <&clk_fip006_spi>;
+		clock-names = "iHCLK";
+		socionext,use-rtm;
+		socionext,set-aces;
+	};
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
