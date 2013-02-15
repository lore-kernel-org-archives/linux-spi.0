From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 4/4] spi: remove unused Tegra platform data header
Date: Fri, 15 Feb 2013 15:03:50 -0700
Message-ID: <1360965830-19795-4-git-send-email-swarren@wwwdotorg.org>
References: <1360965830-19795-1-git-send-email-swarren@wwwdotorg.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360965830-19795-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The platform data header is no longer used. Delete it.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/spi/spi-tegra.h |   40 ----------------------------------------
 1 file changed, 40 deletions(-)
 delete mode 100644 include/linux/spi/spi-tegra.h

diff --git a/include/linux/spi/spi-tegra.h b/include/linux/spi/spi-tegra.h
deleted file mode 100644
index 786932c..0000000
--- a/include/linux/spi/spi-tegra.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * spi-tegra.h: SPI interface for Nvidia Tegra20 SLINK controller.
- *
- * Copyright (C) 2011 NVIDIA Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- */
-
-#ifndef _LINUX_SPI_TEGRA_H
-#define _LINUX_SPI_TEGRA_H
-
-struct tegra_spi_platform_data {
-	int dma_req_sel;
-	unsigned int spi_max_frequency;
-};
-
-/*
- * Controller data from device to pass some info like
- * hw based chip select can be used or not and if yes
- * then CS hold and setup time.
- */
-struct tegra_spi_device_controller_data {
-	bool is_hw_based_cs;
-	int cs_setup_clk_count;
-	int cs_hold_clk_count;
-};
-
-#endif /* _LINUX_SPI_TEGRA_H */
-- 
1.7.10.4
