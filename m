From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 05/11] spi: spi-sh-msiof: rx_need_dummy_tx variant
Date: Mon,  2 Dec 2013 03:19:16 +0900
Message-ID: <1385921962-19843-5-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

There is a variant of MSIOF, that need dummy data transfer even when
you want only to receive.

This patch adds the option
 .rx_need_dummy_tx
to sh_msiof_spi_info.

Consult "Transmit and Receive Procedures" on HWM, if it says
 - Set SICTR.TSCKE to 1
 - Write dummy transmission data to SITFDR
to *receive*, enable this.
Ape6, Rcar-H2, and Rcar-M2 are found having this type of module.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 drivers/spi/spi-sh-msiof.c   |    4 +++-
 include/linux/spi/sh_msiof.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8683732..936d8ab 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -207,7 +207,7 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 {
 	u32 dr2 = ((bits - 1) << 24) | ((words - 1) << 16);
 
-	if (tx_buf)
+	if (tx_buf || (rx_buf && p->info->rx_need_dummy_tx))
 		sh_msiof_write(p, TMDR2, dr2);
 	else
 		sh_msiof_write(p, TMDR2, dr2 | 1);
@@ -464,6 +464,8 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	/* write tx fifo */
 	if (tx_buf)
 		tx_fifo(p, tx_buf, words, fifo_shift);
+	else if (rx_buf && p->info->rx_need_dummy_tx)
+		tx_fifo(p, rx_buf, words, fifo_shift);
 
 	/* setup clock and rx/tx signals */
 	ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index 2e8db3d..cf36781 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -5,6 +5,7 @@ struct sh_msiof_spi_info {
 	int tx_fifo_override;
 	int rx_fifo_override;
 	u16 num_chipselect;
+	u16 rx_need_dummy_tx:1;
 };
 
 #endif /* __SPI_SH_MSIOF_H__ */
-- 
1.7.9.5

