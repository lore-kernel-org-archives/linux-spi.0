From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/6] spi: sun6i: restrict transfer length in PIO-mode
Date: Thu, 17 May 2018 16:09:12 +0900
Message-ID: <20180517070912.GR20254@sirena.org.uk>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-4-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MRBOAUz+O/XNC2GI"
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330125047.13936-4-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--MRBOAUz+O/XNC2GI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2018 at 03:50:44PM +0300, Sergey Suloev wrote:

> There is no need to handle 3/4 empty/full interrupts as
> the maximum supported transfer length in PIO mode is
> 128 bytes for sun6i- and 64 bytes for sun8i-family SoCs.

Surely the whole point of the 3/4 full interrupts is to allow the FIFO
to be refilled and enable longer transfers?

--MRBOAUz+O/XNC2GI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9KpcACgkQJNaLcl1U
h9BZ0wf+JI/HcuJMj+LF7KzjOoqtzCRJXO9FYEHZkH0CnNmqn+gkuQ8DQLUCwfLA
5HOAJRNGNxMcVimYvBbHcGFBHQyDV7H+off76GRudzi2SbNON8Xx+18X7zd9fOQ+
ThPZLID67VWfC144rQD3pWHHhF3tiS9p/kARvV4DhoxhUwrBAi5VbKlM7LCAJMv2
gRkX/UX5LQKpouF+sQI1005Cc0PSCOF/sEfmvQ+zly/N+1jftROzxOnbDBvQLKZM
IKoLThJuyGNUhOeZ+2IlyAydsaFGrX0PBMIc2/1YAiuG0vrmyWlpP+tzs4yOtT4n
cvuieMNyLRwpLAkCBXwz13RbVQJPRw==
=KOpR
-----END PGP SIGNATURE-----

--MRBOAUz+O/XNC2GI--
