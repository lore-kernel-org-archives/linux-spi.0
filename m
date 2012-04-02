From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: mc13xxx: add I2C support, V5
Date: Mon, 2 Apr 2012 08:40:12 +0200
Message-ID: <20120402064012.GY15647@pengutronix.de>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <20120401092125.GX15647@pengutronix.de>
 <201204011939.49665.marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexg-uRCCPK1wpQlR0G4FFNCX/g@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204011939.49665.marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Marc,

On Sun, Apr 01, 2012 at 07:39:49PM +1000, Marc Reilly wrote:
> > On Sun, Apr 01, 2012 at 04:41:35PM +1000, Marc Reilly wrote:
> > > This series (against mfd-2.6/for-next) changes the mc13xxx driver=
 to use
> > > regmap and adds I2C support.
> > > It has a compile dependency on regmap/for-next, as the spi driver=
 uses
> > > the recently added pad_bits config field.
> > >=20
> > > Patch 2/4 has:
> > > Reviewed-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > > Patch 4/4 has:
> > > Signed-off-by: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
> >=20
> > You didn't add these tags to the respective patches. (And I think
> > Signed-off-by: Oskar is wrong. Maybe this should be an Ack?)
>=20
> Whats the best/proper way to do this? Do I need to rebase the series =
and add=20
> them with each relevant commit, or just add them manually to the patc=
hes? Or=20
> option C...
Rebasing is ok, still more as you didn't publish your tree (at least I'=
m
not aware of it). The tags should definitly make it into the final
history. When you submit the patches via email it doesn't matter if you
add them to your git tree or only to the mail (as you tree doesn't
matter for the final result).

> For Oskar's tag, I just copied it from an email from the previous thr=
ead.=20
Yeah, I saw it. That was already wrong. S-o-b is only for the author(s)
of a patch and the people forwarding it for inclusion (either via mail
or via a git tree). A S-o-b certifies that the patch's copyright is
suitable for the kernel. It doesn't say anything about its technical
impact.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
