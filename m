From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Use of_node_name_eq for node name comparisons" to the spi tree
Date: Thu,  6 Dec 2018 20:26:25 +0000 (GMT)
Message-ID: <20181206202625.1C37711252F7@debutante.sirena.org.uk>
References: <20181205195050.4759-25-robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-25-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Use of_node_name_eq for node name comparisons

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

>From 194276b073a10f04b420484bd81fa4dbb3ae0e1e Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 13:50:41 -0600
Subject: [PATCH] spi: Use of_node_name_eq for node name comparisons

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 18ebc400249c..9a7def7c3237 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1666,7 +1666,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 
 	if (spi_controller_is_slave(ctlr)) {
-		if (strcmp(nc->name, "slave")) {
+		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
 				nc);
 			return -EINVAL;
-- 
2.19.0.rc2
