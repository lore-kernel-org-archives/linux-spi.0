From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: Fix compilation warning." to the spi tree
Date: Tue, 06 Jun 2017 20:07:51 +0100
Message-ID: <E1dIJpX-0007jT-PL@debutante>
References: <97178a72ee129abbf918562cd22a508bc1cf0e1a.1496670502.git.arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <97178a72ee129abbf918562cd22a508bc1cf0e1a.1496670502.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: Fix compilation warning.

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

>From 2b747a5f04fbb26ad09241506704ddce462e581b Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 5 Jun 2017 19:20:40 +0530
Subject: [PATCH] spi: davinci: Fix compilation warning.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_OF is disable, it'll through compilation warning.

drivers/spi/spi-davinci.c: In function ‘spi_davinci_get_pdata’:
drivers/spi/spi-davinci.c:880:2: warning: return makes pointer from integer without a cast [enabled by default]
  return -ENODEV;

drivers/spi/spi-davinci.c: In function ‘davinci_spi_probe’:
drivers/spi/spi-davinci.c:919:7: warning: assignment makes integer from pointer without a cast [enabled by default]
   ret = spi_davinci_get_pdata(pdev, dspi);

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Changes in v2:
             Add fix for both the warning.
Changes in v1:
             It has fix for first warning.
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 595acdcfc7d0..0b4493e7fe9e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -873,9 +873,8 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	return 0;
 }
 #else
-static struct davinci_spi_platform_data
-	*spi_davinci_get_pdata(struct platform_device *pdev,
-		struct davinci_spi *dspi)
+static int spi_davinci_get_pdata(struct platform_device *pdev,
+			struct davinci_spi *dspi)
 {
 	return -ENODEV;
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
