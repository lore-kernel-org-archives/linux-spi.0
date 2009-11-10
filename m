From: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] mpc52xx_spi: fix clearing status
	register
Date: Tue, 10 Nov 2009 10:12:07 +0100
Message-ID: <1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1257844329-20687-1-git-send-email-l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Before reading status register to check MODF failure, we have to clear it
first since the MODF flag will be set after initializing the spi master,
if the hardware comes up with a low SS. The processor datasheet reads:
Mode Fault flag -- bit sets if SS input goes low while SPI is configured as a
master. Flag is cleared automatically by an SPI status register read (with MODF
set) followed by a SPI control register 1 write.
Hence simply rereading the register is not sufficient to clear the flag. We
redo the write also to make sure to clear the flag.

Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/mpc52xx_spi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index ef8379b..5b036f2 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -391,6 +391,7 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	struct mpc52xx_spi *ms;
 	void __iomem *regs;
 	int rc;
+	int ctrl1;
 
 	/* MMIO registers */
 	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
@@ -399,7 +400,8 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 		return -ENODEV;
 
 	/* initialize the device */
-	out_8(regs+SPI_CTRL1, SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR);
+	ctrl1 = SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR;
+	out_8(regs + SPI_CTRL1, ctrl1);
 	out_8(regs + SPI_CTRL2, 0x0);
 	out_8(regs + SPI_DATADIR, 0xe);	/* Set output pins */
 	out_8(regs + SPI_PORTDATA, 0x8);	/* Deassert /SS signal */
@@ -409,6 +411,8 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	 * on the SPI bus.  This fault will also occur if the SPI signals
 	 * are not connected to any pins (port_config setting) */
 	in_8(regs + SPI_STATUS);
+	out_8(regs + SPI_CTRL1, ctrl1);
+
 	in_8(regs + SPI_DATA);
 	if (in_8(regs + SPI_STATUS) & SPI_STATUS_MODF) {
 		dev_err(&op->dev, "mode fault; is port_config correct?\n");
-- 
1.6.5.2


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
