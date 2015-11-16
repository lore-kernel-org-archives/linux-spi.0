From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm63xx: use correct format string for printing a resource" to the spi tree
Date: Mon, 16 Nov 2015 18:45:28 +0000
Message-ID: <E1ZyOmO-0007S8-B2@debutante>
References: <8442314.JjGyK1Sa3M@wuerfel>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8442314.JjGyK1Sa3M@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm63xx: use correct format string for printing a resource

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

>From 0ba2cf70d23437161199e6b627f6948b47be9db4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Thu, 12 Nov 2015 17:44:34 +0100
Subject: [PATCH] spi: bcm63xx: use correct format string for printing a
 resource

With a 64-bit resource_size_t, we get a build warning on bcm63xx_spi_probe:

drivers/spi/spi-bcm63xx.c:565:16: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

As we are printing a resource, we can just use the %pr format
specifier that pretty-prints the address and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 06858e04ec59..bf9a610e5b89 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -562,8 +562,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d)\n",
-		 r->start, irq, bs->fifo_size);
+	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
+		 r, irq, bs->fifo_size);
 
 	return 0;
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
