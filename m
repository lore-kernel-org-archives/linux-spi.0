From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v5 2/2] mtd: m25p80: Added pm ops support
Date: Wed, 22 Feb 2017 14:19:33 -0500
Message-ID: <1487791173-22159-3-git-send-email-kdasu.kdev@gmail.com>
References: <1487791173-22159-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
 linux-mtd@lists.infradead.org, Kamal Dasu <kdasu.kdev@gmail.com>
To: linux-spi@vger.kernel.org, cyrille.pitchen@atmel.com, marex@denx.de,
 broonie@kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1487791173-22159-1-git-send-email-kdasu.kdev@gmail.com>
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

Added power management ops for resume to be able to reinitialize
spi-nor device and set it to right transfer mode in its pre-suspend
state. Some SoC implementations might power down the spi-nor flash
and loose its initial settings on suspend. A resume should restore
part settings to its original pre-suspend state.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4df3b1..3ab30b2 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -324,10 +324,21 @@ static int m25p_remove(struct spi_device *spi)
 };
 MODULE_DEVICE_TABLE(of, m25p_of_table);
 
+#ifdef CONFIG_PM_SLEEP
+static int m25p_resume(struct device *dev)
+{
+	struct m25p *flash = dev_get_drvdata(dev);
+
+	return spi_nor_init(&flash->spi_nor);
+}
+#endif
+static SIMPLE_DEV_PM_OPS(m25p_pm_ops, NULL, m25p_resume);
+
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
 		.of_match_table = m25p_of_table,
+		.pm     = &m25p_pm_ops,
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
