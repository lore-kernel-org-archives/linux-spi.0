From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 11/19] spi: tegra20-sflash: use to new `spi_transfer_delay_exec`
Date: Thu, 26 Sep 2019 13:51:39 +0300
Message-ID: <20190926105147.7839-12-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This conversion to the spi_transfer_delay_exec() helper is not
straightforward, as it seems that when a delay is present, the controller
issues a command, and then a delay is followed.

This change adds support for the new `delay` field which is of type
`spi_delay` and keeps backwards compatibility with the old `delay_usecs`
field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra20-sflash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cd714a4f52c6..ff1933e55830 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,10 +341,11 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
-		if (xfer->cs_change && xfer->delay_usecs) {
+		if (xfer->cs_change &&
+		    (xfer->delay_usecs || xfer->delay.value)) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 		}
 	}
 	ret = 0;
-- 
2.20.1
