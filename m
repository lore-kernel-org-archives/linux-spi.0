From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 17/19] spi: spi-falcon: extend warning to `delay` as well
Date: Thu, 26 Sep 2019 13:51:45 +0300
Message-ID: <20190926105147.7839-18-alexandru.ardelean@analog.com>
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

The WARN_ON macro prints a warning in syslog if `delay_usecs` is non-zero.
However, with the new intermediate `delay`, the warning should also be
printed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 00f46c816a56..d3336a63f462 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -377,7 +377,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 
 		m->actual_length += t->len;
 
-		WARN_ON(t->delay_usecs || t->cs_change);
+		WARN_ON(t->delay_usecs || t->delay.value || t->cs_change);
 		spi_flags = 0;
 	}
 
-- 
2.20.1
