From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] spi: tegra114: use u32 for 32-bit register values
Date: Sun,  8 Dec 2013 16:35:09 +0100
Message-ID: <1386516911-26388-2-git-send-email-mina86@mina86.com>
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

This commit also removes some unused fields of the tegra_spi_data
structure as well as removes duplicated #defines.

Signed-off-by: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra114.c | 98 ++++++++++++++++----------------------=
--------
 1 file changed, 34 insertions(+), 64 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aaecfb3..272ac47 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -54,11 +54,8 @@
 #define SPI_CS_SS_VAL				(1 << 20)
 #define SPI_CS_SW_HW				(1 << 21)
 /* SPI_CS_POL_INACTIVE bits are default high */
-#define SPI_CS_POL_INACTIVE			22
-#define SPI_CS_POL_INACTIVE_0			(1 << 22)
-#define SPI_CS_POL_INACTIVE_1			(1 << 23)
-#define SPI_CS_POL_INACTIVE_2			(1 << 24)
-#define SPI_CS_POL_INACTIVE_3			(1 << 25)
+						/* n from 0 to 3 */
+#define SPI_CS_POL_INACTIVE(n)			(1 << (22 + (n)))
 #define SPI_CS_POL_INACTIVE_MASK		(0xF << 22)
=20
 #define SPI_CS_SEL_0				(0 << 26)
@@ -165,9 +162,6 @@
 #define MAX_HOLD_CYCLES				16
 #define SPI_DEFAULT_SPEED			25000000
