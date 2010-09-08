From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] spi/spi_s3c64xx: Increase dead reckoning time in
 wait_for_xfer()
Date: Wed, 8 Sep 2010 10:00:34 -0600
Message-ID: <20100908160034.GB3686@angua.secretlab.ca>
References: <1283873872-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1283873872-8633-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTimxXWjiX64wJcNui2mLrvVg9RUtN9fFVnLhZsBY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Jassi Brar <jassi.brar@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimxXWjiX64wJcNui2mLrvVg9RUtN9fFVnLhZsBY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 08, 2010 at 10:44:26AM +0900, Jassi Brar wrote:
> On Wed, Sep 8, 2010 at 12:37 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > For small transfers at high speeds the expected transfer time can e=
asily
> > be well under 1ms, causing the delay in wait_for_xfer() to be only =
the
> > dead reckoning fudge factor of 5ms currently included. Experiments =
on
> > some of my systems shows that this is marginal for some transfers s=
o
> > double it to 10ms.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> > =A0drivers/spi/spi_s3c64xx.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> > index 03b28e4..4abb441 100644
> > --- a/drivers/spi/spi_s3c64xx.c
> > +++ b/drivers/spi/spi_s3c64xx.c
> > @@ -326,7 +326,7 @@ static int wait_for_xfer(struct s3c64xx_spi_dri=
ver_data *sdd,
> >
> > =A0 =A0 =A0 =A0/* millisecs to xfer 'len' bytes @ 'cur_speed' */
> > =A0 =A0 =A0 =A0ms =3D xfer->len * 8 * 1000 / sdd->cur_speed;
> > - =A0 =A0 =A0 ms +=3D 5; /* some tolerance */
> > + =A0 =A0 =A0 ms +=3D 10; /* some tolerance */
> >
> > =A0 =A0 =A0 =A0if (dma_mode) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D msecs_to_jiffies(ms) + 10;
>=20
> Acked-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.

g.
