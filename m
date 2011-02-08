From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 4/4] spi/pl022: minor kerneldoc updates
Date: Tue, 8 Feb 2011 13:03:55 +0100
Message-ID: <1297166635-5205-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/amba-pl022.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 2b591f0..4cd05cc 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -329,15 +329,16 @@ struct vendor_data {
 /**
  * struct pl022 - This is the private SSP driver data structure
  * @adev: AMBA device model hookup
- * @vendor: Vendor data for the IP block
- * @phybase: The physical memory where the SSP device resides
- * @virtbase: The virtual memory where the SSP is mapped
+ * @vendor: vendor data for the IP block
+ * @phybase: the physical memory where the SSP device resides
+ * @virtbase: the virtual memory where the SSP is mapped
+ * @clk: outgoing clock "SPICLK" for the SPI bus
  * @master: SPI framework hookup
  * @master_info: controller-specific data from machine setup
- * @regs: SSP controller register's virtual address
- * @pump_messages: Work struct for scheduling work to the workqueue
- * @lock: spinlock to syncronise access to driver data
  * @workqueue: a workqueue on which any spi_message request is queued
+ * @pump_messages: work struct for scheduling work to the workqueue
+ * @queue_lock: spinlock to syncronise access to message queue
+ * @queue: message queue
  * @busy: workqueue is busy
  * @running: workqueue is running
  * @pump_transfers: Tasklet used in Interrupt Transfer mode
@@ -348,8 +349,14 @@ struct vendor_data {
  * @tx_end: end position in TX buffer to be read
  * @rx: current position in RX buffer to be written
  * @rx_end: end position in RX buffer to be written
- * @readingtype: the type of read currently going on
- * @writingtype: the type or write currently going on
+ * @read: the type of read currently going on
+ * @write: the type of write currently going on
+ * @exp_fifo_level: expected FIFO level
+ * @dma_rx_channel: optional channel for RX DMA
+ * @dma_tx_channel: optional channel for TX DMA
+ * @sgt_rx: scattertable for the RX transfer
+ * @sgt_tx: scattertable for the TX transfer
+ * @dummypage: a dummy page used for driving data on the bus with DMA
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -397,8 +404,8 @@ struct pl022 {
  * @cpsr: Value of Clock prescale register
  * @n_bytes: how many bytes(power of 2) reqd for a given data width of client
  * @enable_dma: Whether to enable DMA or not
- * @write: function ptr to be used to write when doing xfer for this chip
  * @read: function ptr to be used to read when doing xfer for this chip
+ * @write: function ptr to be used to write when doing xfer for this chip
  * @cs_control: chip select callback provided by chip
  * @xfer_type: polling/interrupt/DMA
  *
-- 
1.7.3.2


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
