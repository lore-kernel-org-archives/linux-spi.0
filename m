From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 3/6] of_spi: Initialize cs_gpios properly
Date: Thu, 27 Dec 2012 13:10:44 +0100
Message-ID: <1356610247-11491-4-git-send-email-andreas@gaisler.com>
References: <1356610247-11491-1-git-send-email-andreas@gaisler.com>
Cc: Rob Herring <rob.herring@calxeda.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1356610247-11491-1-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Using memset does not set an array of integers properly

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/spi/spi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9c2acf1..a4baa0a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1083,7 +1083,8 @@ static int of_spi_register_master(struct spi_master *master)
 	if (!master->cs_gpios)
 		return -ENOMEM;
 
-	memset(cs, -EINVAL, master->num_chipselect);
+	for (i = 0; i < master->num_chipselect; i++)
+		cs[i] = -EINVAL;
 
 	for (i = 0; i < nb; i++)
 		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
-- 
1.7.0.4
