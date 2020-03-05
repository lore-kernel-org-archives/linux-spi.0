From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Date: Thu, 5 Mar 2020 13:16:34 +0000
Message-ID: <20200305131634.GD4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
 <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
 <20200305130448.GC4046@sirena.org.uk>
 <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 03:13:53PM +0200, Vladimir Oltean wrote:
> On Thu, 5 Mar 2020 at 15:04, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > That's mostly all true but it's still better to pull fixes like this (or
> > the patch limiting the size) forwards and not have to think if it's safe
> > to not apply them as a fix, it's less effort all round.

> So do you want me to do something about it now?

No, it's fine for now but please bear this in mind in future.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g+7EACgkQJNaLcl1U
h9CuIgf8CPmhlqhfcee9Ci1AvSvSQ6xlsVV5/vgUDE46caYf+o0lvc3iJNPqnLvK
a0ZXaSs9mpkONPWpmXfsgk+BVbAb+4ykuipEHVp0G9py+KOxkzcXQRXiyjCGlqn/
PTGIhIq/gjJaN1CwSELFoL2MTNWWh64H+yCISBRIKMU6ttcKKpQ830LTWbdpTohP
Fgai52ynNFsOKA/JwfLrUcgjSNWXXSm+Bec2UcBWPWjrgYGkdQafoyjGCjfzSFL4
Ezrm3ye7do1VRFf/UJ6v02miFG4o+lEZv+FyVvCI/SWD2nu8m3yAVBdnWcZM5LVV
+E0vjsXEtwJu/XSCCQ2g2ao20+oveA==
=Ct73
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
