From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per
 word
Date: Mon, 1 Apr 2019 14:39:03 +0700
Message-ID: <20190401073903.GI2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:25PM -0700, Sowjanya Komatineni wrote:
> Fixes: Use packed mode for 32 bits per word transfers to increase
> performance as each packet is a full 32-bit word.

This is an optimization rather than a bug fix, ideally it should be
later in the series to make things easier to apply as fixes for Linus.

Also the way you're writing your commit logs with "Fixes: " at the start
is really weird and conflicts a bit with the Fixes: tag that the kernel
uses to reference the commit that introduces bugs.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwBYACgkQJNaLcl1U
h9DaaQf+NXROFWr5AFvVPLbpW7f/J6KJiM76ul1XdboF3IaYgAkH4A6MEfuajBp4
bCF7dZOF/CiH2b1LrwCUHBaSGTLCtHhUbdUSfUbxQgTjAaHCmygE0cAivGQ6wpzd
dpGvcKo9UGv6Ag0v9DUovyKBIl38glZeLCPylhBcaWFgDIRa1yp3Kn2NjBcaAIW6
ot8ckX9369F9gholM95+ebQo9z0nAUXpFh/0XhCzzxq2ciYKgrOJhZO96fRkss34
4oPMnJdAZu6fA1nwxqtOGvYkOejTqYBjQVF1NqKKW85PWNWvm891HjK/0ZfykZvR
B8XQySffhao0UMVkUuwYHI8H0qWcGQ==
=qRHc
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
