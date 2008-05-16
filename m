From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 4/4] [POWERPC] 86xx: mpc8610_hpcd: add SD/MMC card detect
	polling
Date: Fri, 16 May 2008 20:51:00 +0400
Message-ID: <20080516165100.GD24196@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Jochen Friedrich <jochen@scram.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760323AbYEPQwT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

MPC8610HPCD seem to not use interrupts for the SD CD line, so we need
poll it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index be430bc..47078e3 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -63,9 +63,15 @@ static int mmc_get_ro(struct device *dev)
 	return in_8(pixis_sdcsr) & PX_SDCSR_SD_WP;
 }
 
+static int mmc_get_cd(struct device *dev)
+{
+	return !(in_8(pixis_sdcsr) & PX_SDCSR_SD_nCD);
+}
+
 static struct mmc_spi_platform_data mmc_pdata = {
 	.ocr_mask = MMC_VDD_33_34,
 	.get_ro = mmc_get_ro,
+	.get_cd = mmc_get_cd,
 };
 
 static struct spi_board_info spi_boardinfo = {
-- 
1.5.5.1
