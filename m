From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue, 14 Jun 2016 09:45:38 +0100
Message-ID: <20160614084538.GM2282@sirena.org.uk>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com>
 <20160613101352.GF2282@sirena.org.uk>
 <575F0EAD.5080608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1whYXOlSGJlk+LY"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <575F0EAD.5080608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k1whYXOlSGJlk+LY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2016 at 12:51:09PM -0700, Florian Fainelli wrote:
> On 06/13/2016 03:13 AM, Mark Brown wrote:
> >> +static const struct of_device_id bcm_qspi_of_match[] = {
> >> +	{ .compatible = "brcm,spi-bcm-qspi" },
> >> +	{ .compatible = "brcm,qspi-brcmstb" },
> >> +	{ .compatible = "brcm,spi-brcmstb-mspi"},
> >> +	{},
> >> +};
> >> +MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);

> > This is adding new DT bindings but there is no documentation,
> > documentation is required for all DT bindings.

> The binding documentation is added to patch 1, which you are listed as a
> recipient for.

So this is a perfect example of why you should use standard formats for
subject lines, if things don't look relevant they're likely to get
missed.  In this case it's both the prefix and the fact that the version
is added in a weird way.  Frankly I didn't even notice that it wasn't a
cover letter.

--k1whYXOlSGJlk+LY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXX8QtAAoJECTWi3JdVIfQ5loH/jXVC1O3+uln2+uPPrTwzU2q
ZEmENoEOtuI1dYuDwXPB2iTj+rUCxLzzSQLLcCU+x7ibLmjKQrGWv5p4/ZLgzQNh
wMf1ntayow3r985VGlnKslz7A7l4QR6IN3tX1MtmabuUldmLIW5V3BTTjJgwhESp
UnXeDZNt/nXrPj0jIr4kp4Ca6Xs17Kn44EWgQEGF8KoIhbLALAd6xDCPXrpWk5vZ
2Ny7ff0tklwUkU+5F6JMG/GTwEBl6GhOcV5l+pa2vMJhGD2mC3lh9LxJMyEnMSSA
7oemzfmbqIMleaAdUXU8hWnAL2oMyWYsXynRsmWy2eImS3U5x6E6n3b9h+gum9M=
=1tSE
-----END PGP SIGNATURE-----

--k1whYXOlSGJlk+LY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
