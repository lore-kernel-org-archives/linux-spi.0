From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Add builtin_spi_driver() to avoid registration
 boilerplate
Date: Wed, 16 Dec 2015 17:41:44 +0000
Message-ID: <20151216174144.GN5727@sirena.org.uk>
References: <1450040037-28334-1-git-send-email-paul.gortmaker@windriver.com>
 <20151216132357.GK5727@sirena.org.uk>
 <20151216142117.GL2772@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hF9BROpwVWvPzXeD"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151216142117.GL2772@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hF9BROpwVWvPzXeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 16, 2015 at 09:21:17AM -0500, Paul Gortmaker wrote:

> Looking at the existing use case - in:

>   drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c

> it would appear that the SPI driver is embedded within another driver
> that the author decided to make non-modular.  Others that don't actually
> use the module_spi_driver macro but are also non modular are drivers/mfd
> wm831x-spi.c and stmpe-spi.c -- I'm guessing based on the above that you
> will suggest we convert those to tristate.

Well, the question you have to ask yourself is if the code really has to
be non-modular - what is the strong reason the code looks like this?
The panel embedding one driver in another seems like a bit of an
abstraction problem.

> At a more general level, if we have provided infrastructural helpers
> like module_xyz() then it seems sensible IMHO to have the parallel
> equivalent of builtin_xyz() so that we don't force non-modular code to
> require an include of <module.h> to build.

That really doesn't seem like the end of the world, and like I say if
we're not expecting sensible use cases it might even be a bad thing to
encourage people to do this.

--hF9BROpwVWvPzXeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcaJXAAoJECTWi3JdVIfQoqcH/09cqZOABlYaraVnSUuHDup7
4MbuHS1AlX0HCw+O5KCPXv2RYIgIbvqWevUiIa+BEYPOFA/v0eRzlkT0bFDxzFOP
JxXBvP74RcCVmzxLJf5mgMuLEW+t1m5vLzZjyFvzplD+Xe9rXDYWPIN0gPRJAE3x
VygsifS5daVtvjy+I9ktT85g7I9dhwWtNAAwJOVxC9NijdtAiEA7Prj1aMQ/snmq
VCyoAq1lBrHuMMtu2yLogNiGUFeE1zak+2ot/AgIQi8KiuTPcLJF1N8Rqx1ThkiI
9mPCl5ZrBVgAgwVkxz5icJbG4oFqmxjCC21/kDtyqsWx2QqTrRfjsk8AKeOr/9k=
=bfTO
-----END PGP SIGNATURE-----

--hF9BROpwVWvPzXeD--
