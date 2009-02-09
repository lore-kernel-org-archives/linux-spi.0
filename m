From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 1/3] SPI: add dma_alignment field to
	spi_master
Date: Mon,  9 Feb 2009 10:12:28 +0200
Message-ID: <b9186e380ae53df7b4ce65a552b39d34879f3dd6.1234167048.git.mike@compulab.co.il>
References: <cover.1234167048.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	andrey-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org, mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
In-Reply-To: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
References: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Some SPI controllers have restrictions on DMAable buffers alignemt.
Currently if the buffer supplied by protocol driver is not properly
aligned, the controller silently performs transfer in PIO mode.
Addition of dma_alignment field to spi_master allows protocol drivers to
perform proper alignment.

Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 include/linux/spi/spi.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 68bb1c5..2cc43fa 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -204,6 +204,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	SPI slaves, and are numbered from zero to num_chipselects.
  *	each slave has a chipselect signal, but it's common that not
  *	every chipselect is connected to a slave.
+ * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -239,6 +240,11 @@ struct spi_master {
 	 */
 	u16			num_chipselect;
 
+	/* some SPI controllers pose alignment requirements on DMAable
+	 * buffers; let protocol drivers know about these requirements.
+	 */
+	u16			dma_alignment;
+
 	/* setup mode and clock, etc (spi driver may call many times) */
 	int			(*setup)(struct spi_device *spi);
 
-- 
1.5.6.4


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
