From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: introduce master->handle_err() callback
Date: Fri, 6 Mar 2015 19:42:25 +0000
Message-ID: <20150306194225.GP21293@sirena.org.uk>
References: <1425051256-30890-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C6w0Iymza2KbN2ax"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425051256-30890-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--C6w0Iymza2KbN2ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 27, 2015 at 05:34:15PM +0200, Andy Shevchenko wrote:
> This callback would be useful to handle an error that occurs in the generic
> implementation of transfer_one_message(). The good candidate for this is to
> drain FIFO and / or to terminate DMA transfers when timeout happened.

Applied both, thanks.

--C6w0Iymza2KbN2ax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gMgAAoJECTWi3JdVIfQg1gH/3AKese2rrWNG5YQYMlQNBu6
fxylwRLlJHcYhcnfgU8qGpRVhHPrugHdjhZZpdCazwfo+KsixGjUf5JSQbCRyJ1g
jSCTennD8A/BtPFnw41eGuZkFuWwLQ5GKULVPDZmbDd/jqdSLNu81tMxqswOc6Co
xTowyzIlCebgR1AGmT4W4H2zJ2ywCcmDh4mxb7paCVwDbFw/Pnexr5qsZysh1wLK
i39AqXIkrxA13z6QVF2aUS+GbCzt08lKk5/lFMjzZirW32wPT16kHu1PwcbRvU6+
JLqdlJQDuNsbjMBpiYQwng1BKrHuK7KLi9H6iZNAxaDKE0GZuNVlWNjQFHhNfIg=
=kVXf
-----END PGP SIGNATURE-----

--C6w0Iymza2KbN2ax--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
