From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Fri, 18 Mar 2016 20:33:52 +0000
Message-ID: <20160318203352.GL2566@sirena.org.uk>
References: <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
 <20160318202310.GS30977@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGtad4bun3m+J/4B"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160318202310.GS30977@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZGtad4bun3m+J/4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 18, 2016 at 09:23:10PM +0100, Maxime Ripard wrote:
> On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:

> > Very few device drivers would work with 63byte transfers only and the
> > code for manually driving the CS line in case the DMA engine fails to
> > configure will necessarily go untested most of the time since most
> > systems will have DMA configured properly.

> That's not true. A significant portion would work. I don't like to
> make up numbers, but I guess only the EEPROMs and rather big screens
> wouldn't work.

You'll probably also see devices doing things like firmware downloads,
there's a bunch of applications for larger transfers.  Like you say it's
definitely not going to be a universal problem though, there's many
devices that just use SPI for fast register access.

--ZGtad4bun3m+J/4B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW7GYvAAoJECTWi3JdVIfQ0CEH/33CMWaBMWHbwpSnvixBuzXl
5ZLE1wmb2LHvqNuVsOvuCj4O3AFWq3UNS7citObZ4+W/rlQkehMekvh3l3xjO0En
pRnuRe8+s2mFpcvhMFlcWzdk8FTv1iF2TnFIdRnHjACjYw73Xv8TuDTo286Qc++L
XDLkpT5Pq8bcGa805nnd5DgiOOGsJTdmAZUfvDLyuXtop7nc9OpvJg0cutCdycRr
FZv08xrvhn+G6fvJ1pavIIXebTIFh4U2C77Rc1ap7qXYBd/AvpVGIf6Gs/sYyUyG
hOoD4TmFG02NZbyGffev5vRgpthR+m9kxEVDFuWWyO6LCLGzxN+ZhBAE/llVTKE=
=Puwx
-----END PGP SIGNATURE-----

--ZGtad4bun3m+J/4B--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
