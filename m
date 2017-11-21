From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] spi: xilinx: Add support for xlnx,axi-quad-spi-1.00.a
Date: Tue, 21 Nov 2017 10:09:03 +0100
Message-ID: <20171121090904.6901-2-ricardo.ribalda@gmail.com>
References: <20171121090904.6901-1-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171121090904.6901-1-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The driver has been successfully tested with Xilinx's core
axi-quad-spi-1.0.0a. Documented on DS843:

https://www.xilinx.com/support/documentation/ip_documentation/axi_quad_spi/v1_00_a/ds843_axi_quad_spi.pdf

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 2 +-
 drivers/spi/spi-xilinx.c                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index c7b7856bd528..7bf61efc66c8 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -2,7 +2,7 @@ Xilinx SPI controller Device Tree Bindings
 -------------------------------------------------
 
 Required properties:
-- compatible		: Should be "xlnx,xps-spi-2.00.a" or "xlnx,xps-spi-2.00.b"
+- compatible		: Should be "xlnx,xps-spi-2.00.a", "xlnx,xps-spi-2.00.b" or "xlnx,axi-quad-spi-1.00.a"
 - reg			: Physical base address and size of SPI registers map.
 - interrupts		: Property with a value describing the interrupt
 			  number.
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index e0b9fe1d0e37..63fedc49ae9c 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -381,6 +381,7 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
 }
 
 static const struct of_device_id xilinx_spi_of_match[] = {
+	{ .compatible = "xlnx,axi-quad-spi-1.00.a", },
 	{ .compatible = "xlnx,xps-spi-2.00.a", },
 	{ .compatible = "xlnx,xps-spi-2.00.b", },
 	{}
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
