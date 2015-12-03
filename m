From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation
 methods
Date: Thu, 3 Dec 2015 14:34:17 +0000
Message-ID: <20151203143417.GE5727@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-3-git-send-email-kernel@martin.sperl.org>
 <20151201212929.GV1929@sirena.org.uk>
 <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org>
 <20151203003618.GQ1929@sirena.org.uk>
 <91B0D66C-97E5-4683-8896-091C4BD7FCAF@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <91B0D66C-97E5-4683-8896-091C4BD7FCAF-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2015 at 07:22:10AM +0100, Martin Sperl wrote:
> > On 03.12.2015, at 01:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> Rx/tx_dma is handled because it is there and it's address needs also to be
> >> accurately Shifted by that offset. I know that it is a depreciated interface,
> >> but as it is still there it needs to be supported...

> > It's really quite broken already for most users.

> If it is broken, then why not remove those members?

There are still a couple of users and someone needs to go through and
fix them.  I don't know which if any systems they run on, it's possible
that they manage to work as a result of the DMA mappings not getting in
the way the systems they're being used on (if they're being used at all)
or the controller drivers they're used with being equally aged.

> One last thing:
> Where do you prefer to run those transfer transformations?
> In the master-loop (before/after prepare message)?
> During spi_verify (or after it)?

Remember that we can't do any allocations in _verify() as it can run in
atomic context so while we want to check if we can take the message then
we are most likely going to be unable to implement transformations.

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYFLoAAoJECTWi3JdVIfQFygH/jZCsAOA8VPnOhv0+kKXipkQ
46x/K1aB0mwQSVDjmQDz6P0iBqZacrnp2HwAvimuMnqNlDGYaub42Upd+uFnToaF
mFTwv9/x6gxBHPRq7QZrrc7ksOteLSb/p0aPOQwzDSB3N1JjTaJzAkbEyCbswC1m
kJ8DTLBI9ePqQoe/bAJ1HryMAj9eRGyzpKeagaYQiAb5gq9UPdF3YRtchNOE/zEx
a48BuueCq6rm5oOstGpwiA7UGf19XUjP+027TSwYojBRBbVfVxR58APRuOTIYZsU
CLs2kGE5mzuDfTc3iKKiicJnJiFi/jj+H28qXMlKHGo/0YkYrKUSpqnGHqwo7UI=
=ITDU
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
