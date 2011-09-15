From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI
	chipselects are used
Date: Thu, 15 Sep 2011 15:01:46 -0600
Message-ID: <20110915210146.GH3523@ponder.secretlab.ca>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
	<20110915195243.GH11297@pengutronix.de>
	<20110915201909.GI11297@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	spi-devel-general@lists.sourceforge.net, kernel@pengutronix.de,
	shawn.guo@freescale.com, linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110915201909.GI11297@pengutronix.de>
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

On Thu, Sep 15, 2011 at 10:19:09PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello again,
> =

> On Thu, Sep 15, 2011 at 09:52:43PM +0200, Uwe Kleine-K=F6nig wrote:
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 8ac6542..fa594d6 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -786,9 +786,11 @@ static int __devinit spi_imx_probe(struct platform=
_device *pdev)
> >  		int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
> >  		if (cs_gpio < 0)
> >  			cs_gpio =3D mxc_platform_info->chipselect[i];
> > +
> > +		spi_imx->chipselect[i] =3D cs_gpio;
> >  		if (cs_gpio < 0)
> >  			continue;
> > -		spi_imx->chipselect[i] =3D cs_gpio;
> > +
> >  		ret =3D gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
> >  		if (ret) {
> >  			while (i > 0) {
> Having said that I wonder how to specify to use an internal chipselect
> via DT?

It would be done with a blank gpio specifier which is supported by the GPIO=
 binding.

g.
