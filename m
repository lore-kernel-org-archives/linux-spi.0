From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mark device nodes only in case of successful instantiation" to the spi tree
Date: Mon, 24 Oct 2016 19:05:20 +0100
Message-ID: <E1byjce-0001mu-N6@debutante>
References: <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mark device nodes only in case of successful instantiation

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

>From e0af98a7e025a7263ae7e50264f6f79ed29642a7 Mon Sep 17 00:00:00 2001
From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Date: Mon, 17 Oct 2016 15:59:56 +0200
Subject: [PATCH] spi: mark device nodes only in case of successful
 instantiation

Instantiated SPI device nodes are marked with OF_POPULATE. This was
introduced in bd6c164. On unloading, loaded device nodes will of course
be unmarked. The problem are nodes that fail during initialisation: If a
node fails, it won't be unloaded and hence not be unmarked.

If a SPI driver module is unloaded and reloaded, it will skip nodes that
failed before.

Skip device nodes that are already populated and mark them only in case
of success.

Note that the same issue exists for I2C.

Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE")
Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b723b593..838783c3fed0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1618,9 +1618,11 @@ static void of_register_spi_devices(struct spi_master *master)
 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
 			continue;
 		spi = of_register_spi_device(master, nc);
-		if (IS_ERR(spi))
+		if (IS_ERR(spi)) {
 			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
 				nc->full_name);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
 	}
 }
 #else
@@ -3131,6 +3133,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		if (IS_ERR(spi)) {
 			pr_err("%s: failed to create for '%s'\n",
 					__func__, rd->dn->full_name);
+			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(spi));
 		}
 		break;
-- 
2.8.1
