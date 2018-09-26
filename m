From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 7/9] mtd: spi: Add SPI_NOR_DUAL_READ property for the 'n25q128a13' Micron memory
Date: Thu, 27 Sep 2018 00:07:37 +0200
Message-ID: <20180926220739.620-8-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This memory supports not only QUAD reads, but DUAL as well.

Those are needed when two identical memories are used, but one is not
using four lines for read I/O.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f028277fb1ce..442102be174e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1103,7 +1103,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
-- 
2.11.0
