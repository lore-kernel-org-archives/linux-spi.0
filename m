From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: use SPDX identifier for Renesas drivers" to the spi tree
Date: Tue, 28 Aug 2018 21:59:36 +0100 (BST)
Message-ID: <20180828205936.8314F4400A4@finisterre.ee.mobilebroadband>
References: <20180821220233.9202-11-wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821220233.9202-11-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: use SPDX identifier for Renesas drivers

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

>From 9135bac325052be8a131a8a75bbcc583451ebb1f Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Wed, 22 Aug 2018 00:02:23 +0200
Subject: [PATCH] spi: use SPDX identifier for Renesas drivers

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c     | 10 +---------
 drivers/spi/spi-sh-hspi.c  | 12 ++----------
 drivers/spi/spi-sh-msiof.c |  6 +-----
 drivers/spi/spi-sh.c       | 12 ++----------
 4 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 95dc4d78618d..018dec2fac4b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH RSPI driver
  *
@@ -6,15 +7,6 @@
  *
  * Based on spi-sh.c:
  * Copyright (C) 2011 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 20e800e70442..dc0926e43665 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH HSPI bus driver
  *
@@ -7,15 +8,6 @@
  * Based on pxa2xx_spi.c:
  * Copyright (C) 2011 Renesas Solutions Corp.
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
@@ -316,6 +308,6 @@ static struct platform_driver hspi_driver = {
 module_platform_driver(hspi_driver);
 
 MODULE_DESCRIPTION("SuperH HSPI bus driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_ALIAS("platform:sh-hspi");
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 539d6d1a277a..3eb7bcd33f22 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH MSIOF SPI Master Interface
  *
  * Copyright (c) 2009 Magnus Damm
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2014-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bitmap.h>
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 50e0ea9acf8b..f1ee58208216 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH SPI bus driver
  *
@@ -5,15 +6,6 @@
  *
  * Based on pxa2xx_spi.c:
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
@@ -522,6 +514,6 @@ static struct platform_driver spi_sh_driver = {
 module_platform_driver(spi_sh_driver);
 
 MODULE_DESCRIPTION("SH SPI bus driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoshihiro Shimoda");
 MODULE_ALIAS("platform:sh_spi");
-- 
2.18.0
