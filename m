From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: of: allow instantiating slaves without a
 driver
Date: Tue, 19 Jul 2016 00:02:34 +0100
Message-ID: <20160718230234.GX30372@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GOaLjq+VdFesH+wR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GOaLjq+VdFesH+wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2016 at 12:35:41AM +0200, Michal Suchanek wrote:
> SPI slave devices are not created when looking up driver for the slave
> fails. Create a device anyway so it can be used with spidev.

>  	rc = of_modalias_node(nc, spi->modalias,
>  				sizeof(spi->modalias));
>  	if (rc < 0) {
> -		dev_err(&master->dev, "cannot find modalias for %s\n",
> +		dev_warn(&master->dev, "cannot find modalias for %s\n",

Nothing has change since you last sent this patch which converts
of_modailias_node() into something which looks up a driver so the
patch description still fails to describe what the patch is doing.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--GOaLjq+VdFesH+wR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjWAKAAoJECTWi3JdVIfQMsIH/3e67YnnHrTDnjjy+Mvya7Su
8DvMmiNSvjQ675CTEVCAByjE7zudj/kAPjfboje97gSzXL1/qLaoEiFO9ruijzOF
UpksstI4vgl8QRwBbalJyMG25uj+n/Wip4gTvCfvZFSQNzEtjsdjKdL3HgNN5rJO
DQqqCneB2Q3zDPyMYYQ9jkjgjxk6ch73uvQyufGRxnSNEuqfcGovTdOzkj68sM5O
nJXbMrnfteNaC7TdLSrWrzbZ0tlPwsukCXk3GwCa+fFXhOwO9OzoC0lW+upMaXfF
W2sDz3I1KRN3JIkkReW6V0ELYIwVYLUh2PP5ENWGOlCRTo/gorb7N3f/zvNz6aI=
=Wch4
-----END PGP SIGNATURE-----

--GOaLjq+VdFesH+wR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
