From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3] spi: s3c64xx: add SPDX identifier
Date: Thu, 14 Dec 2017 15:28:27 +0900
Message-ID: <20171214062827.12573-1-andi.shyti@samsung.com>
References: <CGME20171214062903epcas2p3e6fdc84e9e36bbf7368601cd3cf5252b@epcas2p3.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Replace the original license statement with the SPDX identifier.

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Hi,

v2 to v3:
 - move the SPDX identifier on top as a separate comment as per
   documentation
 - add Krzysztof's review

v1 to v2:
 - keep the original license

Andi

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
- *	Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
+//      Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
 
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
  *	Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __SPI_S3C64XX_H
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
