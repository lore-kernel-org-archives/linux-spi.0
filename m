From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] SPI: drain MXC SPI transfer buffer when probing device
Date: Thu, 19 Nov 2009 20:08:53 +0100
Message-ID: <20091119190853.GC26816@pengutronix.de>
References: <1258627487-7408-1-git-send-email-daniel@caiaq.de>
	<20091119184951.GA26816@pengutronix.de>
	<20091119190142.GO14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
To: Daniel Mack <daniel@caiaq.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20091119190142.GO14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Thu, Nov 19, 2009 at 08:01:42PM +0100, Daniel Mack wrote:
> Hi Uwe,
> =

> On Thu, Nov 19, 2009 at 07:49:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Nov 19, 2009 at 11:44:47AM +0100, Daniel Mack wrote:
> > > On the MX31litekit, the bootloader seems to communicate with the MC13=
783
> > > PMIC chip before booting Linux. However, it does not flush all the
> > > buffers properly after that, which makes the imx-spi driver read
> > > bogus data when probing the MC13783.
> > > =

> > > Fix that by draining the SPI buffer on startup.
> > > =

> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > Cc: David Brownell <dbrownell@users.sourceforge.net>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Cc: spi-devel-general@lists.sourceforge.net
> > > ---
> > >  drivers/spi/spi_imx.c |    7 +++++++
> > >  1 files changed, 7 insertions(+), 0 deletions(-)
> > > =

> > > diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> > > index 89c22ef..a3894fd 100644
> > > --- a/drivers/spi/spi_imx.c
> > > +++ b/drivers/spi/spi_imx.c
> > > @@ -42,8 +42,11 @@
> > >  #define MXC_CSPITXDATA		0x04
> > >  #define MXC_CSPICTRL		0x08
> > >  #define MXC_CSPIINT		0x0c
> > > +#define MXC_CSPISTAT		0x14
> > On imx27 the register at offset 0x14 is called PERIODREG ...
> > =

> > >  #define MXC_RESET		0x1c
> > >  =

> > > +#define MXC_CSPISTAT_RR		(1 << 3)
> > ... and bits 0..14 are called WAIT.
> > =

> > =

> > > +
> > >  /* generic defines to abstract from the different register layouts */
> > >  #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
> > >  #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
> > > @@ -593,6 +596,10 @@ static int __init spi_imx_probe(struct platform_=
device *pdev)
> > >  	if (!cpu_is_mx31() || !cpu_is_mx35())
> > >  		writel(1, spi_imx->base + MXC_RESET);
> > >  =

> > > +	/* drain the buffer */
> > > +	while (readl(spi_imx->base + MXC_CSPISTAT) & MXC_CSPISTAT_RR)
> > > +		readl(spi_imx->base + MXC_CSPIRXDATA);
> > > +
> > So this needs protection by
> > =

> > 	if (cpu_is_mx31() || cpu_is_mx35())
> =

> Oh, I wasn't aware of such differences, thanks for checking!
> =

> > (note, I didn't check the mx35 reference!).
> =

> But I did now, and mx35 seems to be compatible. I also changed the
> register define names to avoid confusion.
hmm, I'm not really happy with the naming, but as I don't have a better
idea now, it's OK for me.
 =

You can take it as an ack.

Best regards
Uwe

-- =

Pengutronix e.K.                              | Uwe Kleine-K=F6nig         =
   |
Industrial Linux Solutions                    | http://www.pengutronix.de/ =
 |
