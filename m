From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/16] spi/imx: save the spi chip select in config
	struct, not the gpio to use
Date: Fri, 17 Sep 2010 12:20:26 +0100
Message-ID: <20100917112026.GE27467@n2100.arm.linux.org.uk>
References: <20100917095247.GB30441@pengutronix.de>
	<1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<19603.19666.323684.891456@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19603.19666.323684.891456@ipc1.ka-ro>
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

On Fri, Sep 17, 2010 at 01:11:14PM +0200, Lothar Wa=DFmann wrote:
> Hi,
> =

> > diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> > index 60a52d1..23db984 100644
> > --- a/drivers/spi/spi_imx.c
> > +++ b/drivers/spi/spi_imx.c
> > @@ -56,7 +56,7 @@ struct spi_imx_config {
> >  	unsigned int speed_hz;
> >  	unsigned int bpw;
> >  	unsigned int mode;
> > -	int cs;
> > +	u8 cs;
>         ^^^^^^

u8 cs in spi_imx_config.

> >  };
> >  =

> >  enum spi_imx_devtype {
> > @@ -218,6 +218,7 @@ static int __maybe_unused spi_imx0_4_config(struct =
spi_imx_data *spi_imx,
> >  		struct spi_imx_config *config)
> >  {
> >  	unsigned int reg =3D MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
> > +	int cs =3D spi_imx->chipselect[config->cs];

which is used as an index to this array (which presumably is an array of
ints.)  Let's hope that it is 256 entries long (maybe it should be
checked before use?)

> >  =

> >  	reg |=3D spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
> >  		MX31_CSPICTRL_DR_SHIFT;
> > @@ -230,9 +231,8 @@ static int __maybe_unused spi_imx0_4_config(struct =
spi_imx_data *spi_imx,
> >  		reg |=3D MX31_CSPICTRL_POL;
> >  	if (config->mode & SPI_CS_HIGH)
> >  		reg |=3D MX31_CSPICTRL_SSPOL;
> > -	if (config->cs < 0) {
> > -		reg |=3D (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> > -	}
> > +	if (cs < 0)
> >
> This can never be true, since an 'int' promoted from 'u8' will always
> be positive!

This is the value of chipselect[config->cs] not of the u8 config->cs.
