From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH 2/3] [V2] mpc52xx_spi: add missing mode_bits definition
Date: Fri, 13 Nov 2009 11:41:16 +0100
Message-ID: <1258108877-25435-3-git-send-email-l.fu@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
 <1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
 <1258108877-25435-2-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Luotao Fu <l.fu@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932147AbZKMKmY@vger.kernel.org>
In-Reply-To: <1258108877-25435-2-git-send-email-l.fu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

V2 changes:
* remove CS_HIGH mode

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/spi/mpc52xx_spi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index 2322250..64862cf 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -430,6 +430,8 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	master->num_chipselect = 1;
 	master->setup = mpc52xx_spi_setup;
 	master->transfer = mpc52xx_spi_transfer;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+
 	dev_set_drvdata(&op->dev, master);
 
 	ms = spi_master_get_devdata(master);
-- 
1.6.5.2
