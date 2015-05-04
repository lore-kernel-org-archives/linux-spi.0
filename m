From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon, 4 May 2015 15:30:30 +0100
Message-ID: <20150504143030.GE15510@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
 <1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
 <20150504134226.GY15510@sirena.org.uk>
 <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i6U+WTAJHBcf3BHs"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i6U+WTAJHBcf3BHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 04:25:01PM +0200, Martin Sperl wrote:

> > It's a bit unclear to me that we need to collect the stats on both a
> > per device and a per master basis, if we've got device statistics we can
> > add up the various devices to get the master values easily enough when
> > we need them.  It does mean that removing devices would discard some of
> > the statistics but it's not clear to me that this is actually going to
> > concern anyone.

> well - I found that it sometimes may help identify what device is responsible
> for an issue on a mixed device bus.

We can do that by looking at the devices though?  I'm not clear what the
master statistics are telling us?

> > Do we really need the locked version with a separate lock?  I know
> > you're very concerned about performance for some of your applications
> > and the fact that we're going to be spending a lot of time taking a
> > separate spinlock (with interrupt disabling... ) seems like it's going
> > to be adding overhead we could live without.

> I did not have it at first but was concerned that someone would complain
> about missing locking. That is why I have minimized the spinlock in the
> loop.

> That is easy to remove again...

I'm not saying don't lock, I'm asking if adding this spinlock is the
best way of doing this.  We already lock the master most of the time,
can we not continue using the same lock?

--i6U+WTAJHBcf3BHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR4KFAAoJECTWi3JdVIfQho8H/0e2MsLOBqRouLbfTEpOOD7T
GnqHRaDhbr2zFfRr5ocQ8kWWKhf1B/nVMS8ocuBzLGyO6Pk/rQiCuwkcLaqU/o07
GB5b4kVZ156RV7t9wcoBVJAm8B2Wt9A/7pRq+NxJOXtH2P2gZjyAQjHDsFYScNS4
P36KqeP7Ei+vTpMdpNjxcDra9TDhtwn3FfaRMp/D+XYVeEeHDXrMxSdHR3jEk0OA
A4povSUJmmLLTjNvCoA4ST9hsHZxTHclEqiwDPg//dqKh/iNCYW7CC+sWzzccCfn
aCkahuH08lPnCguiLe20cQzVj8rUMu940E4du3yH+E3cg8v8ZetzfIao20cfn58=
=9p29
-----END PGP SIGNATURE-----

--i6U+WTAJHBcf3BHs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
