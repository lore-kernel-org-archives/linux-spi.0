From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 21/27] spi: omap2-mcspi: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:11 +0530
Message-ID: <1411575342-31048-22-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Cc: subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 68441fa..fa2aae8 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1020,8 +1020,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		return ret;
 
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
-	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
+	pm_runtime_last_busy_and_autosuspend(mcspi->dev);
 
 	return ret;
 }
@@ -1282,8 +1281,7 @@ static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
 	omap2_mcspi_set_master_mode(master);
-	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
+	pm_runtime_last_busy_and_autosuspend(mcspi->dev);
 	return 0;
 }
 
@@ -1504,8 +1502,7 @@ static int omap2_mcspi_resume(struct device *dev)
 			writel_relaxed(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 		}
 	}
-	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
+	pm_runtime_last_busy_and_autosuspend(mcspi->dev);
 	return 0;
 }
 #else
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
