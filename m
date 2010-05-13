From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Thu, 13 May 2010 17:55:22 +0200
Message-ID: <OF224832EB.3B3694C0-ONC1257722.00574009-C1257722.00577791@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
	<OFD4A1BD4A.1E890808-ONC1257722.00336F58-C1257722.0034C1F5@transmode.se>
	<20100513095545.GA11506@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100513095545.GA11506-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/13 11:55:45:
>
> On Thu, May 13, 2010 at 11:36:15AM +0200, Joakim Tjernlund wrote:
> [...]
> > The new QE mode is so broken :(
> > Notice how the byte order is swapped for word = 16, 32
>
> *yawn*, it's not a news... :-) Remember QE-specific rx/tx_shift
> stuff?
>
> I'm sure the issue is related to how the QE SPI shift register
> works. I.e. SDMA just feeds the shift register, and it's shift
> register that is causing > 8 bits words to misbehave, or the
> issue is in how SDMA and shift registers connected.
>
> > Not even sure what is right to begin with :)
> > Can't see how one should fix this either.
>
> I guess by copying the whole buffer, shifting bytes back and
> forth, remapping it, doing transfer, and copying data back.
> I think that'll work, but no idea how efficient that will be.
>
> Also, I'd not do that for CPM hardware, I tend to believe
> that it's not affected.

Anton, would you be happy with the following patch?
Basically it works around LE endian shift for !LSB
transfers.

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index c312d0e..c995aa5 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -315,41 +315,51 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (!hz)
 		hz = spi->max_speed_hz;

-	cs->rx_shift = 0;
-	cs->tx_shift = 0;
-	if (bits_per_word <= 8) {
-		cs->get_rx = mpc8xxx_spi_rx_buf_u8;
-		cs->get_tx = mpc8xxx_spi_tx_buf_u8;
-		if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-			cs->rx_shift = 16;
-			cs->tx_shift = 24;
-		}
-	} else if (bits_per_word <= 16) {
-		cs->get_rx = mpc8xxx_spi_rx_buf_u16;
-		cs->get_tx = mpc8xxx_spi_tx_buf_u16;
-		if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-			cs->rx_shift = 16;
-			cs->tx_shift = 16;
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+		cs->rx_shift = 0;
+		cs->tx_shift = 0;
+		if (bits_per_word <= 8) {
+			cs->get_rx = mpc8xxx_spi_rx_buf_u8;
+			cs->get_tx = mpc8xxx_spi_tx_buf_u8;
+			if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
+				cs->rx_shift = 16;
+				cs->tx_shift = 24;
+			}
+		} else if (bits_per_word <= 16) {
+			cs->get_rx = mpc8xxx_spi_rx_buf_u16;
+			cs->get_tx = mpc8xxx_spi_tx_buf_u16;
+			if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
+				cs->rx_shift = 16;
+				cs->tx_shift = 16;
+			}
+		} else if (bits_per_word <= 32) {
+			cs->get_rx = mpc8xxx_spi_rx_buf_u32;
+			cs->get_tx = mpc8xxx_spi_tx_buf_u32;
+		} else
+			return -EINVAL;
+
+		if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE &&
+		    spi->mode & SPI_LSB_FIRST) {
+			cs->tx_shift = 0;
+			if (bits_per_word <= 8)
+				cs->rx_shift = 8;
+			else
+				cs->rx_shift = 0;
 		}
-	} else if (bits_per_word <= 32) {
-		cs->get_rx = mpc8xxx_spi_rx_buf_u32;
-		cs->get_tx = mpc8xxx_spi_tx_buf_u32;
-	} else
-		return -EINVAL;

-	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE &&
-			spi->mode & SPI_LSB_FIRST) {
-		cs->tx_shift = 0;
-		if (bits_per_word <= 8)
-			cs->rx_shift = 8;
-		else
-			cs->rx_shift = 0;
-	}
+		mpc8xxx_spi->rx_shift = cs->rx_shift;
+		mpc8xxx_spi->tx_shift = cs->tx_shift;
+		mpc8xxx_spi->get_rx = cs->get_rx;
+		mpc8xxx_spi->get_tx = cs->get_tx;

-	mpc8xxx_spi->rx_shift = cs->rx_shift;
-	mpc8xxx_spi->tx_shift = cs->tx_shift;
-	mpc8xxx_spi->get_rx = cs->get_rx;
-	mpc8xxx_spi->get_tx = cs->get_tx;
+	} else if (mpc8xxx_spi->flags & SPI_QE) {
+		/* Note: 32 bits word, LSB works iff
+		 *  tfcr/rfcr is set to CPMFCR_GBL */
+		if (spi->mode & SPI_LSB_FIRST &&
+			bits_per_word != 8)
+			return -EINVAL;
+		bits_per_word = 8;
+	}

 	if (bits_per_word == 32)
 		bits_per_word = 0;


------------------------------------------------------------------------------
