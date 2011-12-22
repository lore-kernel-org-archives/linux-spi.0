From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] spi/tegra: depend instead of select TEGRA_SYSTEM_DMA
Date: Thu, 22 Dec 2011 15:57:57 -0800
Message-ID: <1324598277-4751-1-git-send-email-olof@lixom.net>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

It's unlikely that anyone ever wants to turn off SYSTEM_DMA, but just in
case, it makes more sense to have the driver depend on it than select it.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 drivers/spi/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3d292be..326f77a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -332,8 +332,7 @@ config SPI_STMP3XXX
 
 config SPI_TEGRA
 	tristate "Nvidia Tegra SPI controller"
-	depends on ARCH_TEGRA
-	select TEGRA_SYSTEM_DMA
+	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
 	help
 	  SPI driver for NVidia Tegra SoCs
 
-- 
1.7.8.GIT
