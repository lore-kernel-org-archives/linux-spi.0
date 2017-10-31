From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix use-after-free at controller deregistration" to the spi tree
Date: Tue, 31 Oct 2017 11:22:21 +0000
Message-ID: <E1e9Ucf-00031c-Fh@debutante>
References: <20171029115625.32385-1-johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, stable <stable@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Suniel Mahesh <sunil.m@techveda.org>,
        Karthik Tummala <karthik@techveda.org>,
        linux-spi@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171029115625.32385-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix use-after-free at controller deregistration

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 67f7b2781fafcc0f52464880154b320fea1ae982 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 30 Oct 2017 11:35:25 +0100
Subject: [PATCH] spi: fix use-after-free at controller deregistration

The controller is typically freed as part of device_unregister() so
store the bus id before deregistration to avoid use-after-free when the
id is later released.

Fixes: 9b61e302210e ("spi: Pick spi bus number from Linux idr or spi alias")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..759c9725495a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2240,11 +2240,12 @@ static int __unregister(struct device *dev, void *null)
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
 	struct spi_controller *found;
+	int id = ctlr->bus_num;
 	int dummy;
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
-	found = idr_find(&spi_master_idr, ctlr->bus_num);
+	found = idr_find(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 	if (found != ctlr) {
 		dev_dbg(&ctlr->dev,
@@ -2264,7 +2265,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, ctlr->bus_num);
+	idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
-- 
2.15.0.rc2
