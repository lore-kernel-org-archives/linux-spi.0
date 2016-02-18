From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add cond_resched() in main message processing loop" to the spi tree
Date: Thu, 18 Feb 2016 20:12:27 +0000
Message-ID: <E1aWUw7-0003kQ-JJ@debutante>
References: <1455561281-18573-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455561281-18573-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add cond_resched() in main message processing loop

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

>From 628269704f19fcfc765499b7158effccfc79b6cf Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Mon, 15 Feb 2016 18:28:02 +0000
Subject: [PATCH] spi: Add cond_resched() in main message processing loop

When a controller has only PIO support it is very likely that we will
run into use cases where we spend a very large amount of time consuming
CPU.  Code that does this should call cond_resched() every once in a
while to give other tasks more of a chance to run so do that in the main
SPI loop, the overhead is negligable if it's not needed.

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dcc6f6e92668..0b2bbf144460 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1184,6 +1184,9 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		return;
 	}
 	mutex_unlock(&master->bus_lock_mutex);
+
+	/* Prod the scheduler in case transfer_one() was busy waiting */
+	cond_resched();
 }
 
 /**
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
