From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Thu, 13 May 2010 21:47:43 +0200
Message-ID: <OF0B108CAA.3A05CD41-ONC1257722.006C9475-C1257722.006CBD6F@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
	<OFD4A1BD4A.1E890808-ONC1257722.00336F58-C1257722.0034C1F5@transmode.se>
	<20100513095545.GA11506@oksana.dev.rtsoft.ru>
	<OF224832EB.3B3694C0-ONC1257722.00574009-C1257722.00577791@transmode.se>
	<20100513161851.GA23404@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100513161851.GA23404-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org




Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/13 18:18:51:

> From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Date: 2010/05/13 18:18
> Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential memory corruption.
>
> On Thu, May 13, 2010 at 05:55:22PM +0200, Joakim Tjernlund wrote:
> > Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/13 11:55:45:
> > >
> > > On Thu, May 13, 2010 at 11:36:15AM +0200, Joakim Tjernlund wrote:
> > > [...]
> > > > The new QE mode is so broken :(
> > > > Notice how the byte order is swapped for word = 16, 32
> > >
> > > *yawn*, it's not a news... :-) Remember QE-specific rx/tx_shift
> > > stuff?
> > >
> > > I'm sure the issue is related to how the QE SPI shift register
> > > works. I.e. SDMA just feeds the shift register, and it's shift
> > > register that is causing > 8 bits words to misbehave, or the
> > > issue is in how SDMA and shift registers connected.
> > >
> > > > Not even sure what is right to begin with :)
> > > > Can't see how one should fix this either.
> > >
> > > I guess by copying the whole buffer, shifting bytes back and
> > > forth, remapping it, doing transfer, and copying data back.
> > > I think that'll work, but no idea how efficient that will be.
> > >
> > > Also, I'd not do that for CPM hardware, I tend to believe
> > > that it's not affected.
> >
> > Anton, would you be happy with the following patch?
>
> Sure.
>
> Just a few cosmetic suggestions, feel free to ignore. ;-)

would look like this, OK?

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index c312d0e..34e7d87 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -285,36 +285,12 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 	}
 }

-static
-int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int
+mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
+			   struct spi_device *spi,
+			   struct mpc8xxx_spi *mpc8xxx_spi,
+			   int bits_per_word)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	u8 bits_per_word, pm;
-	u32 hz;
-	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
-
-	mpc8xxx_spi = spi_master_get_devdata(spi->master);
-
-	if (t) {
-		bits_per_word = t->bits_per_word;
-		hz = t->speed_hz;
-	} else {
-		bits_per_word = 0;
-		hz = 0;
-	}
-
-	/* spi_transfer level calls that work per-word */
-	if (!bits_per_word)
-		bits_per_word = spi->bits_per_word;
-
-	/* Make sure its a bit width we support [4..16, 32] */
-	if ((bits_per_word < 4)
-	    || ((bits_per_word > 16) && (bits_per_word != 32)))
-		return -EINVAL;
-
-	if (!hz)
-		hz = spi->max_speed_hz;
-
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
 	if (bits_per_word <= 8) {
@@ -338,19 +314,76 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		return -EINVAL;

 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE &&
-			spi->mode & SPI_LSB_FIRST) {
+	    spi->mode & SPI_LSB_FIRST) {
 		cs->tx_shift = 0;
 		if (bits_per_word <= 8)
 			cs->rx_shift = 8;
 		else
 			cs->rx_shift = 0;
 	}
-
 	mpc8xxx_spi->rx_shift = cs->rx_shift;
 	mpc8xxx_spi->tx_shift = cs->tx_shift;
 	mpc8xxx_spi->get_rx = cs->get_rx;
 	mpc8xxx_spi->get_tx = cs->get_tx;

+	return bits_per_word;
+}
+
+static int
+mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
+			  struct spi_device *spi,
+			  int bits_per_word)
+{
+	/* Note: 32 bits word, LSB works iff
+	 *  tfcr/rfcr is set to CPMFCR_GBL */
+	if (spi->mode & SPI_LSB_FIRST &&
+	    bits_per_word != 8)
+		return -EINVAL;
+	return 8;
+}
+
+static
+int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	int bits_per_word;
+	u8 pm;
+	u32 hz;
+	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
+
+	mpc8xxx_spi = spi_master_get_devdata(spi->master);
+
+	if (t) {
+		bits_per_word = t->bits_per_word;
+		hz = t->speed_hz;
+	} else {
+		bits_per_word = 0;
+		hz = 0;
+	}
+
+	/* spi_transfer level calls that work per-word */
+	if (!bits_per_word)
+		bits_per_word = spi->bits_per_word;
+
+	/* Make sure its a bit width we support [4..16, 32] */
+	if ((bits_per_word < 4)
+	    || ((bits_per_word > 16) && (bits_per_word != 32)))
+		return -EINVAL;
+
+	if (!hz)
+		hz = spi->max_speed_hz;
+
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE))
+		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
+							   mpc8xxx_spi,
+							   bits_per_word);
+	else if (mpc8xxx_spi->flags & SPI_QE)
+		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
+							  bits_per_word);
+
+	if (bits_per_word < 0)
+		return bits_per_word;
+
 	if (bits_per_word == 32)
 		bits_per_word = 0;
 	else


------------------------------------------------------------------------------
