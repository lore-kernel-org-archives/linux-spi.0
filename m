From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 17/18] mtd: spi-nor: Add 8D-8D-8D mode
Date: Fri, 12 Oct 2018 10:48:24 +0200
Message-ID: <20181012084825.23697-18-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Add the full octo+dtr mode.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++++
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 849ba0a1c157..d961e3a7b500 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -77,6 +77,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
 	SNOR_CMD_READ_1_8D_8D,
+	SNOR_CMD_READ_8D_8D_8D,
 
 	SNOR_CMD_READ_MAX
 };
@@ -93,6 +94,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
+	SNOR_CMD_PP_8D_8D_8D,
 
 	SNOR_CMD_PP_MAX
 };
@@ -3021,6 +3023,7 @@ static int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_OPI,		SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8D_8D,	SNOR_CMD_READ_1_8D_8D },
+		{ SNOR_HWCAPS_OPI_FULL_DTR,	SNOR_CMD_READ_8D_8D_8D },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
@@ -3037,6 +3040,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
 		{ SNOR_HWCAPS_OPI,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_OPI_FULL_DTR,	SNOR_CMD_PP_8D_8D_8D },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 3735d1a0fd0d..930fc14a7c1e 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -209,6 +209,7 @@ enum spi_nor_protocol {
 	SNOR_PROTO_1_2D_2D = SNOR_PROTO_1_XD_XD(2),
 	SNOR_PROTO_1_4D_4D = SNOR_PROTO_1_XD_XD(4),
 	SNOR_PROTO_1_8D_8D = SNOR_PROTO_1_XD_XD(8),
+	SNOR_PROTO_8D_8D_8D = SNOR_PROTO_XD_XD_XD(8),
 };
 
 static inline bool spi_nor_protocol_inst_is_dtr(enum spi_nor_protocol proto)
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
