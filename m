From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Thu, 7 Sep 2017 11:10:17 +0100
Message-ID: <20170907101017.mcxfnm3u4osda7xr@sirena.co.uk>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <c2faf18e6bbdac631963b22e5a4b5ee9be7f9e31.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906150446.v7qqc24wxeykcwwk@sirena.co.uk>
 <CAMz4kuL1cDD0PTBJ9-7an3KnFyhE9iZOp4VU4MCsHcx8TG5DhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajr4hkh6p2f4q2l2"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuL1cDD0PTBJ9-7an3KnFyhE9iZOp4VU4MCsHcx8TG5DhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ajr4hkh6p2f4q2l2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 11:13:00AM +0800, Baolin Wang wrote:

> >> +static int __init sprd_adi_init(void)
> >> +{
> >> +     return platform_driver_register(&sprd_adi_driver);
> >> +}
> >> +subsys_initcall(sprd_adi_init);

> > Why is this subsys_initcall() and not module_platform_driver()?

> Since ADI is one very fundamental driver for our SoC, many drivers
> such as regulator need depend on ADI, and regulator need to regulate
> core voltage as earlier as possible.

That applies to huge numbers of systems - you should still just use
regular init ordering in mainline, there are efforts to make things
better there (look at Viresh's dependency stuff) so hopefully things
will improve in the future and in the meantime the cost of probe
deferral isn't *that* great and it's less fiddly than tweaking ordering. =
=20
Practically speaking init ordering stuff can always be added in vendor
kernels in the meantime.

--ajr4hkh6p2f4q2l2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmxGwgACgkQJNaLcl1U
h9ATxQf9GJyFelS5pv6enjgBsoy33K4irFW9v2DQM1v+ieuzCGjQlyebPrSiI1gi
PM77w0tXGEBlm8yScNeW4E1CHg9fSx86Dg5X8tCW9fzal4L1AJa2GzgPpkKCwICN
hpwUNsI3ujnRt2o5I/oLMkZt7Bbt/wHe0E4NwsvY6+fWj5BrxAR3dSBhMnjgphzz
hTQeZVLz1JYNivizq8HU7qB8KjrJxeALJXN2wQ8FL2Js5rlqdiqIjZr3JpS804AR
es291/huniQEmO4CuHl3k5obQGjgJKmaFQZkaVxe4iEHyWSHUinaYMWT/6aizr55
ZZQNFrMHlLWWlyO0XkwsiZYI+M4PoQ==
=8Eox
-----END PGP SIGNATURE-----

--ajr4hkh6p2f4q2l2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
