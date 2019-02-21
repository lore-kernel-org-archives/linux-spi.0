From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
Date: Thu, 21 Feb 2019 15:59:58 +0000
Message-ID: <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

spi-gpio is capable of dealing with active-high chip-selects.
Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
support") broke this by setting master->mode_bits, which overrides
the setting in the spi-bitbang code.  Fix this.

Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Patch against 4.20

 drivers/spi/spi-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 45973ee3ae11..2d7cfe3c7732 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -410,7 +410,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL;
+	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	/* The master needs to think there is a chipselect even if not connected */
@@ -437,7 +437,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
 	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
-	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)
-- 
2.7.4
