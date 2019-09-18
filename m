From: DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH] spi: spi-gpio: fix crash when num-chipselects is 0
Date: Wed, 18 Sep 2019 23:52:00 +0800
Message-ID: <20190918155200.12614-1-dqfext@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If an spi-gpio was specified with num-chipselects = <0> in dts, kernel will crash:

Unable to handle kernel paging request at virtual address 32697073
pgd = (ptrval)
[32697073] *pgd=00000000
Internal error: Oops: 5 [# 1] SMP ARM
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.72 #0
Hardware name: Generic DT based system
PC is at validate_desc+0x28/0x80
LR is at gpiod_direction_output+0x14/0x128
...
[<c0544db4>] (validate_desc) from [<c0545228>] (gpiod_direction_output+0x14/0x128)
[<c0545228>] (gpiod_direction_output) from [<c05fa714>] (spi_gpio_setup+0x58/0x64)
[<c05fa714>] (spi_gpio_setup) from [<c05f7258>] (spi_setup+0x12c/0x148)
[<c05f7258>] (spi_setup) from [<c05f7330>] (spi_add_device+0xbc/0x12c)
[<c05f7330>] (spi_add_device) from [<c05f7f74>] (spi_register_controller+0x838/0x924)
[<c05f7f74>] (spi_register_controller) from [<c05fa494>] (spi_bitbang_start+0x108/0x120)
[<c05fa494>] (spi_bitbang_start) from [<c05faa34>] (spi_gpio_probe+0x314/0x338)
[<c05faa34>] (spi_gpio_probe) from [<c05a844c>] (platform_drv_probe+0x34/0x70)

The cause is spi_gpio_setup() did not check if the spi-gpio has chipselect pins
before setting their direction and results in derefing an invalid pointer.

The bug is spotted in kernel 4.19.72 on OpenWrt, and does not occur in 4.14.

There is a similar fix upstream 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
 drivers/spi/spi-gpio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 77838d8fd..3b7f0d077 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -242,10 +242,12 @@ static int spi_gpio_setup(struct spi_device *spi)
 	 * The CS GPIOs have already been
 	 * initialized from the descriptor lookup.
 	 */
-	cs = spi_gpio->cs_gpios[spi->chip_select];
-	if (!spi->controller_state && cs)
-		status = gpiod_direction_output(cs,
-						!(spi->mode & SPI_CS_HIGH));
+	if (spi_gpio->has_cs) {
+		cs = spi_gpio->cs_gpios[spi->chip_select];
+		if (!spi->controller_state && cs)
+			status = gpiod_direction_output(cs,
+						  !(spi->mode & SPI_CS_HIGH));
+	}
 
 	if (!status)
 		status = spi_bitbang_setup(spi);
-- 
2.23.0
