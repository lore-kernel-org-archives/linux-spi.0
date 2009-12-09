From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: +
	spi-imx-correct-check-for-platform_get_irq-failing.patch	added
	to -mm tree
Date: Wed, 9 Dec 2009 16:32:41 +0100
Message-ID: <20091209153241.GB1389@pengutronix.de>
References: <200912082330.nB8NU4IO016215@imap1.linux-foundation.org>
	<fa686aa40912081638m734e97c3r2c3f412898d293b@mail.gmail.com>
	<20091209074533.GB8136@pengutronix.de>
	<fa686aa40912090708g45879802l6cea7b401b1434e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	daniel-rDUAYElUppE@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fa686aa40912090708g45879802l6cea7b401b1434e3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 09, 2009 at 08:08:19AM -0700, Grant Likely wrote:
> (resend because I forgot to cc the mailing list)
> =

> 2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > Hello Grant,
> >
> > On Tue, Dec 08, 2009 at 05:38:57PM -0700, Grant Likely wrote:
> >> > diff -puN drivers/spi/spi_imx.c~spi-imx-correct-check-for-platform_g=
et_irq-failing drivers/spi/spi_imx.c
> >> > --- a/drivers/spi/spi_imx.c~spi-imx-correct-check-for-platform_get_i=
rq-failing
> >> > +++ a/drivers/spi/spi_imx.c
> >> > @@ -554,7 +554,7 @@ static int __init spi_imx_probe(struct p
> >> > =A0 =A0 =A0 =A0}
> >> >
> >> > =A0 =A0 =A0 =A0spi_imx->irq =3D platform_get_irq(pdev, 0);
> >> > - =A0 =A0 =A0 if (!spi_imx->irq) {
> >> > + =A0 =A0 =A0 if (spi_imx->irq < 0) {
> >>
> >> This changes the old behaviour. =A0Is that what you intended? =A0'<=3D=
 0' perhaps?
> > Yes, the old check was wrong. =A0What if the irq to use is 0? =A0I thou=
ght
> > the commit log to be understandable. =A0platform_get_irq returns -ENXIO=
 on
> > error and an irq number on success. =A0So 0 has to be interpreted as va=
lid
> > irq, not an error.
> =

> 0 is not a valid IRQ
Hmm, on my x86 I have:

	$ grep '\<0:' /proc/interrupts =

	   0:      24330   IO-APIC-edge      timer

arm/davinci starts at 0, too.  As does arm/ns9xxx.  arm/pxa seems to
start at 1.  realview starts at 1, too.  So four out of five make are
wrong?  Seems like a big area for cleanup.

Best regards
Uwe

-- =

Pengutronix e.K.                              | Uwe Kleine-K=F6nig         =
   |
Industrial Linux Solutions                    | http://www.pengutronix.de/ =
 |

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
