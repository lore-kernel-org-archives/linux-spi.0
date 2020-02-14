From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 13:15:18 +0000
Message-ID: <20200214131518.GJ4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3RkK9jYN81zD2N+"
Cc: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--g3RkK9jYN81zD2N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 01:50:44PM +0100, Simon Goldschmidt wrote:

> So please correct me if I'm wrong, but to me it seems like if this driver won't
> work on altera, and after merging it the currently working driver will be
> removed, altera will be broken.

I'm not seeing anything in the driver that removes whatever the current
support is?  Unless it's just adding a duplicate driver for the same
compatible strings which is obviously a bad idea but at least means that
unless people enable the driver there's no risk of it colliding with the
existing one.

--g3RkK9jYN81zD2N+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GnWUACgkQJNaLcl1U
h9Bf0wf+JRM88awtvIQMXfKs1lgxlfllMbkWple5qv/wNTCdOQfaqsYNta9ZBXmW
I5jaATsvd7dyl4UhU8//nUEC/uiqs0wi0Qcz5LplUoA8mX+2DN2OkkywX2pexC+A
FuLWl+mOO2iXYpnz+Yuhc8P5/S9FWS3V/MzII1dxVFfe+dBjHjkVZ+bQeu+VoZtg
n9vCFK9ypKEwT6W7ktYYp6BFXZVkECwmsWUPINA/lpYOMth1GyoNGMUJ6nV7Vbqo
FM5+BfieQSilXzI93+sGTRhfiFWrr6E8Lrms/gr8UExCo3ug6CYeOmLPKTfRc4Pv
ccqVO9SZBPo+cN2rES/CeCUC5WJpAA==
=aZzY
-----END PGP SIGNATURE-----

--g3RkK9jYN81zD2N+--
