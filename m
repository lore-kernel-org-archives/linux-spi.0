From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/5] spi: uniphier: Fix FIFO threshold
Date: Tue, 24 Dec 2019 09:58:23 +0900
Message-ID: <1577149107-30670-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Rx threshold means the value to inform the receiver when the number of words
in Rx FIFO is equal to or more than the value. Similarly, Tx threshold means
the value to inform the sender when the number of words in Tx FIFO is equal
to or less than the value. The controller triggers the driver to start
the transfer.

In case of Rx, the driver wants to detect that the specified number of words
N are in Rx FIFO, so the value of Rx threshold should be N. In case of Tx,
the driver wants to detect that the same number of spaces as Rx are in
Tx FIFO, so the value of Tx threshold should be (FIFO size - N).

For example, in order for the driver to receive at least 3 words from
Rx FIFO, set 3 to Rx threshold.
   +-+-+-+-+-+-+-+-+
   | | | | | |*|*|*|
   +-+-+-+-+-+-+-+-+

In order for the driver to send at least 3 words to Tx FIFO, because
it needs at least 3 spaces, set 8(FIFO size) - 3 = 5 to Tx threshold.
   +-+-+-+-+-+-+-+-+
   |*|*|*|*|*| | | |
   +-+-+-+-+-+-+-+-+

This adds new function uniphier_spi_set_fifo_threshold() to set
threshold value to the register.

And more, FIFO counts by 'words', so this renames 'fill_bytes' with
'fill_words', and fixes the calculation using bytes_per_words.

Fixes: 37ffab817098 ("spi: uniphier: introduce polling mode")
Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-uniphier.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 47cde186..ce9b301 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -290,25 +290,32 @@ static void uniphier_spi_recv(struct uniphier_spi_priv *priv)
 	}
 }
 
-static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
+static void uniphier_spi_set_fifo_threshold(struct uniphier_spi_priv *priv,
+					    unsigned int threshold)
 {
-	unsigned int fifo_threshold, fill_bytes;
 	u32 val;
 
-	fifo_threshold = DIV_ROUND_UP(priv->rx_bytes,
-				bytes_per_word(priv->bits_per_word));
-	fifo_threshold = min(fifo_threshold, SSI_FIFO_DEPTH);
-
-	fill_bytes = fifo_threshold - (priv->rx_bytes - priv->tx_bytes);
-
-	/* set fifo threshold */
 	val = readl(priv->base + SSI_FC);
 	val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
-	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, fifo_threshold);
-	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, fifo_threshold);
+	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, SSI_FIFO_DEPTH - threshold);
+	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, threshold);
 	writel(val, priv->base + SSI_FC);
+}
+
+static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
+{
+	unsigned int fifo_threshold, fill_words;
+	unsigned int bpw = bytes_per_word(priv->bits_per_word);
+
+	fifo_threshold = DIV_ROUND_UP(priv->rx_bytes, bpw);
+	fifo_threshold = min(fifo_threshold, SSI_FIFO_DEPTH);
+
+	uniphier_spi_set_fifo_threshold(priv, fifo_threshold);
+
+	fill_words = fifo_threshold -
+		DIV_ROUND_UP(priv->rx_bytes - priv->tx_bytes, bpw);
 
-	while (fill_bytes--)
+	while (fill_words--)
 		uniphier_spi_send(priv);
 }
 
-- 
2.7.4
