From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: fsl: simplify error path in of_fsl_spi_probe()
Date: Tue, 14 Jan 2020 16:57:39 +0000
Message-ID: <20200114165739.GC3897@sirena.org.uk>
References: <2a4a7e11b37cfa0558d68f0d35e90d6da858b059.1579017697.git.christophe.leroy@c-s.fr>
 <b6d01fa02e659db911df63a79d825080f03dfcb8.camel@infinera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avNtfD0ffNO6L/9g"
Cc: "christophe.leroy-GgN8y9CXRhA@public.gmane.org" <christophe.leroy-GgN8y9CXRhA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Joakim Tjernlund <Joakim.Tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b6d01fa02e659db911df63a79d825080f03dfcb8.camel-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--avNtfD0ffNO6L/9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 04:26:18PM +0000, Joakim Tjernlund wrote:

> Don't you need to "undo" ioremap, irq etc. in case of later errors?

Better, convert to devm_=20

--avNtfD0ffNO6L/9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d8wIACgkQJNaLcl1U
h9DBpgf/ZMWk7TuStHKbaJC0YfEaWwp2D/yVzYAISxxSeNvL25vQlQlFJe6YGYR0
2KK5vLMxNaH1Vf6vhet00ClpsdinZt7Jx91tzaplblsKxlPbraf4tSs6USCdy5Iq
kSgUDnJvxiQSMnoTjJOkMh/ee/2LJQtVnYB+XirIqI9YWfqAZLrgm/PfqUnNq5vG
+g9nCJ3/RKsLQGb9VmbmXwMy5gVCj3u41aMoX9XDDgoayy1IZPWRIsBTIzUmmCLZ
A5OhXxnxucHDkAMXjiHE+jmgPEC1LUV+JIBydgN7Z+ryBNvTeLXDTFbnavabBb3Q
RaQCF+kEphOgL9A5QfgIkwmkUwtCtg==
=SVwD
-----END PGP SIGNATURE-----

--avNtfD0ffNO6L/9g--
