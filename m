From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers" to the spi tree
Date: Wed, 15 Aug 2018 15:45:56 +0100 (BST)
Message-ID: <20180815144556.18FDB1124437@debutante.sirena.org.uk>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 1a4327fbf4554d5b78d75b19a13d40d6de220159 Mon Sep 17 00:00:00 2001
From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Date: Mon, 13 Aug 2018 19:48:10 +0300
Subject: [PATCH] spi: fix IDR collision on systems with both fixed and dynamic
 SPI bus numbers

On systems where some controllers get a dynamic ID assigned and some have
a fixed number (e.g. from ACPI tables), the current implementation might
run into an IDR collision: in case of a fixed bus number is gotten by a
driver (but not marked busy in IDR tree) and a driver with dynamic bus
number gets the same ID and predictably fails.

Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
at the moment of the controller registration.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..a00d006d4c3a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2170,6 +2170,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
+	} else {
+		/* devices with a fixed bus num must check-in with the num */
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+			ctlr->bus_num + 1, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id == -ENOSPC ? -EBUSY : id;
+		ctlr->bus_num = id;
 	}
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
-- 
2.18.0
