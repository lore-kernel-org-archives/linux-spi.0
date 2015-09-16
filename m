From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix kernel-doc warnings in spi.h" to the spi tree
Date: Wed, 16 Sep 2015 21:02:14 +0100
Message-ID: <E1ZcIuE-00084f-Og@finisterre>
References: <2ecb1dfb30cbac1fdd4e1884de40af896bf5975b.1442346538.git.geliangtang@163.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2ecb1dfb30cbac1fdd4e1884de40af896bf5975b.1442346538.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix kernel-doc warnings in spi.h

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

>From 0243ed44ad4a25dbd2e92ad97e5e12a1a6c72d6c Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Date: Tue, 15 Sep 2015 04:59:21 -0700
Subject: [PATCH] spi: fix kernel-doc warnings in spi.h

Fix the following 'make htmldocs' warnings:

  .//include/linux/spi/spi.h:71: warning: No description found for parameter 'lock'
  .//include/linux/spi/spi.h:71: warning: Excess struct/union/enum/typedef member 'clock' description in 'spi_statistics'

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 269e8af..6b00f18 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -34,7 +34,7 @@ extern struct bus_type spi_bus_type;
 
 /**
  * struct spi_statistics - statistics for spi transfers
- * @clock:         lock protecting this structure
+ * @lock:          lock protecting this structure
  *
  * @messages:      number of spi-messages handled
  * @transfers:     number of spi_transfers handled
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
