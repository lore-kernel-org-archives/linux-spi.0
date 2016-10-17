From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Subject: [PATCH v2 1/2] spi: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 15:59:56 +0200
Message-ID: <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
Cc: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
---
 drivers/spi/spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b72..838783c 100644
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
2.10.1
