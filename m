From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: document odd controller reference handling" to the spi tree
Date: Tue, 31 Oct 2017 11:22:16 +0000
Message-ID: <E1e9Uca-00030d-EO@debutante>
References: <20171029115625.32385-2-johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171029115625.32385-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: document odd controller reference handling

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

>From 68b892f1fdc493d7cd4e4067596879cd097c1f62 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 30 Oct 2017 11:35:26 +0100
Subject: [PATCH] spi: document odd controller reference handling

Document the fact that a reference to the controller is dropped as part
of deregistration.

This is an odd pattern as the reference is typically taken in
__spi_alloc_controller() rather than spi_register_controller(). Most
controller drivers gets it right these days and notably the
device-managed interface relies on this behaviour.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..5673cca1d1d0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2195,7 +2195,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_controller() which will
- * automatically be unregister
+ * automatically be unregistered and freed.
  *
  * Return: zero on success, else a negative error code.
  */
@@ -2236,6 +2236,8 @@ static int __unregister(struct device *dev, void *null)
  * only ones directly touching chip registers.
  *
  * This must be called from context that can sleep.
+ *
+ * Note that this function also drops a reference to the controller.
  */
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
-- 
2.15.0.rc2