=20
-#define MAX_CHIP_SELECT				4
-#define SPI_FIFO_DEPTH				64
-
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -184,7 +178,6 @@ struct tegra_spi_data {
 	struct spi_device			*cur_spi;
 	struct spi_device			*cs_control;
 	unsigned				cur_pos;
-	unsigned				cur_len;
 	unsigned				words_per_32bit;
 	unsigned				bytes_per_word;
 	unsigned				curr_dma_words;
@@ -204,12 +197,10 @@ struct tegra_spi_data {
 	u32					rx_status;
 	u32					status_reg;
 	bool					is_packed;
-	unsigned long				packed_size;
=20
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
-	u32					spi_cs_timing;
=20
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -227,14 +218,14 @@ struct tegra_spi_data {
 static int tegra_spi_runtime_suspend(struct device *dev);
 static int tegra_spi_runtime_resume(struct device *dev);
=20
-static inline unsigned long tegra_spi_readl(struct tegra_spi_data *tsp=
i,
+static inline u32 tegra_spi_readl(struct tegra_spi_data *tspi,
 		unsigned long reg)
 {
 	return readl(tspi->base + reg);
 }
=20
 static inline void tegra_spi_writel(struct tegra_spi_data *tspi,
-		unsigned long val, unsigned long reg)
+		u32 val, unsigned long reg)
 {
 	writel(val, tspi->base + reg);
=20
@@ -245,7 +236,7 @@ static inline void tegra_spi_writel(struct tegra_sp=
i_data *tspi,
=20
 static void tegra_spi_clear_status(struct tegra_spi_data *tspi)
 {
-	unsigned long val;
+	u32 val;
=20
 	/* Write 1 to clear status register */
 	val =3D tegra_spi_readl(tspi, SPI_TRANS_STATUS);
@@ -296,10 +287,9 @@ static unsigned tegra_spi_fill_tx_fifo_from_client=
_txbuf(
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
@@ -313,9 +303,9 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_=
txbuf(
 		nbytes =3D written_words * tspi->bytes_per_word;
 		max_n_32bit =3D DIV_ROUND_UP(nbytes, 4);
 		for (count =3D 0; count < max_n_32bit; count++) {
-			x =3D 0;
+			u32 x =3D 0;
 			for (i =3D 0; (i < 4) && nbytes; i++, nbytes--)
-				x |=3D (*tx_buf++) << (i*8);
+				x |=3D (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
 	} else {
@@ -323,10 +313,10 @@ static unsigned tegra_spi_fill_tx_fifo_from_clien=
t_txbuf(
 		written_words =3D max_n_32bit;
 		nbytes =3D written_words * tspi->bytes_per_word;
 		for (count =3D 0; count < max_n_32bit; count++) {
-			x =3D 0;
+			u32 x =3D 0;
 			for (i =3D 0; nbytes && (i < tspi->bytes_per_word);
 							i++, nbytes--)
-				x |=3D ((*tx_buf++) << i*8);
+				x |=3D (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
 	}
@@ -338,9 +328,8 @@ static unsigned int tegra_spi_read_rx_fifo_to_clien=
t_rxbuf(
 		struct tegra_spi_data *tspi, struct spi_transfer *t)
 {
 	unsigned rx_full_count;
-	unsigned long fifo_status;
+	u32 fifo_status;
 	unsigned i, count;
-	unsigned long x;
 	unsigned int read_words =3D 0;
 	unsigned len;
 	u8 *rx_buf =3D (u8 *)t->rx_buf + tspi->cur_rx_pos;
@@ -350,20 +339,16 @@ static unsigned int tegra_spi_read_rx_fifo_to_cli=
ent_rxbuf(
 	if (tspi->is_packed) {
 		len =3D tspi->curr_dma_words * tspi->bytes_per_word;
 		for (count =3D 0; count < rx_full_count; count++) {
-			x =3D tegra_spi_readl(tspi, SPI_RX_FIFO);
+			u32 x =3D tegra_spi_readl(tspi, SPI_RX_FIFO);
 			for (i =3D 0; len && (i < 4); i++, len--)
 				*rx_buf++ =3D (x >> i*8) & 0xFF;
 		}
 		tspi->cur_rx_pos +=3D tspi->curr_dma_words * tspi->bytes_per_word;
 		read_words +=3D tspi->curr_dma_words;
 	} else {
-		unsigned int rx_mask;
-		unsigned int bits_per_word =3D t->bits_per_word;
-
-		rx_mask =3D (1 << bits_per_word) - 1;
+		u32 rx_mask =3D ((u32)1 << t->bits_per_word) - 1;
 		for (count =3D 0; count < rx_full_count; count++) {
-			x =3D tegra_spi_readl(tspi, SPI_RX_FIFO);
-			x &=3D rx_mask;
+			u32 x =3D tegra_spi_readl(tspi, SPI_RX_FIFO) & rx_mask;
 			for (i =3D 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ =3D (x >> (i*8)) & 0xFF;
 		}
@@ -376,27 +361,24 @@ static unsigned int tegra_spi_read_rx_fifo_to_cli=
ent_rxbuf(
 static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 		struct tegra_spi_data *tspi, struct spi_transfer *t)
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
@@ -410,27 +392,21 @@ static void tegra_spi_copy_client_txbuf_to_spi_tx=
buf(
 static void tegra_spi_copy_spi_rxbuf_to_client_rxbuf(
 		struct tegra_spi_data *tspi, struct spi_transfer *t)
 {
-	unsigned len;
-
 	/* Make the dma buffer to read by cpu */
 	dma_sync_single_for_cpu(tspi->dev, tspi->rx_dma_phys,
 		tspi->dma_buf_size, DMA_FROM_DEVICE);
=20
 	if (tspi->is_packed) {
-		len =3D tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned len =3D tspi->curr_dma_words * tspi->bytes_per_word;
 		memcpy(t->rx_buf + tspi->cur_rx_pos, tspi->rx_dma_buf, len);
 	} else {
 		unsigned int i;
 		unsigned int count;
 		unsigned char *rx_buf =3D t->rx_buf + tspi->cur_rx_pos;
-		unsigned int x;
-		unsigned int rx_mask;
-		unsigned int bits_per_word =3D t->bits_per_word;
+		u32 rx_mask =3D ((u32)1 << t->bits_per_word) - 1;
=20
-		rx_mask =3D (1 << bits_per_word) - 1;
 		for (count =3D 0; count < tspi->curr_dma_words; count++) {
-			x =3D tspi->rx_dma_buf[count];
-			x &=3D rx_mask;
+			u32 x =3D tspi->rx_dma_buf[count] & rx_mask;
 			for (i =3D 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ =3D (x >> (i*8)) & 0xFF;
 		}
@@ -490,16 +466,16 @@ static int tegra_spi_start_rx_dma(struct tegra_sp=
i_data *tspi, int len)
 static int tegra_spi_start_dma_based_transfer(
 		struct tegra_spi_data *tspi, struct spi_transfer *t)
 {
-	unsigned long val;
+	u32 val;
 	unsigned int len;
 	int ret =3D 0;
-	unsigned long status;
+	u32 status;
=20
 	/* Make sure that Rx and Tx fifo are empty */
 	status =3D tegra_spi_readl(tspi, SPI_FIFO_STATUS);
 	if ((status & SPI_FIFO_EMPTY) !=3D SPI_FIFO_EMPTY) {
-		dev_err(tspi->dev,
-			"Rx/Tx fifo are not empty status 0x%08lx\n", status);
+		dev_err(tspi->dev, "Rx/Tx fifo are not empty status 0x%08x\n",
+			(unsigned)status);
 		return -EIO;
 	}
=20
@@ -564,7 +540,7 @@ static int tegra_spi_start_dma_based_transfer(
 static int tegra_spi_start_cpu_based_transfer(
 		struct tegra_spi_data *tspi, struct spi_transfer *t)
 {
-	unsigned long val;
+	u32 val;
 	unsigned cur_words;
=20
 	if (tspi->cur_direction & DATA_DIR_TX)
@@ -677,13 +653,13 @@ static void tegra_spi_deinit_dma_param(struct teg=
ra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
=20
-static unsigned long tegra_spi_setup_transfer_one(struct spi_device *s=
pi,
+static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, bool is_first_of_msg)
 {
 	struct tegra_spi_data *tspi =3D spi_master_get_devdata(spi->master);
 	u32 speed =3D t->speed_hz;
 	u8 bits_per_word =3D t->bits_per_word;
-	unsigned long command1;
+	u32 command1;
 	int req_mode;
=20
 	if (speed !=3D tspi->cur_speed) {
@@ -738,7 +714,7 @@ static unsigned long tegra_spi_setup_transfer_one(s=
truct spi_device *spi,
 }
=20
 static int tegra_spi_start_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, unsigned long command1)
+		struct spi_transfer *t, u32 command1)
 {
 	struct tegra_spi_data *tspi =3D spi_master_get_devdata(spi->master);
 	unsigned total_fifo_words;
@@ -763,8 +739,8 @@ static int tegra_spi_start_transfer_one(struct spi_=
device *spi,
 	tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 	tspi->command1_reg =3D command1;
=20
-	dev_dbg(tspi->dev, "The def 0x%x and written 0x%lx\n",
-				tspi->def_command1_reg, command1);
+	dev_dbg(tspi->dev, "The def 0x%x and written 0x%x\n",
+		tspi->def_command1_reg, (unsigned)command1);
=20
 	if (total_fifo_words > SPI_FIFO_DEPTH)
 		ret =3D tegra_spi_start_dma_based_transfer(tspi, t);
@@ -776,15 +752,9 @@ static int tegra_spi_start_transfer_one(struct spi=
_device *spi,
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi =3D spi_master_get_devdata(spi->master);
-	unsigned long val;
+	u32 val;
 	unsigned long flags;
 	int ret;
-	unsigned int cs_pol_bit[MAX_CHIP_SELECT] =3D {
-			SPI_CS_POL_INACTIVE_0,
-			SPI_CS_POL_INACTIVE_1,
-			SPI_CS_POL_INACTIVE_2,
-			SPI_CS_POL_INACTIVE_3,
-	};
=20
 	dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
 		spi->bits_per_word,
@@ -806,9 +776,9 @@ static int tegra_spi_setup(struct spi_device *spi)
 	spin_lock_irqsave(&tspi->lock, flags);
 	val =3D tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
-		val &=3D ~cs_pol_bit[spi->chip_select];
+		val &=3D ~SPI_CS_POL_INACTIVE(spi->chip_select);
 	else
-		val |=3D cs_pol_bit[spi->chip_select];
+		val |=3D SPI_CS_POL_INACTIVE(spi->chip_select);
 	tspi->def_command1_reg =3D val;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	spin_unlock_irqrestore(&tspi->lock, flags);
@@ -842,7 +812,7 @@ static int tegra_spi_transfer_one_message(struct sp=
i_master *master,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		unsigned long cmd1;
+		u32 cmd1;
=20
 		reinit_completion(&tspi->xfer_completion);
=20
--=20
1.8.4
