From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 1/2] spi: bitbang: simplify pointer arithmetics
Date: Wed, 9 Jan 2013 15:08:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301091502020.13376@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add a pointer variable to make spi_bitbang_start() look simpler.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Grant

As requested by you in
http://thread.gmane.org/gmane.linux.kernel.spi.devel/10065/focus=10114
I've split off this minor change - adding a "master" pointer and dropped 
other unrelated changes like renaming m -> msg etc. The resultime core 
patch "with space changes filtered out" looks much smaller now.

 drivers/spi/spi-bitbang.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 8b3d8ef..328c4dc 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -427,40 +427,41 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
  */
 int spi_bitbang_start(struct spi_bitbang *bitbang)
 {
-	int	status;
+	struct spi_master *master = bitbang->master;
+	int status;
 
-	if (!bitbang->master || !bitbang->chipselect)
+	if (!master || !bitbang->chipselect)
 		return -EINVAL;
 
 	INIT_WORK(&bitbang->work, bitbang_work);
 	spin_lock_init(&bitbang->lock);
 	INIT_LIST_HEAD(&bitbang->queue);
 
-	if (!bitbang->master->mode_bits)
-		bitbang->master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
+	if (!master->mode_bits)
+		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
 
-	if (!bitbang->master->transfer)
-		bitbang->master->transfer = spi_bitbang_transfer;
+	if (!master->transfer)
+		master->transfer = spi_bitbang_transfer;
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
-		if (!bitbang->master->setup) {
+		if (!master->setup) {
 			if (!bitbang->setup_transfer)
 				bitbang->setup_transfer =
 					 spi_bitbang_setup_transfer;
-			bitbang->master->setup = spi_bitbang_setup;
-			bitbang->master->cleanup = spi_bitbang_cleanup;
+			master->setup = spi_bitbang_setup;
+			master->cleanup = spi_bitbang_cleanup;
 		}
-	} else if (!bitbang->master->setup)
+	} else if (!master->setup)
 		return -EINVAL;
-	if (bitbang->master->transfer == spi_bitbang_transfer &&
+	if (master->transfer == spi_bitbang_transfer &&
 			!bitbang->setup_transfer)
 		return -EINVAL;
 
 	/* this task is the only thing to touch the SPI bits */
 	bitbang->busy = 0;
 	bitbang->workqueue = create_singlethread_workqueue(
-			dev_name(bitbang->master->dev.parent));
+			dev_name(master->dev.parent));
 	if (bitbang->workqueue == NULL) {
 		status = -EBUSY;
 		goto err1;
@@ -469,7 +470,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
 	 */
-	status = spi_register_master(bitbang->master);
+	status = spi_register_master(master);
 	if (status < 0)
 		goto err2;
 
-- 
1.7.2.5

