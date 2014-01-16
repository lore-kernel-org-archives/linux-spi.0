From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: fix compilation warning when !CONFIG_PM_SLEEP
Date: Thu, 16 Jan 2014 14:08:06 +0000
Message-ID: <20140116140806.GF17314@sirena.org.uk>
References: <1389876655-5484-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389876655-5484-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 02:50:55PM +0200, Mika Westerberg wrote:
> CONFIG_PM will be set if either or both CONFIG_PM_SLEEP and
> CONFIG_PM_RUNTIME is set. Compiling the driver with !CONFIG_PM_SLEEP causes
> following compilation warning:

Applied, thanks.

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1+fCAAoJELSic+t+oim9PFkP/Rg3s8cEtdwsOgx/KpLHk4/W
qGmEDiOYFllaxKz3ktCX2DMYiNFMw9oNNwPJZzP2mzEvtS01LLHleDW0PbiOcwRE
wMGzwbde92of31qmX/VirC+ELYEM/llOXG6Kx2Pi3tReHdBFZ3CfaAS/0MWjoR+u
IGUmYXf40XjaLyiSTjZOzUjT5gg7HPmBN2Fgqv+I1Y+widRgkkdpgdRdKnlWsiw2
LSxAzJp4TUAFOmUuoGwCqutf4OdmaBWaEQ9Nk0DWik4Fp2M2MIC9z05deyJFBKRA
LxS9zT7VB0pfTI968SOn5caRn61Bd/IjTluTgPsZbZ5TyT0OGbwjOoK1wVMJu2WP
Kc5sdoFivhLPrvNyklQpU9DUG1weYpls+njWLGvsIp21fmRKrT9AUUYCe5DKFWuS
75vluVRAeZ8YuN141w5wB+FXwFzSn/W5arBkO63pruwod73O7MzMbrLxbjd8weOm
Wn/Zh1393FS3q7rS8Gg5shQ+bJ9lt5jlUfVJQCc8KM2AvLP1mslaSM1hbZJHiNh8
AFR1HjcqWwPZeEmIaFeYOIN+86FaofctLBR9gj8cbga/Z7t3NCU9LxirW06ud4q3
B9Rf2wxLfSX4XruU2fP+xudOmgquEtba3xFvBpu7p4K6WeieYvk+YRYuxf2gZY4Q
XI8/FCg3uKCePz3yTaLr
=eTSR
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
