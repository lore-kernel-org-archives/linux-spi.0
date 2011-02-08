From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/4] spi/pl022: disable core voltage when idle
Date: Tue, 8 Feb 2011 13:03:32 +0100
Message-ID: <1297166612-5135-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This utilizes the new core voltage switch to power off the PL022
core voltage when it's not in use transmitting packets, if and
only if a core voltage switch is available.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/amba-pl022.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 4220aad..8fdf530 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -508,9 +508,10 @@ static void giveback(struct pl022 *pl022)
 	msg->state = NULL;
 	if (msg->complete)
 		msg->complete(msg->context);
-	/* This message is completed, so let's turn off the clocks! */
+	/* This message is completed, so let's turn off the clocks & power */
 	clk_disable(pl022->clk);
 	amba_pclk_disable(pl022->adev);
+	amba_vcore_disable(pl022->adev);
 }
 
 /**
@@ -1475,9 +1476,11 @@ static void pump_messages(struct work_struct *work)
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
 	/*
-	 * We enable the clocks here, then the clocks will be disabled when
-	 * giveback() is called in each method (poll/interrupt/DMA)
+	 * We enable the core voltage and clocks here, then the clocks
+	 * and core will be disabled when giveback() is called in each method
+	 * (poll/interrupt/DMA)
 	 */
+	amba_vcore_enable(pl022->adev);
 	amba_pclk_enable(pl022->adev);
 	clk_enable(pl022->clk);
 	restore_state(pl022);
@@ -2123,8 +2126,12 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeded\n");
-	/* Disable the silicon block pclk and clock it when needed */
+	/*
+	 * Disable the silicon block pclk and any voltage domain and just
+	 * power it up and clock it when it's needed
+	 */
 	amba_pclk_disable(adev);
+	amba_vcore_disable(adev);
 	return 0;
 
  err_spi_register:
@@ -2189,9 +2196,11 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
 		return status;
 	}
 
+	amba_vcore_enable(adev);
 	amba_pclk_enable(adev);
 	load_ssp_default_config(pl022);
 	amba_pclk_disable(adev);
+	amba_vcore_disable(adev);
 	dev_dbg(&adev->dev, "suspended\n");
 	return 0;
 }
-- 
1.7.3.2
