From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 01/10] spi: Check presence the of ->transfer[_xxx]() before
 registering a controller
Date: Wed, 11 Apr 2018 00:44:30 +0200
Message-ID: <20180410224439.9260-2-boris.brezillon@bootlin.com>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-1-boris.brezillon@bootlin.com>
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

Right now, no checks are done on the presence of a ->transfer[_xxx]()
method, which can lead to a NULL pointer dereference when someone
starts sending something on the bus.

Do the check at registration time and refuse to add the controller if
all ->transfer[_xxx]() pointers are NULL.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7b213faa0a2b..24369e437c6b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2063,6 +2063,19 @@ static int of_spi_register_master(struct spi_controller *ctlr)
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
@@ -2096,6 +2109,14 @@ int spi_register_controller(struct spi_controller *ctlr)
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
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
