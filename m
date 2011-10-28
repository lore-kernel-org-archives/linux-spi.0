From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] spi-topcliff-pch: Change company name OKI SEMICONDUCTOR
	to LAPIS Semiconductor
Date: Fri, 28 Oct 2011 09:35:22 +0900
Message-ID: <1319762122-7019-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>
References: <1319762122-7019-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1319762122-7019-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On October 1 in 2011,
OKI SEMICONDUCTOR Co., Ltd. changed the company name in to LAPIS Semiconductor Co., Ltd.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 2b1e966..7086583 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1,7 +1,7 @@
 /*
  * SPI bus driver for the Topcliff PCH used by Intel SoCs
  *
- * Copyright (C) 2010 OKI SEMICONDUCTOR Co., LTD.
+ * Copyright (C) 2011 LAPIS Semiconductor Co., Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -95,7 +95,7 @@
 #define PCH_CLOCK_HZ		50000000
 #define PCH_MAX_SPBR		1023
 
-/* Definition for ML7213/ML7831 by OKI SEMICONDUCTOR */
+/* Definition for ML7213/ML7223/ML7831 by LAPIS Semiconductor */
 #define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_SPI	0x802c
 #define PCI_DEVICE_ID_ML7223_SPI	0x800F
@@ -104,9 +104,9 @@
 /*
  * Set the number of SPI instance max
  * Intel EG20T PCH :		1ch
- * OKI SEMICONDUCTOR ML7213 IOH :	2ch
- * OKI SEMICONDUCTOR ML7223 IOH :	1ch
- * OKI SEMICONDUCTOR ML7831 IOH :	1ch
+ * LAPIS Semiconductor ML7213 IOH :	2ch
+ * LAPIS Semiconductor ML7223 IOH :	1ch
+ * LAPIS Semiconductor ML7831 IOH :	1ch
 */
 #define PCH_SPI_MAX_DEV			2
 
@@ -1756,4 +1756,4 @@ MODULE_PARM_DESC(use_dma,
 		 "to use DMA for data transfers pass 1 else 0; default 1");
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Intel EG20T PCH/OKI SEMICONDUCTOR ML7xxx IOH SPI Driver");
+MODULE_DESCRIPTION("Intel EG20T PCH/LAPIS Semiconductor ML7xxx IOH SPI Driver");
-- 
1.7.4.4


------------------------------------------------------------------------------
The demand for IT networking professionals continues to grow, and the
demand for specialized networking skills is growing even more rapidly.
Take a complimentary Learning@Cisco Self-Assessment and learn 
about Cisco certifications, training, and career opportunities. 
http://p.sf.net/sfu/cisco-dev2dev
