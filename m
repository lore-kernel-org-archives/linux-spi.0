From: wellsk40@gmail.com
Subject: [PATCH 1/5] mfd/ab8500: Setup SPI transfer for 24 bits
Date: Fri, 10 Sep 2010 09:19:35 -0700
Message-ID: <1284135579-13578-2-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Cc: sameo@linux.intel.com, rabin.vincent@stericsson.com,
	srinidhi.kasagar@stericsson.com, linux-kernel@vger.kernel.org,
	linux@arm.linux.org.uk, u.kleine-koenig@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, tj@kernel.org,
	grant.likely@secretlab.ca, Lukasz.Baj@tieto.com,
	quentinyang05@gmail.com, Kevin Wells <wellsk40@gmail.com>
To: linus.walleij@stericsson.com,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Kevin Wells <wellsk40@gmail.com>

The data bit transfer size should be part of the driver using the
SPI interface. This was previously setup in the AMBA PL022 driver
from board specific configuration data.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/mfd/ab8500-spi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ab8500-spi.c b/drivers/mfd/ab8500-spi.c
index e1c8b62..01b6d58 100644
--- a/drivers/mfd/ab8500-spi.c
+++ b/drivers/mfd/ab8500-spi.c
@@ -83,6 +83,11 @@ static int __devinit ab8500_spi_probe(struct spi_device *spi)
 	struct ab8500 *ab8500;
 	int ret;
 
+	spi->bits_per_word = 24;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
 	ab8500 = kzalloc(sizeof *ab8500, GFP_KERNEL);
 	if (!ab8500)
 		return -ENOMEM;
-- 
1.7.2.2
