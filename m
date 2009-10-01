From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/7] Updates for spi-imx
Date: Thu, 1 Oct 2009 06:59:45 +0200
Message-ID: <20091001045945.GA30932@pengutronix.de>
References: <20090930194211.GB1881@pengutronix.de> <20090930165241.ecb2a83e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, s.hauer@pengutronix.de,
	g.liakhovetski@gmx.de, linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751910AbZJAFAi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090930165241.ecb2a83e.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andrew,

On Wed, Sep 30, 2009 at 04:52:41PM -0700, Andrew Morton wrote:
> On Wed, 30 Sep 2009 21:42:11 +0200
> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > as a followup to this mail I'll send some updates for the spi-imx
> > driver for review.
>=20
> Several of these patches were unchangelogged but afaict they all fix
> bugs and hence should be in 2.6.32, yes?
I'm not sure about "strip down chipselect function to only drive the
chipselect", that's why I marked it RFC.  I see the driver working with
it and using less register writes, but if someone would check it and
consider it OK, I'd feel better.=20

"spi-imx: no need to assert bits_per_word being initialized" isn't a
real bugfix, it just removes an if(...) that is never hit.

The other (non-naughty) patches are bugfixes, yes.
=20
> Renaming the entire source file after -rc1 was probably a bit naughty=
,
> but we'll survive.
I didn't target for 2.6.32, I just wanted to get rid of the patches.
The earlier they get in the better for me.

To be honest I expected to get back some patches because of the missing
changelog.  I just wanted to get them out before going to bed.

Best regards and thanks for picking my patches up
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
