From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare
 for separate i2c and spi
Date: Wed, 29 Dec 2010 00:40:33 -0700
Message-ID: <20101229074033.GJ8172@angua.secretlab.ca>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
 <1292817055-17715-2-git-send-email-marc@cpdesign.com.au>
 <20101220083120.GP1940@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101220083120.GP1940-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Marc and Uwe,

On Mon, Dec 20, 2010 at 09:31:20AM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 20, 2010 at 02:50:52PM +1100, Marc Reilly wrote:
> > This patch moves common mc13xxx definitions to the header file in
> > preparation for separate i2c and spi driver modules.
> > spi specific functions are also removed.
> >=20
> > Changes to the mc13xxx struct are:
> > removing the redundant irq member,
> > adding driver read/write function ptrs,
> > adding ictype
> This list isn't complete, but see below.
>=20
> I don't like that after this patch the driver isn't functional, becau=
se
> you removed the spi functionality which breaks bisection.

Ugh, yes.  Breaking bisection is absolutely a no-no.  I'll wait for
the next version of this series before I do a full review.

>=20
> > Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> > ---
> >  drivers/mfd/mc13xxx-core.c  |  207 +++++++------------------------=
-----------
> >  include/linux/mfd/mc13xxx.h |   77 +++++++++++-----
> >  2 files changed, 87 insertions(+), 197 deletions(-)
> >=20
> > diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.=
c
> > index a2ac2ed..3367a40 100644
> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> > @@ -9,24 +9,14 @@
> >   * the terms of the GNU General Public License version 2 as publis=
hed by the
> >   * Free Software Foundation.
> >   */
> > -
> (hmm.  I think there is no style guide for that, but I know people wh=
o
> think that this nl should be there.  So IMHO don't touch this.)

A better comment is: don't make unrelated, non-functional whitespace
changes in patches for something else.  They add noise that make it
harder to review.

Cheers,
g.
