From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 1/2] spi: add ability to validate xfer->bits_per_word in SPI
	core
Date: Tue, 26 Mar 2013 20:37:57 -0600
Message-ID: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Allow SPI masters to define the set of bits_per_word values they support.
If they do this, then the SPI core will reject transfers that attempt to
use an unsupported bits_per_word value. This eliminates the need for each
SPI driver to implement this checking in most cases.

Signed-off-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/spi/spi.c       |    8 ++++++++
 include/linux/spi/spi.h |    8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f996c60..0cabf15 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1377,6 +1377,14 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 			xfer->bits_per_word = spi->bits_per_word;
 		if (!xfer->speed_hz)
 			xfer->speed_hz = spi->max_speed_hz;
+		if (master->bits_per_word_mask) {
+			/* Only 32 bits fit in the mask */
+			if (xfer->bits_per_word > 32)
+				return -EINVAL;
+			if (!(master->bits_per_word_mask &
+					BIT(xfer->bits_per_word - 1)))
+				return -EINVAL;
+		}
 	}
 
 	message->spi = spi;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38c2b92..733eb5e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -228,6 +228,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	every chipselect is connected to a slave.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
+ * @bits_per_word_mask: A mask indicating which values of bits_per_word are
+ *	supported by the driver. Bit n indicates that a bits_per_word n+1 is
+ *	suported. If set, the SPI core will reject any transfer with an
+ *	unsupported bits_per_word. If not set, this value is simply ignored,
+ *	and it's up to the individual driver to perform any validation.
  * @flags: other constraints relevant to this driver
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
@@ -301,6 +306,9 @@ struct spi_master {
 	/* spi_device.mode flags understood by this controller driver */
 	u16			mode_bits;
 
+	/* bitmask of supported bits_per_word for transfers */
+	u32			bits_per_word_mask;
+
 	/* other constraints relevant to this driver */
 	u16			flags;
 #define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
