From: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: Add support for dma_min_bytes
	configuration.
Date: Tue,  6 Apr 2010 13:39:48 +0300
Message-ID: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This parameters defines the minimum number of bytes when dma is used.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |    1 +
 include/linux/spi/spi.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b76f246..5bf7992 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -347,6 +347,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
+	proxy->dma_min_bytes = chip->dma_min_bytes;
 	strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
 	proxy->dev.platform_data = (void *) chip->platform_data;
 	proxy->controller_data = chip->controller_data;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 97b60b3..4e9961d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -84,6 +84,7 @@ struct spi_device {
 #define	SPI_NO_CS	0x40			/* 1 dev/bus, no chipselect */
 #define	SPI_READY	0x80			/* slave pulls low to pause */
 	u8			bits_per_word;
+	int			dma_min_bytes;
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
@@ -727,6 +728,8 @@ struct spi_board_info {
 	 */
 	u8		mode;
 
+	/* dma_min_bytes defines minimum bytes when dma is used */
+	u32		dma_min_bytes;
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
 	 * needed to behave without being bound to a driver:
-- 
1.6.2.rc1.3.g81d3f


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
