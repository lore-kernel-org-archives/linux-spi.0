From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.31-rc7 2/3] spi: McSPI saves CHCONFx
	too
Date: Thu, 27 Aug 2009 20:21:11 -0700
Message-ID: <200908272021.12070.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Previous restore was lazy and only restored CHxCONF when it was needed by a
specific chip select. This could cause occasional errors on an SPI bus where
multiple chip selects are in use.

Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi_cs {
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
+	struct list_head	node;
 	/* Context save and restore shadow register */
 	u32			chconf0;
 };
@@ -145,6 +146,7 @@ struct omap2_mcspi_regs {
 	u32 sysconfig;
 	u32 modulctrl;
 	u32 wakeupenable;
+	struct list_head cs;
 };
 
 static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
@@ -255,6 +257,7 @@ static void omap2_mcspi_set_master_mode(
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
 	struct spi_master *spi_cntrl;
+	struct omap2_mcspi_cs *cs;
 	spi_cntrl = mcspi->master;
 
 	/* McSPI: context restore */
@@ -266,6 +269,10 @@ static void omap2_mcspi_restore_ctx(stru
 
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+
+	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
+			node)
+		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 }
 static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
@@ -714,6 +721,9 @@ static int omap2_mcspi_setup(struct spi_
 		cs->phys = mcspi->phys + spi->chip_select * 0x14;
 		cs->chconf0 = 0;
 		spi->controller_state = cs;
+		/* Link this to context save list */
+		list_add_tail(&cs->node,
+			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
 	}
 
 	if (mcspi_dma->dma_rx_channel == -1
@@ -736,10 +746,15 @@ static void omap2_mcspi_cleanup(struct s
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
+	struct omap2_mcspi_cs	*cs;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
+	/* Unlink controller state from context save list */
+	cs = spi->controller_state;
+	list_del(&cs->node);
+
 	kfree(spi->controller_state);
 
 	if (mcspi_dma->dma_rx_channel != -1) {
@@ -1104,6 +1119,7 @@ static int __init omap2_mcspi_probe(stru
 
 	spin_lock_init(&mcspi->lock);
 	INIT_LIST_HEAD(&mcspi->msg_queue);
+	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
 
 	mcspi->ick = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(mcspi->ick)) {


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
