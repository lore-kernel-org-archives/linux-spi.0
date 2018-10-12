From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 02/18] spi: Prepare things for octo mode support
Date: Fri, 12 Oct 2018 10:48:09 +0200
Message-ID: <20181012084825.23697-3-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Add the necessary flags and checks in spi.h, spi.c and spi-mem.c to
support octo mode.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi-mem.c   |  7 +++++++
 drivers/spi/spi.c       | 12 ++++++++++--
 include/linux/spi/spi.h |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 4a84b07a3186..2379efcaf1c6 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 
 		break;
 
+	case 8:
+		if ((tx && (mode & SPI_TX_OCTO)) ||
+		    (!tx && (mode & SPI_RX_OCTO)))
+			return 0;
+
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036c..bc6fc74ff4ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTO;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTO;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
@@ -2779,14 +2785,16 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO | SPI_RX_DUAL |
+		 SPI_RX_QUAD | SPI_RX_OCTO)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
 	 */
 	bad_bits = spi->mode & ~spi->controller->mode_bits;
 	ugly_bits = bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO | SPI_RX_DUAL |
+		     SPI_RX_QUAD | SPI_RX_OCTO);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e05321..cea4e49a9e53 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTO	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTO	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
