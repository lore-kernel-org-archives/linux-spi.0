From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Fix build error because of missing header" to the spi tree
Date: Thu, 29 Sep 2016 11:04:39 -0700
Message-ID: <E1bpfhH-0006hW-HO@finisterre>
References: <20160929064520.184224-1-mika.westerberg@linux.intel.com>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160929064520.184224-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Fix build error because of missing header

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

>From 089bd46d8bc1fe5a28351e82e4adcaa5a40121b5 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 29 Sep 2016 09:45:20 +0300
Subject: [PATCH] spi: pxa2xx: Fix build error because of missing header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kbuild test robot reports:

  drivers/spi/spi-pxa2xx.c: In function ‘setup_cs’:
  drivers/spi/spi-pxa2xx.c:1190:20: error: implicit declaration of function ‘desc_to_gpio’
  ...

Reason for this is the fact that those functions are declared in
linux/gpio/consumer.h which is not included in the driver. Fix this by
including it.

Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5e2ed7d34487..dd7b5b47291d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
