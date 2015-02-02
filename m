From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 v3] spi: tegra20-sflash: cleanup wait_for_completion
 return handling
Date: Mon, 2 Feb 2015 11:40:11 +0000
Message-ID: <20150202114011.GJ21293@sirena.org.uk>
References: <1422870712-2710-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qj2xQFWTK7ooCBoA"
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422870712-2710-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--qj2xQFWTK7ooCBoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 04:51:52AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch adds an appropriate variable and fixes up the assignment.
> As the string in dev_err already states "timeout" there
> is little point in printing the 0 here.

This is labelled as patch 1/2 but appears to be sent as a single patch
and there's several other versions of patches for the Tegra code from
you at least some of which *do* include two patches.  Please understand
that the purpose of numbering patches with posted patch series is to
allow the patches to be sorted within that series.

This is all confusing, I'm going to ignore all of these patches.  Please
resubmit.

--qj2xQFWTK7ooCBoA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2IaAAoJECTWi3JdVIfQYBIH/2HqnkjMZMlXbtClfCDyGYu+
fKWKY6vceuO2jsg0GO5jNRHIq/xxHzXv7wyguiTqdtX5vSpt6t3jLReBmwpv8IBu
6gUMz73u0GD5kXDxzkq6O6KXi7u5MmsMAdj5SoF4I3wEanS+OL7CiOhNldvFjlwX
EHHBowc7hYbmbtxoTaIKGzobRXu4PVB2RVxDpf2iAN2G7bcnfUtkqlrfDpVL2UpE
DEmYxTz/WigflK9gPe8Cr5Ls0bTQy/F/Ff9YNCz+K0Vn6MgqK7LZUTDFnnfPqPRn
1w5JamxcBtwVzg2Qx6I1tktG5mxUViRVm24pDUtLUF2bIvM4C71lq4V0QFIvsc8=
=YVQq
-----END PGP SIGNATURE-----

--qj2xQFWTK7ooCBoA--
