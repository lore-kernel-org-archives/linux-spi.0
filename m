From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: mxs: cleanup wait_for_completion return handling
Date: Thu, 5 Feb 2015 18:05:04 +0000
Message-ID: <20150205180504.GD21293@sirena.org.uk>
References: <1423147626-3525-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9rmkYYD2GSvzJKa"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423147626-3525-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/9rmkYYD2GSvzJKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 09:47:06AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch uses the return value of wait_for_completion_timeout in the condition
> directly rather than adding a additional appropriately typed variable.

Applied, thanks.

--/9rmkYYD2GSvzJKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07DQAAoJECTWi3JdVIfQV6QH/0NKVa0fKAvL33xy5e7eTogn
jt3P/Vuntn7BvFYIG4h2NYM8PhccHK7pzjcgV4UTBEnz/SuVcocoLR9ix7j6QoEo
BRyHO27gvsEM12bS/VBia3cmEb1+SxPWy2ohDk47EhDxFBsBXgokVgMspSR9m+DP
cDcP7Ua8HVSCncAyqsC52hSSkBrr4DUhNvlL6LDlrDb9ODZ0ktjAcUaUw0abvrtw
g+UNMMkgKdUEzWJvl3GcnAtaC0WcSrk5TO/Qb4xnGnghIYr0mod/ppH2YBrRGwXM
nLm9nJ/Z5mcE1HrezK+r/tQyXCGLWB5COrHfQQ57xLyd/hK5nHXrIs5R0uapMhg=
=ZH0p
-----END PGP SIGNATURE-----

--/9rmkYYD2GSvzJKa--
