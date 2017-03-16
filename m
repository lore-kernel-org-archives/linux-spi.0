From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: Add sx1301 to device tree compatibility list" to the spi tree
Date: Thu, 16 Mar 2017 14:11:27 +0000
Message-ID: <E1coW7j-0002kc-1u@debutante>
References: <1489662030-11567-1-git-send-email-ben.whitten@lairdtech.com>
Cc: Ben Whitten <ben.whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>,
        Steve deRosier <derosier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ben Whitten <ben.whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>,
        Steve deRosier <derosier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489662030-11567-1-git-send-email-ben.whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: Add sx1301 to device tree compatibility list

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

>From 91b4634632e0138b655a63fdb1704edbbcd6cdda Mon Sep 17 00:00:00 2001
From: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 16 Mar 2017 11:00:30 +0000
Subject: [PATCH] spi: spidev: Add sx1301 to device tree compatibility list

Add entry for the semtech sx1301 baseband processor implementing a LoRa
concentrator IP.
At this time this chip requires an spidev userspace driver.

Signed-off-by: Ben Whitten <ben.whitten-xJ1y+ldTOs21Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Steve deRosier <derosier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099baf8c..9a2a79a871ba 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -697,6 +697,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
+	{ .compatible = "semtech,sx1301" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
