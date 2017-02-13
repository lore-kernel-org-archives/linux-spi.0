From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: s3c64xx: fix inconsistency between binding and driver" to the spi tree
Date: Mon, 13 Feb 2017 18:54:19 +0000
Message-ID: <E1cdLlT-0001JZ-6b@debutante>
References: <20170207080748.9524-1-andi.shyti@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20170207080748.9524-1-andi.shyti@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: s3c64xx: fix inconsistency between binding and driver

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

>From 379f831a927817c130a62e3ca0082ae685557324 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Fri, 10 Feb 2017 11:20:19 +0900
Subject: [PATCH] spi: s3c64xx: fix inconsistency between binding and driver

Commit a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS
line is not connected") introduced an inconsistency between the
binding, where the disconnected CS line was marked as
'no-cs-readback', and the driver.

The driver is erroneously checking for that attribute with
property name of 'broken-cs'.

Check for 'no-cs-readback' in the driver as well.

Fixes: a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS line is not connected")
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3c09e94cf827..186342b74141 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1003,7 +1003,7 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		sci->num_cs = temp;
 	}
 
-	sci->no_cs = of_property_read_bool(dev->of_node, "broken-cs");
+	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
 
 	return sci;
 }
-- 
2.11.0
