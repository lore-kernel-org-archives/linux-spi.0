From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] spi: tegra20-sflash: use u32 for 32-bit register values
Date: Sun,  8 Dec 2013 16:35:11 +0100
Message-ID: <1386516911-26388-4-git-send-email-mina86@mina86.com>
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
 drivers/spi/spi-tegra20-sflash.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20=
-sflash.c
index 4dc8e81..ce9589c 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -148,14 +148,14 @@ struct tegra_sflash_data {
 static int tegra_sflash_runtime_suspend(struct device *dev);
 static int tegra_sflash_runtime_resume(struct device *dev);
=20
-static inline unsigned long tegra_sflash_readl(struct tegra_sflash_dat=
a *tsd,
+static inline u32 tegra_sflash_readl(struct tegra_sflash_data *tsd,
 		unsigned long reg)
 {
 	return readl(tsd->base + reg);
 }
=20
 static inline void tegra_sflash_writel(struct tegra_sflash_data *tsd,
-		unsigned long val, unsigned long reg)
+		u32 val, unsigned long reg)
 {
 	writel(val, tsd->base + reg);
 }
@@ -185,7 +185,7 @@ static unsigned tegra_sflash_fill_tx_fifo_from_clie=
nt_txbuf(
 	struct tegra_sflash_data *tsd, struct spi_transfer *t)
 {
 	unsigned nbytes;
-	unsigned long status;
+	u32 status;
 	unsigned max_n_32bit =3D tsd->curr_xfer_words;
 	u8 *tx_buf =3D (u8 *)t->tx_buf + tsd->cur_tx_pos;
=20
@@ -196,11 +196,11 @@ static unsigned tegra_sflash_fill_tx_fifo_from_cl=
ient_txbuf(
 	status =3D tegra_sflash_readl(tsd, SPI_STATUS);
 	while (!(status & SPI_TXF_FULL)) {
 		int i;
-		unsigned int x =3D 0;
+		u32 x =3D 0;
=20
 		for (i =3D 0; nbytes && (i < tsd->bytes_per_word);
 							i++, nbytes--)
-				x |=3D ((*tx_buf++) << i*8);
+			x |=3D (u32)(*tx_buf++) << (i * 8);
 		tegra_sflash_writel(tsd, x, SPI_TX_FIFO);
 		if (!nbytes)
 			break;
@@ -214,16 +214,14 @@ static unsigned tegra_sflash_fill_tx_fifo_from_cl=
ient_txbuf(
 static int tegra_sflash_read_rx_fifo_to_client_rxbuf(
 		struct tegra_sflash_data *tsd, struct spi_transfer *t)
 {
-	unsigned long status;
+	u32 status;
 	unsigned int read_words =3D 0;
 	u8 *rx_buf =3D (u8 *)t->rx_buf + tsd->cur_rx_pos;
=20
 	status =3D tegra_sflash_readl(tsd, SPI_STATUS);
 	while (!(status & SPI_RXF_EMPTY)) {
 		int i;
-		unsigned long x;
-
-		x =3D tegra_sflash_readl(tsd, SPI_RX_FIFO);
+		u32 x =3D tegra_sflash_readl(tsd, SPI_RX_FIFO);
 		for (i =3D 0; (i < tsd->bytes_per_word); i++)
 			*rx_buf++ =3D (x >> (i*8)) & 0xFF;
 		read_words++;
@@ -236,7 +234,7 @@ static int tegra_sflash_read_rx_fifo_to_client_rxbu=
f(
 static int tegra_sflash_start_cpu_based_transfer(
 		struct tegra_sflash_data *tsd, struct spi_transfer *t)
 {
-	unsigned long val =3D 0;
+	u32 val =3D 0;
 	unsigned cur_words;
=20
 	if (tsd->cur_direction & DATA_DIR_TX)
@@ -266,7 +264,7 @@ static int tegra_sflash_start_transfer_one(struct s=
pi_device *spi,
 {
 	struct tegra_sflash_data *tsd =3D spi_master_get_devdata(spi->master)=
;
 	u32 speed;
-	unsigned long command;
+	u32 command;
=20
 	speed =3D t->speed_hz;
 	if (speed !=3D tsd->cur_speed) {
@@ -313,7 +311,7 @@ static int tegra_sflash_start_transfer_one(struct s=
pi_device *spi,
 	tegra_sflash_writel(tsd, command, SPI_COMMAND);
 	tsd->command_reg =3D command;
=20
-	return  tegra_sflash_start_cpu_based_transfer(tsd, t);
+	return tegra_sflash_start_cpu_based_transfer(tsd, t);
 }
=20
 static int tegra_sflash_setup(struct spi_device *spi)
--=20
1.8.4
