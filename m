From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pxa2xx: Mark expected switch fall-through
Date: Wed, 3 Oct 2018 16:22:55 +0100
Message-ID: <20181003152255.GE7132@sirena.org.uk>
References: <20181003121211.GA28108@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003121211.GA28108@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 02:12:11PM +0200, Gustavo A. R. Silva wrote:

>  			switch (drv_data->n_bytes) {
>  			case 4:
>  				bytes_left >>= 1;
> +				/* Fall through */
>  			case 2:
>  				bytes_left >>= 1;
>  			}

I think this code is just being too cute and it'd be better to just
rewrite it to directly do the expected number of shifts directly in each
case and have break statements; your fix is good but still not ideal for
readability I think.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu03s4ACgkQJNaLcl1U
h9BzTAf9GdSvoAIZoKPwAu9TkxBbtZF9kfEGoENWDZsf6o/QUHVRh6cDaCm08nO3
HAqK9wt7fN2SPSNxAXPRN2/XS020aV4Vvlbq6UvMK9zGfhjMEMtkTNTTOd9D4q0x
eHQrUGANKN0h8wPn/MISL1DxROeUmOjl5bl2sp28LJ40RadQQoHi9ICrKkXRR69k
k+8+lQOliYMTP6C68YpJcFR6uo8lslvcA0XoGazLaYZkTbH+YE+Hq5Jfneng+ZRQ
HdkOdIB7QoNB4y3hnP69D8DCZKuQUSKvmx+3lTLbqRLidDerScZy1iHJlfY3QTAl
fl+f6NHqsI20KHJ8eI5IKkC2b207oQ==
=BYK9
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
