From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 14:33:28 +0200
Message-ID: <20181003123328.GA29471@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Apparently, this code does not actually fall through to the next case
because the machine restarts before it has a chance. However, for the
sake of maintenance and readability, we better add the missing break
statement.

Addresses-Coverity-ID: 1437892 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-slave-system-control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
index c0257e9..169f3d5 100644
--- a/drivers/spi/spi-slave-system-control.c
+++ b/drivers/spi/spi-slave-system-control.c
@@ -60,6 +60,7 @@ static void spi_slave_system_control_complete(void *arg)
 	case CMD_REBOOT:
 		dev_info(&priv->spi->dev, "Rebooting system...\n");
 		kernel_restart(NULL);
+		break;
 
 	case CMD_POWEROFF:
 		dev_info(&priv->spi->dev, "Powering off system...\n");
-- 
2.7.4
