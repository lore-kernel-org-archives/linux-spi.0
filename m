From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Subject: [PATCH] spi-pl022: Add missing return value update
Date: Mon, 13 Jun 2011 16:23:46 +0530
Message-ID: <1307962426-19230-1-git-send-email-virupax.sadashivpetimath@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
	<virupax.sadashivpetimath@stericsson.com>
To: <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Return error on out of range cpsdvsr value.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
---
 drivers/spi/spi-pl022.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2541705..b3bd8d8 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1859,6 +1859,7 @@ static int pl022_setup(struct spi_device *spi)
 	}
 	if ((clk_freq.cpsdvsr < CPSDVR_MIN)
 	    || (clk_freq.cpsdvsr > CPSDVR_MAX)) {
+		status = -EINVAL;
 		dev_err(&spi->dev,
 			"cpsdvsr is configured incorrectly\n");
 		goto err_config_params;
-- 
1.7.4.3
