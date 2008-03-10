From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: spidev question
Date: Mon, 10 Mar 2008 21:05:41 +0100
Message-ID: <1205179541.29669.130.camel@gentoo-jocke.transmode.se>
References: <1205178415.29669.119.camel@gentoo-jocke.transmode.se>
	<200803101300.44267.david-b@pacbell.net>
Reply-To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200803101300.44267.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Mon, 2008-03-10 at 12:00 -0800, David Brownell wrote:
> On Monday 10 March 2008, Joakim Tjernlund wrote:
> > Trying to make sense of spidev. We have 5 spi devices on the
> > same spi bus and I am trying to use different word sizes for some of the
> > devices.
> > 
> > I open 5 diffrent /dev/spidev0.x where x=0..4 and for
> > each fd returned I do:
> >  ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
> 
> That is, something like:
> 
> 	fd[x] = open("/dev/spidev0.x", O_RDWR);
> 	ioctl(fd[x], SPI_IOC_WR_BITS_PER_WORD, &bits[x]);
> 
> Each device should have its own file descriptor.
> 
> 
> > bits is either 8 or 16.
> > However, it seems that the last ioctl "wins", all spi transactions
> > appears to used the last setting, thats is, the ioctl appears to be
> > for the controller, not the spi slave I am talking to.
> 
> Sounds like a bug in the controller driver, if you're properly
> getting a file descriptor per device...
> 
> 
> > This does not make sense to me, I figured I could set bits_per_word(and
> > max speed too) for each slave. Can anyone tell me how spidev is supposed
> > to work? It is quite possible that I got a problem in spi HW driver that
> > fools me somehow.
> 
> Absolutely.  Each device has a variety of individual characteristics,
> like speed, bits per word, mode, and so on.  That's why they're stored
> in the spi_device rather than the controller
> 
> - Dave

I am using mpc83xx.c with the following patch appiled, can you see where
I go wrong? I plan to send it to the list as sonn as I get this problem
sorted out.
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 32cda77..11cc540 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -49,6 +49,7 @@ struct mpc83xx_spi_reg {
 #define	SPMODE_LEN(x)		((x) << 20)
 #define	SPMODE_PM(x)		((x) << 16)
 #define	SPMODE_OP		(1 << 14)
+#define	SPMODE_CG(x)		((x) << 7)
 
 /*
  * Default for SPI Mode:
@@ -89,7 +90,7 @@ struct mpc83xx_spi {
 	u32 spibrg;		/* SPIBRG input clock */
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
-
+	u32 hw_mode;		/* Holds HW mode register settings */
 	bool qe_mode;
 
 	void (*activate_cs) (u8 cs, u8 polarity);
@@ -147,50 +148,13 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 
 	if (value == BITBANG_CS_ACTIVE) {
 		u32 regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
-		u32 len = spi->bits_per_word;
-		u8 pm;
 
-		if (len == 32)
-			len = 0;
-		else
-			len = len - 1;
-
-		/* mask out bits we are going to set */
-		regval &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH
-				| SPMODE_LEN(0xF) | SPMODE_DIV16
-				| SPMODE_PM(0xF) | SPMODE_REV | SPMODE_LOOP);
-
-		if (spi->mode & SPI_CPHA)
-			regval |= SPMODE_CP_BEGIN_EDGECLK;
-		if (spi->mode & SPI_CPOL)
-			regval |= SPMODE_CI_INACTIVEHIGH;
-		if (!(spi->mode & SPI_LSB_FIRST))
-			regval |= SPMODE_REV;
-		if (spi->mode & SPI_LOOP)
-			regval |= SPMODE_LOOP;
-
-		regval |= SPMODE_LEN(len);
-
-		if ((mpc83xx_spi->spibrg / spi->max_speed_hz) >= 64) {
-			pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64) - 1;
-			if (pm > 0x0f) {
-				dev_err(&spi->dev, "Requested speed is too "
-					"low: %d Hz. Will use %d Hz instead.\n",
-					spi->max_speed_hz,
-					mpc83xx_spi->spibrg / 1024);
-				pm = 0x0f;
-			}
-			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
-		} else {
-			pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
-			if (pm)
-				pm--;
-			regval |= SPMODE_PM(pm);
+		if (mpc83xx_spi->hw_mode != regval) {
+			regval = mpc83xx_spi->hw_mode;
+			/* Turn off SPI unit prior changing mode */
+			mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval & ~SPMODE_ENABLE);
+			mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 		}
-
-		/* Turn off SPI unit prior changing mode */
-		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
-		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 		if (mpc83xx_spi->activate_cs)
 			mpc83xx_spi->activate_cs(spi->chip_select, pol);
 	}
