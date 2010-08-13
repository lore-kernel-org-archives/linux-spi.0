From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Fri, 13 Aug 2010 19:35:18 +0530
Message-ID: <1281708323-18989-1-git-send-email-charu@ti.com>
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com,
	tony@atomide.com, grant.likely@secretlab.ca,
	dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net, rnayak@ti.com,
	p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com
To: linux-omap@vger.kernel.org
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series implements McSPI Module in HWMOD FW way
and use the runtime PM layer.

This patch series is created on "origin/pm-wip/hwmods-omap4" with
McSPI slave mode patches (url given below) on top of it.
https://patchwork.kernel.org/patch/79677/
Updated McSPI slave mode patches will be posted shortly by Govindraj.
McSPI slave mode patches were already discussed on open source mailing
list and they are almost towards the end of final rebased version.
Hence hwmod patches are created on top of McSPI slave mode patch
series to avoid major rework later on.

Benoit Cousson (1):
  OMAP4 HWMOD: Add mcspi hwmods.

Charulatha V (3):
  OMAP2420: McSPI: Add mcspi hwmod
  OMAP2430 : McSPI: Add mcspi hwmod data
  OMAP3 HWMOD: Add mcspi hwmods.

Govindraj.R (1):
  OMAP McSPI: Adapt McSPI driver to use omap hwmod

 arch/arm/mach-omap2/clock3xxx_data.c       |    4 +
 arch/arm/mach-omap2/devices.c              |  233 +++++++++---------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  138 ++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  196 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  252 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  244 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h    |   27 +++
 drivers/spi/omap2_mcspi.c                  |  273 +++++++++-------------------
 8 files changed, 1034 insertions(+), 333 deletions(-)

