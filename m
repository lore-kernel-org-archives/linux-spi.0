From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] spi: unnecessary double init_completion removed
Date: Tue, 23 Dec 2014 18:41:33 +0100
Message-ID: <1419356493-22539-1-git-send-email-der.herr@hofr.at>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The double call to init_completion(&mpc8xxx_spi->done); is not needed
presumably this is a editing mistake only.


Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 drivers/spi/spi-fsl-lib.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 446b737..9d3f9e0 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -102,8 +102,6 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	mpc8xxx_spi->rx_shift = 0;
 	mpc8xxx_spi->tx_shift = 0;

-	init_completion(&mpc8xxx_spi->done);
-
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->max_chipselect;

--
1.7.10.4
