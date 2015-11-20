From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 12:31:23 +0000
Message-ID: <20151120123123.GB1929@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151120000226.GP64635@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151120000226.GP64635-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2015 at 04:02:26PM -0800, Brian Norris wrote:
> On Wed, Nov 18, 2015 at 10:19:29PM +0100, Heiner Kallweit wrote:

> > I also add an example how a protocol driver could use this extension.
> > Appreciate any comment.

> One question I have: is it necessary to push the handling out into the
> protocol driver? I feel like I've seen a partial answer to this: the
> 'actual_legnth' return field suggests that the protocol driver already
> has to deal with shorter-than-desired transfers.

It should be possible to use actual_length if the hardware doesn't mind
the transfer being curtailed unexpectedly.

> Then I have another one: is the 'actual_length' field really
> insufficient? For instance, is it non-kosher for a spi_master to just
> cutoff the message at (for instance) 64K, and expect the protocol
> driver to handle that (e.g., with Michal's patch from [1])? And if that
> is kosher, then is there a good reason for the protocol driver to know
> the exact maximum for its spi_master?

It really depends if the hardware is able to cope with the error
handling (and ideally the SPI core will be able to transparently split
the transfer up into chunks the controller can cope with anyway).

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTxKaAAoJECTWi3JdVIfQwCYH+wZOY+oLa+AY/juLNWZA587T
Ovr6Qp8O7bpN4gwW58D03SeKXQBsc2Yht8Tqvuzd08rtc5sncMvlVsxNo0O7gK3E
mj/nTyR6ShA9WHzXp68533GG0ys4EmYfvj4agqzEHolOH8JJr+0i9jp11pMRDhvf
0t5koZCFv0tEYCC2P/q3AIcyXdi1h8791wtFK/EAZqpBzh3KHNmfqHWkQP7sIixR
VAmd+r2kA0rmaiemMCwmDr6lsKA6E2do1GbtypB+3U2UzBZJDjhj6bg4bmXrP3VB
2Eq330kXlw7WaeBpD2GtVD8Z+kQVZqt1qjB+gKQ2kRNWHodxT3MyVkKA81k/tqg=
=WFGH
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
