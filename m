From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Date: Thu, 5 Mar 2020 13:04:48 +0000
Message-ID: <20200305130448.GC4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
 <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 03:00:22PM +0200, Vladimir Oltean wrote:
> On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This is a fix and so should have been at the start of the series to make
> > sure there aren't any dependencies.

> My reasoning for not submitting it as a fix is:
> - The only driver that uses the functionality so far - spi-fsl-dspi -
> has worked thus far even with the limitation that only byte-by-byte
> transfers were supported properly.
> - I removed the limitation before actually changing the operating mode
> of spi-fsl-dspi. Therefore the limitation is effectively never seen.
> - New SPI drivers that would want to make use of software timestamping
> would do so through your SPI for-next branch anyway, where the
> limitation would be, again, fixed.

That's mostly all true but it's still better to pull fixes like this (or
the patch limiting the size) forwards and not have to think if it's safe
to not apply them as a fix, it's less effort all round.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g+O8ACgkQJNaLcl1U
h9A7pwf/XZVDWjQSxu5rxN8xVzJtVaBPgpdSXOfAxk82nRdHh7AI/SoMIe/GElEL
heL+Cu8F+ufVKbPZDbP6mS2DYQKgg5Xt5+Y07ShJfLK8WrqkU+WihtsRw9fkgp53
R4QwW3IfXPmfL7U7EHa4Ri7IbdpWiaAw6PWoFcRCcslI17FWWWpnB0L1NaXzlAp1
Hzf9OAzmW0HWqVdSI2lgxM3Rm9qqjQAF6fjV+yZkSHkCzKjl+Pjl1KVbjznmNe5c
uauBl5vQ/2TKZSqeQpix91rf/nio4YSNUiKBI2PFzMXXx0GK/BfXWHTA9MjlOpVp
keVlQduGvzfUHCT7G1GjlZV+LXgInw==
=WInA
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
