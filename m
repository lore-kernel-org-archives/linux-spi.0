From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix documentation of spi_alloc_master()" to the spi tree
Date: Sun, 06 Sep 2015 01:09:12 +0100
Message-ID: <E1ZYNWC-0007Qk-Qy@debutante>
References: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
Cc: linux-spi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix documentation of spi_alloc_master()

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

>From a394d635193b641f2c86ead5ada5b115d57c51f8 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 6 Sep 2015 01:46:54 +0300
Subject: [PATCH] spi: Fix documentation of spi_alloc_master()

Actually, spi_master_put() after spi_alloc_master() must _not_ be followed
by kfree(). The memory is already freed with the call to spi_master_put()
through spi_master_class, which registers a release function. Calling both
spi_master_put() and kfree() results in often nasty (and delayed) crashes
elsewhere in the kernel, often in the networking stack.

This reverts commit eb4af0f5349235df2e4a5057a72fc8962d00308a.

Link to patch and concerns: https://lkml.org/lkml/2012/9/3/269
or
http://lkml.iu.edu/hypermail/linux/kernel/1209.0/00790.html

Alexey Klimov: This revert becomes valid after
94c69f765f1b4a658d96905ec59928e3e3e07e6a when spi-imx.c
has been fixed and there is no need to call kfree() so comment
for spi_alloc_master() should be fixed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b23a76..9ce2f156d382 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1437,8 +1437,7 @@ static struct class spi_master_class = {
  *
  * The caller is responsible for assigning the bus number and initializing
  * the master's methods before calling spi_register_master(); and (after errors
- * adding the device) calling spi_master_put() and kfree() to prevent a memory
- * leak.
+ * adding the device) calling spi_master_put() to prevent a memory leak.
  */
 struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 {
-- 
2.5.0
