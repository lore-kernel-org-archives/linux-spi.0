From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Tue, 5 Jul 2016 16:49:57 +0200
Message-ID: <20160705144957.GC6247@sirena.org.uk>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KQtzXpABaZjuvfJ9"
Cc: david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, axboe-b10kYP2dOMg@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467039249-7816-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KQtzXpABaZjuvfJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:54:07AM -0500, Franklin S Cooper Jr wrote:
> Occasionally there are times you need to tweak a chained S/G list while
> maintaining the original list. This function will duplicate the passed
> in chained S/G list and return a pointer to the cloned copy.

This looks reasonable to me and there's not been any other comment over
a fairly extended period (this wasn't the first posting) so unless
someone screams I'll probably go ahead and apply this soon.

--KQtzXpABaZjuvfJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8kUAAoJECTWi3JdVIfQ/2oH/1nk0Yf5qOLLADGIOfXbij8D
jLNKHEv1IxwKXRA/ongGYewHLX7wyhNEKv/9wEeM0nd7brfbLS7DHIiLg/1nPlU/
OKrmA6rmtsw/e60ZOrUcdZQ5DRmT5QoAPzjGLTF7qFUZPJaj+sNXeQ7K9jshdUf6
GdfqcnV1GLILr8hgUISiExo2cHy41mfkbprRhDpW/B5iK+cO6/u8cU47o35SA+HF
5xTgaK6at8CAeOsyELLzVnI3AMTQ6lfzzE9wIE0CUpaJdntSRfkJvHeFD1M4tLRD
FvGUWzA4YGpno1Fa6apOFdSw/kikDx3aVDUiO4FW9iTFtWTsBW7R6bFtMbYIfT8=
=7SlC
-----END PGP SIGNATURE-----

--KQtzXpABaZjuvfJ9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
