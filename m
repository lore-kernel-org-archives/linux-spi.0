From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] spi: tegra20-slink: use u32 for 32-bit register values
Date: Sun,  8 Dec 2013 16:35:10 +0100
Message-ID: <1386516911-26388-3-git-send-email-mina86@mina86.com>
References: <1385745164-10534-1-git-send-email-mpn@google.com>
 <1386516911-26388-1-git-send-email-mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386516911-26388-1-git-send-email-mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Previously used =E2=80=9Cunsigned long=E2=80=9D may lead to confusion s=
hould the code
be compiled for 64-bit machine.

Signed-off-by: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c | 97 +++++++++++++++++----------------=
--------
 1 file changed, 40 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-=
slink.c
index e66715b..0dcd6f9 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -196,7 +196,7 @@ struct tegra_slink_data {
 	u32					rx_status;
 	u32					status_reg;
 	bool					is_packed;
-	unsigned long				packed_size;
+	u32					packed_size;
=20
 	u32					command_reg;
 	u32					command2_reg;
@@ -220,14 +220,14 @@ struct tegra_slink_data {
 static int tegra_slink_runtime_suspend(struct device *dev);
 static int tegra_slink_runtime_resume(struct device *dev);
=20
-static inline unsigned long tegra_slink_readl(struct tegra_slink_data =
*tspi,
+static inline u32 tegra_slink_readl(struct tegra_slink_data *tspi,
 		unsigned long reg)
 {
 	return readl(tspi->base + reg);
 }
=20
 static inline void tegra_slink_writel(struct tegra_slink_data *tspi,
-		unsigned long val, unsigned long reg)
+		u32 val, unsigned long reg)
 {
 	writel(val, tspi->base + reg);
=20
@@ -238,38 +238,30 @@ static inline void tegra_slink_writel(struct tegr=
a_slink_data *tspi,
=20
 static void tegra_slink_clear_status(struct tegra_slink_data *tspi)
 {
-	unsigned long val;
-	unsigned long val_write =3D 0;
+	u32 val_write;
=20
-	val =3D tegra_slink_readl(tspi, SLINK_STATUS);
+	tegra_slink_readl(tspi, SLINK_STATUS);
=20
 	/* Write 1 to clear status register */
 	val_write =3D SLINK_RDY | SLINK_FIFO_ERROR;
 	tegra_slink_writel(tspi, val_write, SLINK_STATUS);
 }
=20
-static unsigned long tegra_slink_get_packed_size(struct tegra_slink_da=
ta *tspi,
+static u32 tegra_slink_get_packed_size(struct tegra_slink_data *tspi,
 				  struct spi_transfer *t)
 {
-	unsigned long val;
-
 	switch (tspi->bytes_per_word) {
 	case 0:
-		val =3D SLINK_PACK_SIZE_4;
-		break;
+		return SLINK_PACK_SIZE_4;
 	case 1:
-		val =3D SLINK_PACK_SIZE_8;
-		break;
+		return SLINK_PACK_SIZE_8;
 	case 2:
-		val =3D SLINK_PACK_SIZE_16;
-		break;
+		return SLINK_PACK_SIZE_16;
 	case 4:
-		val =3D SLINK_PACK_SIZE_32;
-		break;
+		return SLINK_PACK_SIZE_32;
 	default:
-		val =3D 0;
+		return 0;
 	}
-	return val;
 }
=20
 static unsigned tegra_slink_calculate_curr_xfer_param(
@@ -312,10 +304,9 @@ static unsigned tegra_slink_fill_tx_fifo_from_clie=
nt_txbuf(
 {
 	unsigned nbytes;
 	unsigned tx_empty_count;
-	unsigned long fifo_status;
+	u32 fifo_status;
 	unsigned max_n_32bit;
 	unsigned i, count;
-	unsigned long x;
 	unsigned int written_words;
 	unsigned fifo_words_left;
 	u8 *tx_buf =3D (u8 *)t->tx_buf + tspi->cur_tx_pos;
@@ -329,9 +320,9 @@ static unsigned tegra_slink_fill_tx_fifo_from_clien=
t_txbuf(
 		nbytes =3D written_words * tspi->bytes_per_word;
 		max_n_32bit =3D DIV_ROUND_UP(nbytes, 4);
 		for (count =3D 0; count < max_n_32bit; count++) {
-			x =3D 0;
+			u32 x =3D 0;
 			for (i =3D 0; (i < 4) && nbytes; i++, nbytes--)
-				x |=3D (*tx_buf++) << (i*8);
+				x |=3D (u32)(*tx_buf++) << (i * 8);
 			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
 		}
 	} else {
@@ -339,10 +330,10 @@ static unsigned tegra_slink_fill_tx_fifo_from_cli=
ent_txbuf(
 		written_words =3D max_n_32bit;
 		nbytes =3D written_words * tspi->bytes_per_word;
 		for (count =3D 0; count < max_n_32bit; count++) {
-			x =3D 0;
+			u32 x =3D 0;
 			for (i =3D 0; nbytes && (i < tspi->bytes_per_word);
 							i++, nbytes--)
-				x |=3D ((*tx_buf++) << i*8);
+				x |=3D (u32)(*tx_buf++) << (i * 8);
 			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
 		}
 	}
@@ -354,9 +345,8 @@ static unsigned int tegra_slink_read_rx_fifo_to_cli=
ent_rxbuf(
 		struct tegra_slink_data *tspi, struct spi_transfer *t)
 {
 	unsigned rx_full_count;
-	unsigned long fifo_status;
+	u32 fifo_status;
 	unsigned i, count;
-	unsigned long x;
 	unsigned int read_words =3D 0;
 	unsigned len;
 	u8 *rx_buf =3D (u8 *)t->rx_buf + tspi->cur_rx_pos;
@@ -366,7 +356,7 @@ static unsigned int tegra_slink_read_rx_fifo_to_cli=
ent_rxbuf(
 	if (tspi->is_packed) {
 		len =3D tspi->curr_dma_words * tspi->bytes_per_word;
 		for (count =3D 0; count < rx_full_count; count++) {
-			x =3D tegra_slink_readl(tspi, SLINK_RX_FIFO);
+			u32 x =3D tegra_slink_readl(tspi, SLINK_RX_FIFO);
 			for (i =3D 0; len && (i < 4); i++, len--)
 				*rx_buf++ =3D (x >> i*8) & 0xFF;
 		}
@@ -374,7 +364,7 @@ static unsigned int tegra_slink_read_rx_fifo_to_cli=
ent_rxbuf(
 		read_words +=3D tspi->curr_dma_words;
 	} else {
 		for (count =3D 0; count < rx_full_count; count++) {
-			x =3D tegra_slink_readl(tspi, SLINK_RX_FIFO);
+			u32 x =3D tegra_slink_readl(tspi, SLINK_RX_FIFO);
 			for (i =3D 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ =3D (x >> (i*8)) & 0xFF;
 		}
@@ -387,27 +377,24 @@ static unsigned int tegra_slink_read_rx_fifo_to_c=
lient_rxbuf(
 static void tegra_slink_copy_client_txbuf_to_spi_txbuf(
 		struct tegra_slink_data *tspi, struct spi_transfer *t)
 {
-	unsigned len;
-
 	/* Make the dma buffer to read by cpu */
 	dma_sync_single_for_cpu(tspi->dev, tspi->tx_dma_phys,
 				tspi->dma_buf_size, DMA_TO_DEVICE);
=20
 	if (tspi->is_packed) {
-		len =3D tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned len =3D tspi->curr_dma_words * tspi->bytes_per_word;
 		memcpy(tspi->tx_dma_buf, t->tx_buf + tspi->cur_pos, len);
 	} else {
 		unsigned int i;
 		unsigned int count;
 		u8 *tx_buf =3D (u8 *)t->tx_buf + tspi->cur_tx_pos;
 		unsigned consume =3D tspi->curr_dma_words * tspi->bytes_per_word;
-		unsigned int x;
=20
 		for (count =3D 0; count < tspi->curr_dma_words; count++) {
-			x =3D 0;
+			u32 x =3D 0;
 			for (i =3D 0; consume && (i < tspi->bytes_per_word);
 							i++, consume--)
-				x |=3D ((*tx_buf++) << i * 8);
+				x |=3D (u32)(*tx_buf++) << (i * 8);
 			tspi->tx_dma_buf[count] =3D x;
 		}
 	}
@@ -434,14 +421,10 @@ static void tegra_slink_copy_spi_rxbuf_to_client_=
rxbuf(
 		unsigned int i;
 		unsigned int count;
 		unsigned char *rx_buf =3D t->rx_buf + tspi->cur_rx_pos;
-		unsigned int x;
-		unsigned int rx_mask, bits_per_word;
+		u32 rx_mask =3D ((u32)1 << t->bits_per_word) - 1;
=20
-		bits_per_word =3D t->bits_per_word;
-		rx_mask =3D (1 << bits_per_word) - 1;
 		for (count =3D 0; count < tspi->curr_dma_words; count++) {
-			x =3D tspi->rx_dma_buf[count];
-			x &=3D rx_mask;
+			u32 x =3D tspi->rx_dma_buf[count] & rx_mask;
 			for (i =3D 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ =3D (x >> (i*8)) & 0xFF;
 		}
@@ -501,17 +484,16 @@ static int tegra_slink_start_rx_dma(struct tegra_=
slink_data *tspi, int len)
 static int tegra_slink_start_dma_based_transfer(
 		struct tegra_slink_data *tspi, struct spi_transfer *t)
 {
-	unsigned long val;
-	unsigned long test_val;
+	u32 val;
 	unsigned int len;
 	int ret =3D 0;
-	unsigned long status;
+	u32 status;
=20
 	/* Make sure that Rx and Tx fifo are empty */
 	status =3D tegra_slink_readl(tspi, SLINK_STATUS);
 	if ((status & SLINK_FIFO_EMPTY) !=3D SLINK_FIFO_EMPTY) {
-		dev_err(tspi->dev,
-			"Rx/Tx fifo are not empty status 0x%08lx\n", status);
+		dev_err(tspi->dev, "Rx/Tx fifo are not empty status 0x%08x\n",
+			(unsigned)status);
 		return -EIO;
 	}
=20
@@ -551,9 +533,9 @@ static int tegra_slink_start_dma_based_transfer(
 		}
=20
 		/* Wait for tx fifo to be fill before starting slink */
-		test_val =3D tegra_slink_readl(tspi, SLINK_STATUS);
-		while (!(test_val & SLINK_TX_FULL))
-			test_val =3D tegra_slink_readl(tspi, SLINK_STATUS);
+		status =3D tegra_slink_readl(tspi, SLINK_STATUS);
+		while (!(status & SLINK_TX_FULL))
+			status =3D tegra_slink_readl(tspi, SLINK_STATUS);
 	}
=20
 	if (tspi->cur_direction & DATA_DIR_RX) {
@@ -587,7 +569,7 @@ static int tegra_slink_start_dma_based_transfer(
 static int tegra_slink_start_cpu_based_transfer(
 		struct tegra_slink_data *tspi, struct spi_transfer *t)
 {
-	unsigned long val;
+	u32 val;
 	unsigned cur_words;
=20
 	val =3D tspi->packed_size;
@@ -714,8 +696,8 @@ static int tegra_slink_start_transfer_one(struct sp=
i_device *spi,
 	u8 bits_per_word;
 	unsigned total_fifo_words;
 	int ret;
-	unsigned long command;
-	unsigned long command2;
+	u32 command;
+	u32 command2;
=20
 	bits_per_word =3D t->bits_per_word;
 	speed =3D t->speed_hz;
@@ -762,17 +744,18 @@ static int tegra_slink_start_transfer_one(struct =
spi_device *spi,
=20
 static int tegra_slink_setup(struct spi_device *spi)
 {
-	struct tegra_slink_data *tspi =3D spi_master_get_devdata(spi->master)=
;
-	unsigned long val;
-	unsigned long flags;
-	int ret;
-	unsigned int cs_pol_bit[MAX_CHIP_SELECT] =3D {
+	static const u32 cs_pol_bit[MAX_CHIP_SELECT] =3D {
 			SLINK_CS_POLARITY,
 			SLINK_CS_POLARITY1,
 			SLINK_CS_POLARITY2,
 			SLINK_CS_POLARITY3,
 	};
=20
+	struct tegra_slink_data *tspi =3D spi_master_get_devdata(spi->master)=
;
+	u32 val;
+	unsigned long flags;
+	int ret;
+
 	dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
 		spi->bits_per_word,
 		spi->mode & SPI_CPOL ? "" : "~",
--=20
1.8.4
