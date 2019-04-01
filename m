From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Date: Mon, 1 Apr 2019 14:34:50 +0700
Message-ID: <20190401073450.GG2059@sirena.org.uk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 02:30:48PM +0000, Rasmus Villemoes wrote:
> I doubt patches 3 and 4 are acceptable, but I'd still like to get
> comments and/or alternative suggestions for making large transfers
> faster.

I see no problem with this from a framework point of view FWIW, it's
going to be a question of if there's any glitches like you say.  I'm not
sure how we can get wider testing/review unless the patches actually get
merged though...  I'll leave them for a bit longer but unless someone
sees a problem I'll probably go ahead and apply them.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhvxkACgkQJNaLcl1U
h9Bx5Af+Pr+rC/ITZQNvboGisfJgfLe37cO8q2ux6OZmZI5qpu2NXsA3yDk7hhQ+
4ypTq2IA0Bvr5VX0E56/45Tr6Cq5SNkRytaOyzcIXAPkqz+loW6JVn55Fu9Ht7au
wEv3BTnRKvbQjm10RU5xG9ZM5MUwSfdi3xQBMCdCBzhX338HhlEFbEuwgty3FFh/
jMXDT9BacGSZsY4avjFPeKGenqsGZcvnHVite2uDC7HWfM2M8RGgnvPReZdMpLTz
5e6VWfzF+GMu6iFermaykdGnmrpL2sbHR0WAQrzaRNRI27eehlMFSz/plt7Pz+oX
XpHu1evnNw0mwApNQ0waqvvVnxmiqA==
=VaAm
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
