From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Mediatek: fix endian warnings
Date: Sun, 16 Aug 2015 20:30:47 -0700
Message-ID: <20150817033047.GM10748@sirena.org.uk>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
 <1871097.B3YgX5rNy0@wuerfel>
 <20150816140639.GE7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jvwwc3lboJHenLjr"
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150816140639.GE7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--jvwwc3lboJHenLjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 16, 2015 at 03:06:39PM +0100, Russell King - ARM Linux wrote:

> All writel() implementations take a CPU number and write it in little
> endian format.  Hence, writel() almost always uses cpu_to_le32()
> internally.

I think the reason this keeps coming up is that people aren't expecting
writel() to be doing endianness conversion, it's easy to get caught out
by it.

--jvwwc3lboJHenLjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0VViAAoJECTWi3JdVIfQx5QH/jLWJxe/sJWv1Wr/womw+fEJ
yssGpSdtxY8i7EL5o8PTPGPRk40C3ciLmzqCLjm8O7EmKxh1cRnNmkhaadLbE10I
xroHJM9jct4t+fnnFVlpp8vL13rP9+i3QKfdxSL1yPYpKQh3cHAB8xbJk6EDRiZY
KcrbsZ4eSpv7W2fIbfeFulMRrmx3AVNXpwRldMXFia0Cp3UUFnUNPPPPxIrq18b+
MItZdtJKEMuQl38HRvPr1rckJZ/+WTLv7Gg6xCFIq8DgOI0mbk9z2NtSWLWUDB/y
tdWVTWEjHtx7CZ1mhm7i7hV1Oa5yqsY+JhBJt3Ix6Ae+LA/0O4HLVSfPpYguJ6s=
=RpzB
-----END PGP SIGNATURE-----

--jvwwc3lboJHenLjr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
