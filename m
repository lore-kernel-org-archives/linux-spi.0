From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: use a module softdep for dw_dmac" to the spi tree
Date: Thu,  2 May 2019 03:19:22 +0100 (BST)
Message-ID: <20190502021922.725C7441D3C@finisterre.ee.mobilebroadband>
References: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: use a module softdep for dw_dmac

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

>From 51ebf6acb00fa6f965e600f848bee5bddddd2054 Mon Sep 17 00:00:00 2001
From: Flavio Suligoi <f.suligoi@asem.it>
Date: Wed, 10 Apr 2019 14:51:36 +0200
Subject: [PATCH] spi: pxa2xx: use a module softdep for dw_dmac

With dw_dmac, sometimes the request of a DMA channel fails because
the DMA driver is not ready, so an explicit dependency request
is necessary.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7068ccfe7d2..3e6811ef37e8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1957,3 +1957,5 @@ static void __exit pxa2xx_spi_exit(void)
 	platform_driver_unregister(&driver);
 }
 module_exit(pxa2xx_spi_exit);
+
+MODULE_SOFTDEP("pre: dw_dmac");
-- 
2.20.1
