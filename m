From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device driver
Date: Tue, 05 Jan 2016 01:19:32 +0100
Message-ID: <1994637.DU4i3KELDi@chaos-desktop>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org> <1866751.zFWfh0Kuks@chaos-desktop> <36C84129-0322-41C5-B01A-AF6F002E001E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36C84129-0322-41C5-B01A-AF6F002E001E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am Montag, 4. Januar 2016, 15:23:52 schrieb Martin Sperl:
> > On 04.01.2016, at 14:51, Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org> wr=
ote:
> >=20
> > According to the spi documentation [1]: "CPHA indicates the clock p=
hase
> > used to sample data; CPHA=3D0 says sample on the leading edge, CPHA=
=3D1 means
> > the trailing edge."
> > Which is from my understanding different from what the BMC2835 ARM
> > Peripherals [2] says for BCM2835_AUX_SPI_CNTL0_CPHA_IN:
> > "If 1 data is clocked in on the rising edge of the SPI clock
> > If 0 data is clocked in on the falling edge of the SPI clock"
> >=20
> > I would expect the bits to be set dependant on the clock polarity (=
CPOL).
>=20
> I am only having =E2=80=9Ctypical=E2=80=9D devices with do Mode 0,0 o=
r 1,1 for which it
> works.

Are you only writing to your devices or reading as well? From what I th=
ink how=20
this works, reading should not have worked with Mode 0,0

> > The other issue I have, is that the chip select is set before the c=
lock
> > polarity and the polarity is reset and set again between each trans=
fers of
> > a message. If CPOL is set to 1 this leads to additional rising and
> > falling edges of the clock while chip select is active, where no da=
ta is
> > sampled.
> This is something I have seen before with the main spi HW.
> We may need to port the same thing there.
>=20
> The corresponding patch for spi-bcm2835.c is this:
> acace73df2c1913a526c1b41e4741a4a6704c863

Thanks for the hint. I tried to implement a similar solution. Could you=
 test=20
if this works for you?
It also contains a fix for the IRQ defines, a hopefully correct solutio=
n to=20
the CPHA issue and reduces the number of unnecessary interrupts.

---
 drivers/spi/spi-bcm2835aux.c | 70=20
++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.=
c
index 7de6f84..d8be445 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -73,8 +73,8 @@
=20
 /* Bitfields in CNTL1 */
 #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
-#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
-#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040
+#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
+#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
 #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
 #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001
=20
@@ -212,9 +212,15 @@ static irqreturn_t bcm2835aux_spi_interrupt(int ir=
q, void=20
*dev_id)
 		ret =3D IRQ_HANDLED;
 	}
=20
-	/* and if rx_len is 0 then wake up completion and disable spi */
+	if (!bs->tx_len) {
+		/* disable tx fifo empty interrupt */
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
+			BCM2835_AUX_SPI_CNTL1_IDLE);
+	}
+
+	/* and if rx_len is 0 then disable interrupts and wake up completion =
*/
 	if (!bs->rx_len) {
-		bcm2835aux_spi_reset_hw(bs);
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 		complete(&master->xfer_completion);
 	}
=20
@@ -307,9 +313,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct=20
spi_master *master,
 		}
 	}
=20
-	/* Transfer complete - reset SPI HW */
-	bcm2835aux_spi_reset_hw(bs);
-
 	/* and return without waiting for completion */
 	return 0;
 }
@@ -330,10 +333,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_=
master=20
*master,
 	 * resulting (potentially) in more interrupts when transferring
 	 * more than 12 bytes
 	 */
-	bs->cntl[0] =3D BCM2835_AUX_SPI_CNTL0_ENABLE |
-		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
-		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
-	bs->cntl[1] =3D BCM2835_AUX_SPI_CNTL1_MSBF_IN;
=20
 	/* set clock */
 	spi_hz =3D tfr->speed_hz;
@@ -352,13 +351,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_=
master=20
*master,
=20
 	spi_used_hz =3D clk_hz / (2 * (speed + 1));
=20
-	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
-		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
 	/* set transmit buffers and length */
 	bs->tx_buf =3D tfr->tx_buf;
 	bs->rx_buf =3D tfr->rx_buf;
@@ -382,6 +374,46 @@ static int bcm2835aux_spi_transfer_one(struct spi_=
master=20
*master,
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
 }
=20
+static int bcm2835aux_spi_prepare_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct spi_device *spi =3D msg->spi;
+	struct bcm2835aux_spi *bs =3D spi_master_get_devdata(master);
+
+	bs->cntl[0] =3D BCM2835_AUX_SPI_CNTL0_ENABLE |
+		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
+		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
+	bs->cntl[1] =3D BCM2835_AUX_SPI_CNTL1_MSBF_IN;
+
+	/* handle all the modes */
+	if (spi->mode & SPI_CPOL) {
+		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPOL;
+		if (spi->mode & SPI_CPHA)
+			bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+		else
+			bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
+	} else {
+		if (spi->mode & SPI_CPHA)
+			bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
+		else
+			bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+	}
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
+
+	return 0;
+}
+
+static int bcm2835aux_spi_unprepare_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct bcm2835aux_spi *bs =3D spi_master_get_devdata(master);
+
+	bcm2835aux_spi_reset_hw(bs);
+
+	return 0;
+}
+
 static void bcm2835aux_spi_handle_err(struct spi_master *master,
 				      struct spi_message *msg)
 {
@@ -410,6 +442,8 @@ static int bcm2835aux_spi_probe(struct platform_dev=
ice=20
*pdev)
 	master->num_chipselect =3D -1;
 	master->transfer_one =3D bcm2835aux_spi_transfer_one;
 	master->handle_err =3D bcm2835aux_spi_handle_err;
+	master->prepare_message =3D bcm2835aux_spi_prepare_message;
+	master->unprepare_message =3D bcm2835aux_spi_unprepare_message;
 	master->dev.of_node =3D pdev->dev.of_node;
=20
 	bs =3D spi_master_get_devdata(master);
--=20
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
