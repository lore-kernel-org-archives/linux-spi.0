From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: pl022: Document property values
Date: Mon, 20 Mar 2017 10:59:59 +0100
Message-ID: <20170320095959.6813-1-borneo.antonio@gmail.com>
Cc: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The property "pl022,com-mode" can only assume one of the values of
the enum ssp_mode, defined in include/linux/amba/pl022.h
List the possible numeric values and report the associated meaning.

Signed-off-by: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 Documentation/devicetree/bindings/spi/spi_pl022.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
index 2692a5726c3f..7638b4968ddb 100644
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -30,7 +30,10 @@ contain the following properties.
 	0: SPI
 	1: Texas Instruments Synchronous Serial Frame Format
 	2: Microwire (Half Duplex)
-- pl022,com-mode : polling, interrupt or dma
+- pl022,com-mode : specifies the transfer mode:
+	0: interrupt mode
+	1: polling mode (default mode if property not present)
+	2: DMA mode
 - pl022,rx-level-trig : Rx FIFO watermark level
 - pl022,tx-level-trig : Tx FIFO watermark level
 - pl022,ctrl-len : Microwire interface: Control length
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
