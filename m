From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 17:12:21 +0100
Message-ID: <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3dlpnuuk6uvwtfp"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h3dlpnuuk6uvwtfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2017 at 06:46:46PM -0700, Randy Dunlap wrote:
> On 09/22/17 02:26, Mark Brown wrote:

> > right thing - if we can use hwspinlocks in a module when they're enabled
> > I'd expect to be able to build the stubs that way too.

> Sorry, I'm not understanding what you are trying to say on that one.

> HWSPINLOCK	SPI_SPRD_ADI

> but this combo is not allowed (with the patch) or causes build errors
> (without the patch):
> 	m		y

Why is that not just an || COMPILE_TEST dependency then?  The dependency
you're trying to introduce is weird and confusing, we shouldn't be
having to do things like that.

--h3dlpnuuk6uvwtfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJKuQACgkQJNaLcl1U
h9ClSAf9HXapwrFbCjSOUCah0zc1oA5WhxRvwyOxF/q2IH2yN5nKJ4bc8yMxxXeo
ruzy5zNQdshL6RKjY3aHp9weYV0E661UGCpaFxPZ8phtVtWZAWLx5/m/+1YxwqJt
7vDH3z9+pAeGad3KiBEF/RzOvKRfcbyWvYWTjiCDAhNk2bfJZfVTaDgwCQ87iYr0
o1UxB2qq9vPm9Zq0ci9ijb4LqpxbMUQYA8zyxcfhsrXnhKuLqQuHMJsl5TTOzzYe
dZTkIXq8jwYyCdZ8M1+umMqD3NL3b1vDmZnRfZj/BuQ88d3Fd4YjszBGdmZzqz2x
uqNlI30LKBCBlgl91Slwyu2T1acBPA==
=OUIe
-----END PGP SIGNATURE-----

--h3dlpnuuk6uvwtfp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
