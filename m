From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [RESEND PATCH 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date: Wed, 19 Sep 2018 10:20:08 +0530
Message-ID: <1537332608-19561-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 33a55bc..6042df8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1113,6 +1113,9 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
+	/* Micron */
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
-- 
1.9.1
