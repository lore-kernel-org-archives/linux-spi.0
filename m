From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH 2/3] mpc52xx_spi: add missing mode_bits definition
Date: Tue, 10 Nov 2009 10:12:08 +0100
Message-ID: <1257844329-20687-3-git-send-email-l.fu@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, l.fu@pengutronix.de, linuxppc-dev@ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
 drivers/spi/mpc52xx_spi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index 5b036f2..79ba678 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -430,6 +430,8 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	master->num_chipselect = 1;
 	master->setup = mpc52xx_spi_setup;
 	master->transfer = mpc52xx_spi_transfer;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+
 	dev_set_drvdata(&op->dev, master);
 
 	ms = spi_master_get_devdata(master);
-- 
1.6.5.2
