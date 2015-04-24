From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 4/4] spi: spi-ath79: Set the initial state of CS0
Date: Fri, 24 Apr 2015 16:19:24 +0200
Message-ID: <1429885164-28501-5-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
	Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The internal chip select CS0 wasn't initialized properly to work with
CS HIGH chips.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b37bedd..bf1f9b3 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -115,6 +115,7 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 
 static int ath79_spi_setup_cs(struct spi_device *spi)
 {
+	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
 	int status;
 
 	if (spi->chip_select && !gpio_is_valid(spi->cs_gpio))
@@ -132,6 +133,13 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 		status = gpio_request_one(spi->cs_gpio, flags,
 					  dev_name(&spi->dev));
+	} else {
+		if (spi->mode & SPI_CS_HIGH)
+			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+		else
+			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
 
 	return status;
-- 
2.0.0
