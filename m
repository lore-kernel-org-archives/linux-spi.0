From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH] spi/spi_s3c64xx: Warn if PIO
 transfers time out
Date: Wed, 8 Sep 2010 12:23:15 -0600
Message-ID: <20100908182315.GR3686@angua.secretlab.ca>
References: <1282581656-26137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTim6+6-L8ALM0YO01D44PmZgsbcMrrwRxrPJMkpT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim6+6-L8ALM0YO01D44PmZgsbcMrrwRxrPJMkpT@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 24, 2010 at 09:06:40AM +0900, Jassi Brar wrote:
> On Tue, Aug 24, 2010 at 1:40 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > When using PIO we have a timeout for the TX and RX FIFOs to ensure =
that
> > the data actually gets transferred. Warn if we hit that timeout - i=
t
> > should never happen, but this makes sure we'll find out if it does.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> > =A0drivers/spi/spi_s3c64xx.c | =A0 =A06 ++++++
> > =A01 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> > index 7e627f7..f72e1c0 100644
> > --- a/drivers/spi/spi_s3c64xx.c
> > +++ b/drivers/spi/spi_s3c64xx.c
> > @@ -200,6 +200,9 @@ static void flush_fifo(struct s3c64xx_spi_drive=
r_data *sdd)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D readl(regs + S3C64XX_SPI_STA=
TUS);
> > =A0 =A0 =A0 =A0} while (TX_FIFO_LVL(val, sci) && loops--);
> >
> > + =A0 =A0 =A0 if (loops =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sdd->pdev->dev, "Timed out =
flushing TX FIFO\n");
> > +
> > =A0 =A0 =A0 =A0/* Flush RxFIFO*/
> > =A0 =A0 =A0 =A0loops =3D msecs_to_loops(1);
> > =A0 =A0 =A0 =A0do {
> > @@ -210,6 +213,9 @@ static void flush_fifo(struct s3c64xx_spi_drive=
r_data *sdd)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0} while (loops--);
> >
> > + =A0 =A0 =A0 if (loops =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sdd->pdev->dev, "Timed out =
flushing RX FIFO\n");
> > +
> > =A0 =A0 =A0 =A0val =3D readl(regs + S3C64XX_SPI_CH_CFG);
> > =A0 =A0 =A0 =A0val &=3D ~S3C64XX_SPI_CH_SW_RST;
> > =A0 =A0 =A0 =A0writel(val, regs + S3C64XX_SPI_CH_CFG);
>=20
> Ok, though I'll be very surprised to see the FIFO flush failing. We
> are not waiting
> for data to be transferred, but for SW Reset to make its effect.
>=20
> Acked-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.

g.
