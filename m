From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
	value against zero
Date: Wed, 16 Dec 2009 18:49:04 +0100
Message-ID: <20091216174904.GB26325@pengutronix.de>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de> <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de> <20091216163229.GA26350@oksana.dev.rtsoft.ru>
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753454AbZLPRtS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216163229.GA26350@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

[Note the email address used for David Vrabel isn't valid any more,
this mail uses his last used address.]

On Wed, Dec 16, 2009 at 07:32:29PM +0300, Anton Vorontsov wrote:
> On Wed, Dec 16, 2009 at 05:10:08PM +0100, Uwe Kleine-K=F6nig wrote:
> > platform_get_irq returns -ENXIO on failure, so !irq was probably
> > always true.  Better use (int)irq <=3D 0.  Note that a return value=
 of
> > zero is still handled as error even though this could mean irq0.
> >=20
> > This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
> > changed the return value of platform_get_irq from 0 to -ENXIO on er=
ror.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
>=20
> Noooooo... :-(
>=20
> Please revert 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 instead,
> and fix platforms to remap HWIRQ0 to something that is not VIRQ0.
>=20
> IRQ0 is invalid for everything that is outside of arch/*.
>=20
> http://lkml.org/lkml/2005/11/22/159
> http://lkml.org/lkml/2005/11/22/213
> http://lkml.org/lkml/2005/11/22/227
=46irst note that my check is safe with both variants (e.g. it does the
right thing independent of the error being signaled by 0 or
-ESOMETHING.)

Then arch/arm/mach-pxa/devices.c has:

static struct resource pxa27x_resource_ssp3[] =3D {
	...
	[1] =3D {
		.start  =3D IRQ_SSP3,
		.end    =3D IRQ_SSP3,
		.flags  =3D IORESOURCE_IRQ,
	},
	...
}

with IRQ_SSP3 being zero (sometimes).  The driver is implemented in
arch/arm/mach-pxa/ssp.c and uses platform_get_irq.  So according to you=
r
definition it's allowed (arch/* only).  Still this would break if you
revert 305b3228f9.

Actually I don't care much, but as platform_get_irq returns an int I
think it's fine for it to signal an error using a value < 0 as irqs are
not negative.

My position regarding irq0 is:  If a variable holds either a valid irq
or a value indicating "no irq", then feel free to use 0 as "no irq" and
a value > 0 for a valid irq (without offset).  If you want irq0 here,
you're out of luck.  But if you have a variable holding a valid irq onl=
y
(that is, there is no doubt if the value is valid or not) I see no
reason to dogmatically prohibit irq0.

I'm a bit annoyed as this is the third time[1] this month this irq0
discussion pops up for me.  I think people see that irq0 is involved
somehow, start wailing and stop seeing the issues being fixed.

Best regards
Uwe

[1] one is:
	http://thread.gmane.org/gmane.linux.kernel/924739
    the other wasn't on lkml, only mm-commits.  Cannot find it on the
    net now.
--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
