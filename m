From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Mon, 8 Feb 2016 14:02:57 +0000
Message-ID: <20160208140257.GC7265@sirena.org.uk>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <56AF01B6.6030204@gmail.com>
 <20160208031134.GI2531@localhost>
 <3817335.PXCk0JfYDT@phil>
 <20160208131419.GA19598@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160208131419.GA19598@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 06:44:19PM +0530, Vinod Koul wrote:
> On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:

> > I think the more regular way is for the driver maintainer to take the=
=20
> > driver-specific stuff and the devicetree parts going through the specif=
ic arm-
> > tree. But if you really want to take the whole series, for patches 4,5,6

> Yes but that causes cross tree dependencies, which looking at this won't =
be
> a big problem, so I can safely merge dmaengine changes and rest can go th=
ru
> ARM tree.

Not for the DT stuff - since the DT is supposed to be a stable ABI there
really shouldn't be any hard dependencies on things outside the DT.

> Typically submitter should say which tree he/she prefers, which was not
> provided..

It's the norm for DT stuff.

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuKARAAoJECTWi3JdVIfQ5+IH/RfdkKdGgrryPKWH6j09ZoLc
23CoxN0Y3eUCdKOZU7ywHHGMr4ZsPzSTW1fjYJv7+CxNDlRUXQBYT3DvggoQ4idz
0jkIyf7JUhYnLoo/5LaUulLF2qvkHKjanJH/rbZh4xgn7lUe+qpCX8TLko7SDIph
jVCNJAQhkQ/Ca1Fi2IK1eMSHgc3hmpXiY+sOVjlGigO07+WCye0QNGXQ0arpKrY3
Ea2hVRR6o6zajuVHm332gQiyTVY9S0ZgwDuJ3uqk/vkjh1gn2CExDEYZFiP5LaHi
suo0XW2KcvsBhhLCpqzMyHRBTnMC8uSsHenzE/jVYu3xXkEN3r9pfT9S0DQG1Rg=
=g7sB
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
