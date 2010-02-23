From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH] omap2_mcspi.c: NULL pointer dereference
Date: Tue, 23 Feb 2010 14:36:03 -0500
Message-ID: <1266953763.32702.49.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Aaro Koskinen <Aaro.Koskinen@nokia.com>,
	spi-devel-general@lists.sourceforge.net,
	gumstix-users@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Check spi->controller_state before dereferencing.

Shows up NULL here when using spi_alloc_device()/spi_add_device() 
and spi_add_device() fails before spi_setup(). Calling spi_dev_put() 
on the leftover spi_device results in the error.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index ba1a872..b1f82c1 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -751,11 +751,13 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	/* Unlink controller state from context save list */
-	cs = spi->controller_state;
-	list_del(&cs->node);
+	if (spi->controller_state) {
+		/* Unlink controller state from context save list */
+		cs = spi->controller_state;
+		list_del(&cs->node);
 
-	kfree(spi->controller_state);
+		kfree(spi->controller_state);
+	}
 
 	if (mcspi_dma->dma_rx_channel != -1) {
 		omap_free_dma(mcspi_dma->dma_rx_channel);
