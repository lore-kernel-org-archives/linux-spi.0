From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: + spi-imx-correct-check-for-platform_get_irq-failing.patch
	added to -mm tree
Date: Wed, 9 Dec 2009 18:55:53 +0100
Message-ID: <20091209175553.GA25451@pengutronix.de>
References: <200912082330.nB8NU4IO016215@imap1.linux-foundation.org> <fa686aa40912081638m734e97c3r2c3f412898d293b@mail.gmail.com> <20091209074533.GB8136@pengutronix.de> <fa686aa40912090708g45879802l6cea7b401b1434e3@mail.gmail.com> <20091209153241.GB1389@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
	daniel@caiaq.de, dbrownell@users.sourceforge.net,
	s.hauer@pengutronix.de, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755502AbZLIR4K@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091209153241.GB1389@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 09, 2009 at 04:32:41PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Dec 09, 2009 at 08:08:19AM -0700, Grant Likely wrote:
> > (resend because I forgot to cc the mailing list)
> >=20
> > 2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > > Hello Grant,
> > >
> > > On Tue, Dec 08, 2009 at 05:38:57PM -0700, Grant Likely wrote:
> > >> > diff -puN drivers/spi/spi_imx.c~spi-imx-correct-check-for-plat=
form_get_irq-failing drivers/spi/spi_imx.c
> > >> > --- a/drivers/spi/spi_imx.c~spi-imx-correct-check-for-platform=
_get_irq-failing
> > >> > +++ a/drivers/spi/spi_imx.c
> > >> > @@ -554,7 +554,7 @@ static int __init spi_imx_probe(struct p
> > >> > =A0 =A0 =A0 =A0}
> > >> >
> > >> > =A0 =A0 =A0 =A0spi_imx->irq =3D platform_get_irq(pdev, 0);
> > >> > - =A0 =A0 =A0 if (!spi_imx->irq) {
> > >> > + =A0 =A0 =A0 if (spi_imx->irq < 0) {
> > >>
> > >> This changes the old behaviour. =A0Is that what you intended? =A0=
'<=3D 0' perhaps?
> > > Yes, the old check was wrong. =A0What if the irq to use is 0? =A0=
I thought
> > > the commit log to be understandable. =A0platform_get_irq returns =
-ENXIO on
> > > error and an irq number on success. =A0So 0 has to be interpreted=
 as valid
> > > irq, not an error.
> >=20
> > 0 is not a valid IRQ
> Hmm, on my x86 I have:
>=20
> 	$ grep '\<0:' /proc/interrupts=20
> 	   0:      24330   IO-APIC-edge      timer
>=20
> arm/davinci starts at 0, too.  As does arm/ns9xxx.  arm/pxa seems to
> start at 1.  realview starts at 1, too.  So four out of five make are
> wrong?  Seems like a big area for cleanup.
I've read a bit and I think the best for a driver writer (i.e. the role
I have when changing drivers/spi/spi_imx.c) is to accept what
platform_get_irq returns to me.  If the platform specified=20

	struct resource mydevicesresources[] =3D {
		...
		{
			.start =3D 0,
			.end =3D 0,
			.flags =3D IORESOURCE_IRQ,
		},
		...
	};

then the best thing to do is to take irq0, isn't it.  So as
platform_get_irq is implemented as

	int platform_get_irq(struct platform_device *dev, unsigned int num)
	{
	        struct resource *r =3D platform_get_resource(dev, IORESOURCE_I=
RQ, num);

        	return r ? r->start : -ENXIO;
	}

testing for <0 seems right to me.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
