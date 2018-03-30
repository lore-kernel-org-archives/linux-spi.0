From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 2/6] spi: sun6i: handle chip select polarity flag
Date: Fri, 30 Mar 2018 15:50:43 +0300
Message-ID: <20180330125047.13936-3-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330125047.13936-1-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The chip select polarity flag is declared as supported
but is not handled in the code.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 88ad45e..78acc1f 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -193,6 +193,12 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	else
 		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
 
+	/* Handle chip select "reverse" polarity */
+	if (spi->mode & SPI_CS_HIGH)
+		reg &= ~SUN6I_TFR_CTL_SPOL;
+	else
+		reg |= SUN6I_TFR_CTL_SPOL;
+
 	/* We want to control the chip select manually */
 	reg |= SUN6I_TFR_CTL_CS_MANUAL;
 
-- 
2.16.2
