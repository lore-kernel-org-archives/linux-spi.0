From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] ARM: tegra: move all APB DMA client to dmaengine based driver
Date: Thu, 16 Aug 2012 19:43:12 +0530
Message-ID: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <lrg-l0cyMroinI0@public.gmane.org>,
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch series enable the dmaengine based Tegra APB DMA driver
and remove the support code for the legacy dma driver from different
APB DMA clients.
Patch 1 enable the dmaengine based dma drie and disable the legacy dma driver
        in config file.
Patch 2 remove the legacy dma driver.
Patch 3,4, 5 remove the support code from different APB DMA clients to support
        legacy dma driver.

Please note that this series will depends on patch
dma: tegra: enable/disable dma clock
which is not in 3.6-rc1 but will be available in next RC (rc2) of 3.6 as
part of fixes.

Laxman Dewangan (5):
  ARM: tegra: config: enable dmaengine based APB DMA driver
  ARM: tegra: dma: remove legacy APB DMA driver
  ARM: tegra: apbio: remove support of legacy DMA driver based access
  spi: tegra: remove support of legacy DMA driver based access
  ASoC: tegra: remove support of legacy DMA driver based access

 arch/arm/configs/tegra_defconfig       |    3 +
 arch/arm/mach-tegra/Kconfig            |    7 -
 arch/arm/mach-tegra/Makefile           |    1 -
 arch/arm/mach-tegra/apbio.c            |  118 +-----
 arch/arm/mach-tegra/dma.c              |  823 --------------------------------
 arch/arm/mach-tegra/include/mach/dma.h |   97 ----
 drivers/spi/Kconfig                    |    2 +-
 drivers/spi/spi-tegra.c                |   55 +--
 sound/soc/tegra/Kconfig                |    2 +-
 sound/soc/tegra/tegra_pcm.c            |  232 ---------
 sound/soc/tegra/tegra_pcm.h            |   14 -
 11 files changed, 7 insertions(+), 1347 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/dma.c
