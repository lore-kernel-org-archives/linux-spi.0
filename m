From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
	value against zero
Date: Thu, 17 Dec 2009 14:05:49 +0100
Message-ID: <20091217130549.GA9032@pengutronix.de>
References: <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de> <20091216163229.GA26350@oksana.dev.rtsoft.ru> <20091216174904.GB26325@pengutronix.de> <20091216182034.GA7590@oksana.dev.rtsoft.ru> <20091216191839.GA23614@pengutronix.de> <20091216193745.GA20429@oksana.dev.rtsoft.ru>
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935424AbZLQNGF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216193745.GA20429@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Anton,

On Wed, Dec 16, 2009 at 10:37:45PM +0300, Anton Vorontsov wrote:
> On Wed, Dec 16, 2009 at 08:18:39PM +0100, Uwe Kleine-K=F6nig wrote:
> [...]
> > > > I'm a bit annoyed as this is the third time[1] this month this =
irq0
> > > > discussion pops up for me.  I think people see that irq0 is inv=
olved
> > > > somehow, start wailing and stop seeing the issues being fixed.
> > >=20
> > > For this particular driver, there is NO issue whatsoever. It is
> > > only used for PowerPC, which has VIRQ0 =3D=3D invalid IRQ. And no=
te
> > > that there still could be HWIRQ0 on PowerPC, but it is *never*
> > > mapped to VIRQ0.
> > Yes, there is an issue.  If the platform device doesn't have a reso=
urce
> > specifing the irq, platform_get_irq returns -ENXIO.  So in the driv=
er
> > (unsigned)(-ENXIO) is passed to mpc8xxx_spi_probe as (!(-ENXIO)) is
> > false and so the error isn't catched.
>=20
> If you look into how we create the platform device, you'll notice
> that -ENXIO isn't possible.
> It's in arch/powerpc/platforms/83xx/mpc832x_rdb.c:of_fsl_spi_probe(),
> which is a legacy interface that I'd like to be removed anyway.
>=20
> Though, if you want to fix the inconsistency in the platform device
> API, then I'd suggest to fix the platform_get_irq(). The driver itsel=
f
> is correct.
With platform_get_irq as it is today, the check in

	irq =3D platform_get_irq(pdev, 0);
	if (!irq)
		return -EINVAL;

is non-sense as !irq always evaluates to 0.  If your argue that the
resources are right, then the logical consequence is to strip down
plat_mpc8xxx_spi_probe to just

	struct spi_master *master;
	master =3D mpc8xxx_spi_probe(&pdev->dev,
		platform_get_resource(pdev, IORESOURCE_MEM, 0)
		platform_get_irq(pdev, 0));
	if (IS_ERR(master))
		return PTR_ERR(master);
	return 0;

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
