From: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi: add "spi-lsb-first" to devicetree
Date: Tue, 1 Apr 2014 15:55:31 +0800
Message-ID: <1396338931-10887-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<R63061-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

add optional property devicetree for SPI slave nodes
into devicetree so that LSB mode can be enabled by devicetree.

Signed-off-by: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 4 ++++
 drivers/spi/spi.c                                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e5a4d1b..fdd9f15 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -55,11 +55,15 @@ contain the following properties.
     		chip select active high
 - spi-3wire       - (optional) Empty property indicating device requires
     		    3-wire mode.
+- spi-lsb-first   - (optional) Empty property indicating device requires
+		LSB first mode.
 - spi-tx-bus-width - (optional) The bus width(number of data wires) that
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
 
+- spi-rx-bus-width - (optional) The bus width(number of data wires) that
+                      used for MISO. Defaults to 1 if not present.
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in SPI system transfered in 2 wires(DUAL) or 4 wires(QUAD).
 Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 23756b0..0a20a90 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1050,6 +1050,8 @@ static void of_register_spi_devices(struct spi_master *master)
 			spi->mode |= SPI_CS_HIGH;
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
+		if (of_find_property(nc, "spi-lsb-first", NULL))
+			spi->mode |= SPI_LSB_FIRST;
 
 		/* Device DUAL/QUAD mode */
 		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
-- 
1.8.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
