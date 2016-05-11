From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: omap2-mcspi: Undo broken fix for dma transfer of
 vmalloced buffer" to the spi tree
Date: Wed, 11 May 2016 17:20:30 +0100
Message-ID: <20160511162030.GN6261@sirena.org.uk>
References: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
 <E1apndq-0002S5-8J@debutante>
 <CAC5umyg2fJxYKOB4J96+3igkNx+eJs5MET8S8NnafZ3hcPPEag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC5umyg2fJxYKOB4J96+3igkNx+eJs5MET8S8NnafZ3hcPPEag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 12:39:35AM +0900, Akinobu Mita wrote:

> I realized that this undo patch has not been merged to Linus' tree yet.
> I have a fix for this issue (attached patch).  But the change is not
> small and also v4.6 release is soon.  So I think this undo patch
> should go into 4.6 release.

I actually just sent that a few minutes ago anyway.

> The actual DMA transfer length by dmaengine can be smaller than SPI
> transfer length in the specific condition.  In that case, the last
> word needs to be filled after DMA transfer completion.

> This fixes it by detecting that case and remap the scatterlist with
> correct DMA transfer length.

This feels like it should be in the framework, I imagine other devices
will have similar limiations.  Especially if the limitation comes from
the DMA engine I'd hope we can arrange to query it somehow...  can you
provide a bit more detail on what the restriction is please?

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM1vNAAoJECTWi3JdVIfQte8H+wYeHgHG0iqbsWJWI2Mqze//
5xNnANllLET9k/DnLwjDOdSoJDfhf1rjfu7wxQ6sNcpyyC0EOzn/kJb0bk/qYG5Z
LKIA++42flykWACVeXbEGEdNuIVknyCGl6Z6GsMqkSw20oL1jNt3cMWKCwcIq50o
b6AmCUhG5eAeoeQ3VIEM4LTs6IDDJZuzyg4xTR9PzEaI3OC9L1PEfOD49wJgCAep
/HESLlgGPeB+Tg3YmV3h99y2RHnYPXb7fEWq0ujXlpleyXzVprhJYEaDiXLHKwSI
w+MyHEydznR2rbMNf9LqpL+VygmWxNsWsVN7HRPzi8xxrOFGaP6P4Cuon5EjDQM=
=4B0x
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
