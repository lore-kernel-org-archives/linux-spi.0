From: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/pl022: cleanup pl022 header documentation
Date: Thu, 14 Jun 2012 10:10:32 -0300
Message-ID: <1339679432-14647-1-git-send-email-aletes.xgr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
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

Remove the unused fields from struct ssp_config_chip that was removed
before
Add bus_id documentation to pl022_ssp_controller

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
---
 include/linux/amba/pl022.h |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 76dd1b1..fe1d7b2 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -231,6 +231,7 @@ enum ssp_chip_select {
 struct dma_chan;
 /**
  * struct pl022_ssp_master - device.platform_data for SPI controller devices.
+ * @bus_id: identifier for this bus
  * @num_chipselect: chipselects are used to distinguish individual
  *     SPI slaves, and are numbered from zero to num_chipselects - 1.
  *     each slave has a chipselect signal, but it's common that not
@@ -259,19 +260,13 @@ struct pl022_ssp_controller {
  * struct ssp_config_chip - spi_board_info.controller_data for SPI
  * slave devices, copied to spi_device.controller_data.
  *
- * @lbm: used for test purpose to internally connect RX and TX
  * @iface: Interface type(Motorola, TI, Microwire, Universal)
  * @hierarchy: sets whether interface is master or slave
  * @slave_tx_disable: SSPTXD is disconnected (in slave mode only)
  * @clk_freq: Tune freq parameters of SSP(when in master mode)
- * @endian_rx: Endianess of Data in Rx FIFO
- * @endian_tx: Endianess of Data in Tx FIFO
- * @data_size: Width of data element(4 to 32 bits)
  * @com_mode: communication mode: polling, Interrupt or DMA
  * @rx_lev_trig: Rx FIFO watermark level (for IT & DMA mode)
  * @tx_lev_trig: Tx FIFO watermark level (for IT & DMA mode)
- * @clk_phase: Motorola SPI interface Clock phase
- * @clk_pol: Motorola SPI interface Clock polarity
  * @ctrl_len: Microwire interface: Control length
  * @wait_state: Microwire interface: Wait state
  * @duplex: Microwire interface: Full/Half duplex
@@ -279,8 +274,6 @@ struct pl022_ssp_controller {
  * before sampling the incoming line
  * @cs_control: function pointer to board-specific function to
  * assert/deassert I/O port to control HW generation of devices chip-select.
- * @dma_xfer_type: Type of DMA xfer (Mem-to-periph or Periph-to-Periph)
- * @dma_config: DMA configuration for SSP controller and peripheral
  */
 struct pl022_config_chip {
 	enum ssp_interface iface;
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
