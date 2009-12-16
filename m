From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
	value against zero
Date: Wed, 16 Dec 2009 20:18:39 +0100
Message-ID: <20091216191839.GA23614@pengutronix.de>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de> <20091216163229.GA26350@oksana.dev.rtsoft.ru> <20091216174904.GB26325@pengutronix.de> <20091216182034.GA7590@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@csr.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kumar Gala <galak@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964907AbZLPTSs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216182034.GA7590@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Anton,

On Wed, Dec 16, 2009 at 09:20:34PM +0300, Anton Vorontsov wrote:
> On Wed, Dec 16, 2009 at 06:49:04PM +0100, Uwe Kleine-K=F6nig wrote:
> [...]
> > > Noooooo... :-(
> > >=20
> > > Please revert 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 instead,
> > > and fix platforms to remap HWIRQ0 to something that is not VIRQ0.
> > >=20
> > > IRQ0 is invalid for everything that is outside of arch/*.
> > >=20
> > > http://lkml.org/lkml/2005/11/22/159
> > > http://lkml.org/lkml/2005/11/22/213
> > > http://lkml.org/lkml/2005/11/22/227
> > First note that my check is safe with both variants (e.g. it does t=
he
> > right thing independent of the error being signaled by 0 or
> > -ESOMETHING.)
> >=20
> > Then arch/arm/mach-pxa/devices.c has:
> >=20
> > static struct resource pxa27x_resource_ssp3[] =3D {
> > 	...
> > 	[1] =3D {
> > 		.start  =3D IRQ_SSP3,
> > 		.end    =3D IRQ_SSP3,
> > 		.flags  =3D IORESOURCE_IRQ,
> > 	},
> > 	...
> > }
> >=20
> > with IRQ_SSP3 being zero (sometimes).  The driver is implemented in
> > arch/arm/mach-pxa/ssp.c and uses platform_get_irq.
>=20
> So fix this *one* driver? Implement arm-specific platform_get_irq() a=
s
> a band-aid. Or better, implement virtual irqs <-> hardware irqs mappi=
ng
> for ARM.
>=20
> [...]
> > I'm a bit annoyed as this is the third time[1] this month this irq0
> > discussion pops up for me.  I think people see that irq0 is involve=
d
> > somehow, start wailing and stop seeing the issues being fixed.
>=20
> For this particular driver, there is NO issue whatsoever. It is
> only used for PowerPC, which has VIRQ0 =3D=3D invalid IRQ. And note
> that there still could be HWIRQ0 on PowerPC, but it is *never*
> mapped to VIRQ0.
Yes, there is an issue.  If the platform device doesn't have a resource
specifing the irq, platform_get_irq returns -ENXIO.  So in the driver
(unsigned)(-ENXIO) is passed to mpc8xxx_spi_probe as (!(-ENXIO)) is
false and so the error isn't catched.

> [...]
> > [1] one is:
> > 	http://thread.gmane.org/gmane.linux.kernel/924739
>=20
> No wonder the discussion popped up. You're adding some ugly
> #ifdef stuff that adds some arch-specific knowledge to a generic
> code.
I wouldn't argue if people objected to the arch-specific #ifdef.  The
arch-specific code is already in there and I don't object to just
removing it.  But answering that irq0 must not be used isn't helpful.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