@@ -201,7 +165,7 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc83xx_spi *mpc83xx_spi;
 	u32 regval;
-	u8 bits_per_word;
+	u8 bits_per_word, pm;
 	u32 hz;
 
 	mpc83xx_spi = spi_master_get_devdata(spi->master);
@@ -265,18 +229,34 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	else
 		bits_per_word = bits_per_word - 1;
 
-	regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
-
 	/* mask out bits we are going to set */
-	regval &= ~(SPMODE_LEN(0xF) | SPMODE_REV);
-	regval |= SPMODE_LEN(bits_per_word);
-	if (!(spi->mode & SPI_LSB_FIRST))
-		regval |= SPMODE_REV;
-
-	/* Turn off SPI unit prior changing mode */
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
-
+	mpc83xx_spi->hw_mode &= ~(SPMODE_LEN(0xF) | SPMODE_DIV16
+				  | SPMODE_PM(0xF)); 
+
+	mpc83xx_spi->hw_mode |= SPMODE_LEN(bits_per_word);
+
+	if ((mpc83xx_spi->spibrg / hz) >= 64) {
+		pm = mpc83xx_spi->spibrg / (hz * 64) - 1;
+		if (pm > 0x0f) {
+			dev_err(&spi->dev, "Requested speed is too "
+				"low: %d Hz. Will use %d Hz instead.\n",
+				hz, mpc83xx_spi->spibrg / 1024);
+			pm = 0x0f;
+		}
+		mpc83xx_spi->hw_mode |= SPMODE_PM(pm) | SPMODE_DIV16;
+	} else {
+		pm = mpc83xx_spi->spibrg / (hz * 4);
+		if (pm)
+			pm--;
+		mpc83xx_spi->hw_mode |= SPMODE_PM(pm);
+	}
+	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
+	if (mpc83xx_spi->hw_mode != regval) {
+		regval = mpc83xx_spi->hw_mode;
+		/* Turn off SPI unit prior changing mode */
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval & ~SPMODE_ENABLE);
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
+	}
 	return 0;
 }
 
@@ -305,6 +285,19 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
+	/* mask out bits we are going to set */
+	mpc83xx_spi->hw_mode &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH
+				  | SPMODE_REV | SPMODE_LOOP);
+
+	if (spi->mode & SPI_CPHA)
+		mpc83xx_spi->hw_mode |= SPMODE_CP_BEGIN_EDGECLK;
+	if (spi->mode & SPI_CPOL)
+		mpc83xx_spi->hw_mode |= SPMODE_CI_INACTIVEHIGH;
+	if (!(spi->mode & SPI_LSB_FIRST))
+		mpc83xx_spi->hw_mode |= SPMODE_REV;
+	if (spi->mode & SPI_LOOP)
+		mpc83xx_spi->hw_mode |= SPMODE_LOOP;
+
 	retval = mpc83xx_spi_setup_transfer(spi, NULL);
 	if (retval < 0)
 		return retval;
@@ -332,13 +325,21 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
 static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc83xx_spi *mpc83xx_spi;
-	u32 word;
+	u32 word, len, bits_per_word;
 
 	mpc83xx_spi = spi_master_get_devdata(spi->master);
 
 	mpc83xx_spi->tx = t->tx_buf;
 	mpc83xx_spi->rx = t->rx_buf;
-	mpc83xx_spi->count = t->len;
+	bits_per_word = spi->bits_per_word;
+	if (t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+	len = t->len;
+	if (bits_per_word > 8)
+		len /= 2;
+	if (bits_per_word > 16)
+		len /= 2;
+	mpc83xx_spi->count = len;
 	INIT_COMPLETION(mpc83xx_spi->done);
 
 	/* enable rx ints */
@@ -353,7 +354,7 @@ static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* disable rx ints */
 	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
 
-	return t->len - mpc83xx_spi->count;
+	return len - mpc83xx_spi->count;
 }
 
 irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data)
@@ -487,6 +488,7 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 		regval |= SPMODE_OP;
 
 	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
+	mpc83xx_spi->hw_mode = regval;
 
 	ret = spi_bitbang_start(&mpc83xx_spi->bitbang);
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
