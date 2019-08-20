From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi for-5.4 1/5] spi: Use an abbreviated pointer to
 ctlr->cur_msg in __spi_pump_messages
Date: Tue, 20 Aug 2019 19:21:28 +0100
Message-ID: <20190820182128.GH4738@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-2-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190818182600.3047-2-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 18, 2019 at 09:25:56PM +0300, Vladimir Oltean wrote:

>  	/* Extract head of queue */
> -	ctlr->cur_msg =
> -		list_first_entry(&ctlr->queue, struct spi_message, queue);
> +	mesg = list_first_entry(&ctlr->queue, struct spi_message, queue);
> +	ctlr->cur_msg = mesg;

Why mesg when the existing code uses msg as an abbreviation here?

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cOicACgkQJNaLcl1U
h9AOqgf/cjzfm7bvt631xQj45WADd1zxrsMogZIZK1dMYJhoUv9wZeeG9HRoTiQV
KFWp5wZJG7DZpJIIOTWvJruK9Kqg1xDx6Vn78qLBPwJDq9JnFb4g/PHV3tTkHGk0
QyexBehdFr6IcovmKnA2uyp0N3fSIgzysv5CfB54NqyZMwE+9hCzxnE+N2DsKjfn
FfLRuyDINJJChwWQokpNnlTYP13mpe7UTBueTxn7ye42jBbgIkrPV2JYRZZQtZLY
QP3+0raudadXAc67mHcQgNGPB3G9TRZgt3M1QEw9sOUb7uvqQBTN6roL2X9JEeVB
LQVdcmmYX4v6Qv8O731AKmKVvnckBw==
=BmOu
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
