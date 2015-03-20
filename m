From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: Ensure that CS line is in non-active state after
 spi_setup()
Date: Fri, 20 Mar 2015 16:17:12 +0000
Message-ID: <20150320161712.GP2869@sirena.org.uk>
References: <1426265029-12280-1-git-send-email-iivanov@mm-sol.com>
 <1426868089.14974.12.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vj8lTl3Roa4E9STX"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426868089.14974.12.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Vj8lTl3Roa4E9STX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 06:14:49PM +0200, Ivan T. Ivanov wrote:

> Any comments on this one?

> Forget to add changes since v1 [1].

> CS is set to non-active state unconditionally before
> spi->master->setup()

Please don't send content free quoted pings.

--Vj8lTl3Roa4E9STX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDEgIAAoJECTWi3JdVIfQ+24H/j6VV4zMVrcwLbUWYQSJih5z
G+JmLp/SCTtbvNYgPF9AytehScb2xp0fR0a4bzBbUn+tF10vIZB+qvdDOhy4/lJF
T5EVfsKaE2i0H8oP1WnAafiO/chuS/T77M2R1Fg9eup2khFNUJ7KaHJYMBL+X2lB
E8SCrN+ko9owy+rRssrPyj6nL7KCGmosb1SR1AJ6Au1gxImawizouDbA49aFfz3N
CeR461n3EM/etogPyiNYWXkh1i/m5W+yY5hfFT9QW1sxaPdyRC20+mlGdbF1lrx0
1hKKWLPGnwK4NB/S/ICmvRTuWpGm6oLIcJtXaT+exW3GCNo7Fnj13WUSsPs9g+0=
=evbq
-----END PGP SIGNATURE-----

--Vj8lTl3Roa4E9STX--
