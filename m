From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Fix long standing chip select issue for non-default
 CS-polarity setups
Date: Wed, 27 Nov 2013 18:40:01 +0000
Message-ID: <20131127184001.GG14725@sirena.org.uk>
References: <EE805C3B-7650-45CF-ACA7-5A83758B7F77@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e6WJdJvMwaEsjV+9"
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-3lzwWm7+WeqjrCrn2yxA+g@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EE805C3B-7650-45CF-ACA7-5A83758B7F77-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e6WJdJvMwaEsjV+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 08:13:57PM +0100, Martin Sperl wrote:
> > It doesn't look like that, it looks like the update first resets things
> > to a default and then writes in the new value.  It also appears to
> > affect the entire array rather than just one value.

> The problem is that there is only _ONE_ register in the SOC that affects
> all Polarity flags.

OK, I think this makes sense but I'd need to check the code again -
please make sure this is clear when you resubmit.

> > The other thing is that as with all your other code this is full of
> > coding style issues, these will need to be fixed.  Please, as previously
> > requested, read and follow CodingStyle.

> I had been reading the coding styles document and tried to implement
> everything recommended there in the patch.

The biggest things I remember were a lack of spaces around operators and
the opening braces for functions not being on a line by themselves.

> > This doesn't require a bus lock, it only affects the individual device.

> It would require a bus_lock for ANY change to SPI_CS_HIGH.

That's just never going to be a sane thing to change on the fly though.
Changes to things that don't affect /CS are more interesting here.

--e6WJdJvMwaEsjV+9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljx+AAoJELSic+t+oim95NgP/iY+J0INVJWONNWoX0k8GEJw
l/WxAE8c/UC3kI/1Fc9fmi5gCOFuMV6ELKudEe1iHR+l8MLbViEaIjTRqhZDQgio
ELcZCN9tuLcMYdVkqtPlWQ7B8Yn65HBEtutAaCW9z9rTCQP4f3wITsBrI71jk0us
j+G7dWHuqcZwv8EYEQw89jpN131D2qnGW8cGFETNYVqiZm3kPtzWkLQ/pNL0uOIQ
niNC0A0n30CkuzUb9sqQ8OUFqaj8Vtl55maI691XQ86Q7/FGJNQo1uXHWZ3ty76H
0GlCkXh6CXtlyJf4BRA4b6zBwWUWw1asOLH6Td05jXuwfHFj2TYK5f4vY3D0fMso
mNEH10ij0RIbsBLK1n4XLlbhFrcpmvueQQt8JwD9t8Z9zZWC1flaDD/puLBpFY9n
4IWGU33DQOXjZFI/d2lEfK3e2aeQTvT2+JFb7UiEd7gqRHrqtAsqtvrZcpo1hd6v
d6QUmTo4fH4L+dlveq697kPpYpjzkwRKw68yVBMp5ZzXIE8wQ/xATHpHP0f8dDbh
NqKJQLNu/4BlMqAsWCQeO5pdHLuSDsxx9n5c10UVOPs3lwh2BM2q/Rjla/ZfgDpa
qbRDzXCEpXqq/zplPaxlLTzkrxzn7N0VQEvm4lTrTE6EwYln64m696MgkcX5Azgz
1Y9N2cRJex9JVR/CPd9M
=g8Yl
-----END PGP SIGNATURE-----

--e6WJdJvMwaEsjV+9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
