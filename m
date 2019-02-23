From: kernel@martin.sperl.org
Subject: [PATCH 3/5] spi: core: allow defining time that cs is deasserted as a
 multiple of SCK
Date: Sat, 23 Feb 2019 08:49:50 +0000
Message-ID: <20190223084952.14758-4-kernel@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223084952.14758-1-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Support setting a delay between cs assert and deassert as
a multiple of spi clock length.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c       | 8 ++++++++
 include/linux/spi/spi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5a4616894d57..d5259bdd4b88 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1092,6 +1092,7 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 {
 	u32 delay = xfer->cs_change_delay;
 	u32 unit = xfer->cs_change_delay_unit;
+	u32 hz;

 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay && unit != SPI_DELAY_UNIT_USECS)
@@ -1107,6 +1108,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
 	default:
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f503a712423d..0b1d5e2b8b8b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -799,6 +799,7 @@ struct spi_transfer {
 	u8		cs_change_delay_unit;
 #define SPI_DELAY_UNIT_USECS	0
 #define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;

--
2.11.0
