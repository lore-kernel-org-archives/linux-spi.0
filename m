From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: s3c64xx: add SPDX identifier" to the spi tree
Date: Mon, 08 Jan 2018 16:23:56 +0000
Message-ID: <E1eYaDM-0002PX-W5@debutante>
References: <20171214062827.12573-1-andi.shyti@samsung.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214062827.12573-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: s3c64xx: add SPDX identifier

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

>From 78b5d705b51bc175fb67e4f5209f55e5ec581eec Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Thu, 14 Dec 2017 15:28:27 +0900
Subject: [PATCH] spi: s3c64xx: add SPDX identifier

Replace the original license statement with the SPDX identifier.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c                 | 18 ++++--------------
 include/linux/platform_data/spi-s3c64xx.h |  6 ++----
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index de7df20f8712..baa3a9fa2638 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2009 Samsung Electronics Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2009 Samsung Electronics Co., Ltd.
+//      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index da79774078a7..773daf7915a3 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -1,10 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Copyright (C) 2009 Samsung Electronics Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __SPI_S3C64XX_H
-- 
2.15.1
