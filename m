From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
 value against zero
Date: Wed, 16 Dec 2009 22:37:45 +0300
Message-ID: <20091216193745.GA20429@oksana.dev.rtsoft.ru>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
 <20091216163229.GA26350@oksana.dev.rtsoft.ru>
 <20091216174904.GB26325@pengutronix.de>
 <20091216182034.GA7590@oksana.dev.rtsoft.ru>
 <20091216191839.GA23614@pengutronix.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@csr.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kumar Gala <galak@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964953AbZLPTht@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216191839.GA23614@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 16, 2009 at 08:18:39PM +0100, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > > I'm a bit annoyed as this is the third time[1] this month this ir=
q0
> > > discussion pops up for me.  I think people see that irq0 is invol=
ved
> > > somehow, start wailing and stop seeing the issues being fixed.
> >=20
> > For this particular driver, there is NO issue whatsoever. It is
> > only used for PowerPC, which has VIRQ0 =3D=3D invalid IRQ. And note
> > that there still could be HWIRQ0 on PowerPC, but it is *never*
> > mapped to VIRQ0.
> Yes, there is an issue.  If the platform device doesn't have a resour=
ce
> specifing the irq, platform_get_irq returns -ENXIO.  So in the driver
> (unsigned)(-ENXIO) is passed to mpc8xxx_spi_probe as (!(-ENXIO)) is
> false and so the error isn't catched.

If you look into how we create the platform device, you'll notice
that -ENXIO isn't possible.
It's in arch/powerpc/platforms/83xx/mpc832x_rdb.c:of_fsl_spi_probe(),
which is a legacy interface that I'd like to be removed anyway.

Though, if you want to fix the inconsistency in the platform device
API, then I'd suggest to fix the platform_get_irq(). The driver itself
is correct.

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
