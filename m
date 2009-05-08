From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: pxa2xx_spi: fix for SPI_CS_HIGH
Date: Fri, 08 May 2009 10:52:49 -0300
Message-ID: <1241790769.10342.35.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general <spi-devel-general@lists.sourceforge.net>,
	openezx-devel <openezx-devel@lists.openezx.org>,
	Ned Forrester <nforrester@whoi.edu>,
	linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
To: Eric Miao <eric.y.miao@gmail.com>
Return-path: <openezx-devel-bounces@lists.openezx.org>
List-Unsubscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
List-Id: linux-spi.vger.kernel.org

Commit a7bb3909b3293d503211d7f6af8ed62c1644b686 introduces chipselect
GPIO, and configures the CS polarity using SPI_CS_HIGH spi->mode flag,
but the SPI_CS_HIGH is not allowed by setup().

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 885194a..150f06b 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1186,7 +1186,7 @@ static int transfer(struct spi_device *spi, struct spi_message *msg)
 }
 
 /* the spi->mode bits understood by this driver: */
-#define MODEBITS (SPI_CPOL | SPI_CPHA)
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
 
 static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)

-- 
Daniel Ribeiro
