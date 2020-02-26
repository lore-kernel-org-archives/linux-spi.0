From: Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and "spi-tx-dtr"
Date: Wed, 26 Feb 2020 15:06:54 +0530
Message-ID: <20200226093703.19765-3-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, Pratyush Yadav <p.yadav@ti.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

These two DT properties express DTR receive and transmit capabilities of
a SPI flash and controller. Introduce two new mode bits: SPI_RX_DTR and
SPI_TX_DTR which correspond to the new DT properties. Set these bits
when the two corresponding properties are present in the device tree.
Also update the detection of unsupported mode bits to include the new
bits.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi.c       | 10 +++++++++-
 include/linux/spi/spi.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..25c8ed9343f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	/* Device DTR mode. */
+	if (of_property_read_bool(nc, "spi-tx-dtr"))
+		spi->mode |= SPI_TX_DTR;
+
+	if (of_property_read_bool(nc, "spi-rx-dtr"))
+		spi->mode |= SPI_RX_DTR;
+
 	if (spi_controller_is_slave(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3252,7 +3259,8 @@ int spi_setup(struct spi_device *spi)
 		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
-		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+		     SPI_TX_DTR  | SPI_RX_DTR);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba01ff5a..bf1108318389 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -183,6 +183,8 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
+#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.25.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
