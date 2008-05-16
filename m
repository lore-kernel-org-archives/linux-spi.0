From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 1/4] [SPI] [POWERPC] spi_mpc83xx: handles Freescale MPC8610
	as well
Date: Fri, 16 May 2008 20:50:52 +0400
Message-ID: <20080516165052.GA24196@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Jochen Friedrich <jochen@scram.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758685AbYEPQvR@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With this patch we'll able to select spi_mpc83xx driver on the MPC86xx
processors.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This patch is on top of Jochen's patch (
http://patchwork.ozlabs.org/linuxppc/patch?id=18261)
that fixes SPI on MPC8610.

 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66ec5d8..094c237 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
 
 config SPI_MPC83xx
 	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
-	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
+	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE || PPC_86xx) && EXPERIMENTAL
 	help
 	  This enables using the Freescale MPC83xx and QUICC Engine SPI
 	  controllers in master mode.
-- 
1.5.5.1
