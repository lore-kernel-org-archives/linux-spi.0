From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] spi: support inter-word delay requirement for
 devices
Date: Tue, 29 Jan 2019 18:06:50 +0000
Message-ID: <20190129180650.GJ10524@sirena.org.uk>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-2-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129083844.20572-2-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:38:43AM +0100, Jonas Bonn wrote:
> Some devices are slow and cannot keep up with the SPI bus and therefore
> require a short delay between words of the SPI transfer.

This doesn't apply against current code, please rebase against for-next
and resend.

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQljoACgkQJNaLcl1U
h9CoJAf+PUI9OL1C/VRVWhC7zzQ1+rRKldjD0Qb/Mkd+aUCCswh4g+ziFtSGpd68
RQYKnHjsuzl2APPcWj/tBjMgwb77pzP/1krmXsEhSNT03Npl351BVLwcYccm8Ns5
g+F8lIsTRPQFXkGkQ7Janp5HB2Kkchwi8272WsEcawsdCcmunnrEM8HHC5jk4h1r
NME9jPc5YX48bJIdWumSrWP158JQpF2clp4IokMTBawFPfvSbVvFUfAKcRt6Kb3v
8yZUPBBysCJRVcvEXOWi+ZH6IgyjLbWsEyRf60W7aO+uqYz9YaZHtHz6kn+S1Ea2
rOomMbNnVzDribZPDUVoEoGVsZjZ3Q==
=63oV
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
