From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Check presence the of ->transfer[_xxx]() before
 registering a controller" to the spi tree
Date: Thu, 26 Apr 2018 13:54:13 +0100
Message-ID: <E1fBgPd-0001Bv-PR@debutante>
References: <20180410224439.9260-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-2-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Check presence the of ->transfer[_xxx]() before registering a controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bdf3a3b59a7ab1972e7d2242c9466ba7e79f0004 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Wed, 11 Apr 2018 00:44:30 +0200
Subject: [PATCH] spi: Check presence the of ->transfer[_xxx]() before
 registering a controller

Right now, no checks are done on the presence of a ->transfer[_xxx]()
method, which can lead to a NULL pointer dereference when someone
starts sending something on the bus.

Do the check at registration time and refuse to add the controller if
all ->transfer[_xxx]() pointers are NULL.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f4666365678..9ab65fb2738e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2068,6 +2068,19 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 }
 #endif
 
+static int spi_controller_check_ops(struct spi_controller *ctlr)
+{
+	/*
+	 * The controller must at least implement one of the ->transfer()
+	 * hooks.
+	 */
+	if (!ctlr->transfer && !ctlr->transfer_one &&
+	    !ctlr->transfer_one_message)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * spi_register_controller - register SPI master or slave controller
  * @ctlr: initialized master, originally from spi_alloc_master() or
@@ -2101,6 +2114,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (!dev)
 		return -ENODEV;
 
+	/*
+	 * Make sure all necessary hooks are implemented before registering
+	 * the SPI controller.
+	 */
+	status = spi_controller_check_ops(ctlr);
+	if (status)
+		return status;
+
 	if (!spi_controller_is_slave(ctlr)) {
 		status = of_spi_register_master(ctlr);
 		if (status)
-- 
2.17.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
