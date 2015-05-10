From: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/3] mtd: m25p80: Initialize the addr_width field of spi_message
Date: Sun, 10 May 2015 22:47:32 +0800
Message-ID: <1431269253-22890-2-git-send-email-B48286@freescale.com>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431269253-22890-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Add the addr_width information of spi_nor delivery to SPI controller.

For the Freescale eSPI controller, the address width is needed to do
the correct operations.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7c8b169..0ae72a0 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -85,6 +85,7 @@ static void m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	int cmd_sz = m25p_cmdsz(nor);
 
 	spi_message_init(&m);
+	m.addr_width = flash->spi_nor.addr_width;
 
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		cmd_sz = 1;
@@ -134,6 +135,7 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	dummy /= 8;
 
 	spi_message_init(&m);
+	m.addr_width = flash->spi_nor.addr_width;
 	memset(t, 0, (sizeof t));
 
 	flash->command[0] = nor->read_opcode;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
