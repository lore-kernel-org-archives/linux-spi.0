From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: atmel_spi clock polarity
Date: Sat, 16 Feb 2008 22:32:52 +0900 (JST)
Message-ID: <20080216.223252.25909396.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757246AbYBPNcq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I found that atmel_spi driver does not initialize clock polarity
correctly (except for at91rm9200 CS0 channel) in some case.

The atmel_spi driver uses gpio-controlled chipselect.  OTOH spi clock
signal is controlled by CSRn.CPOL bit, but this register controls
clock signal correctly only in 'real transfer' duration.  At the time
of cs_activate() call, CSRn.CPOL will be initialized correctly, but
the controller do not know which channel is to be used next, so clock
signal will stay at the inactive state of last transfer.  If clock
polarity of new transfer and last transfer was differ, new transfer
will start with wrong clock signal state.

For example, if you started SPI MODE 2 or 3 transfer after SPI MODE 0
or 1 transfer, the clock signal state at the assertion of chipselect
will be low.  Of course this will violates SPI transfer.


Here is my quick workaround for this problem.  It makes all CSRn.CPOL
match for the transfer before activating chipselect.  I'm not quite
sure my analysis is correct, and there might be better solution.
Could you give me any comments?


diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 293b7ca..85687aa 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -87,6 +87,16 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 	unsigned gpio = (unsigned) spi->controller_data;
 	unsigned active = spi->mode & SPI_CS_HIGH;
 	u32 mr;
+	int i;
+	u32 csr;
+	u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
+
+	/* Make sure clock polarity is correct */
+	for (i = 0; i < spi->master->num_chipselect; i++) {
+		csr = spi_readl(as, CSR0 + 4 * i);
+		if ((csr ^ cpol) & SPI_BIT(CPOL))
+			spi_writel(as, CSR0 + 4 * i, csr ^ SPI_BIT(CPOL));
+	}
 
 	mr = spi_readl(as, MR);
 	mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);

---
Atsushi Nemoto
