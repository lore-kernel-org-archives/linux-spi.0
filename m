From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 1/5] Documentation: dt: spi-bcm-qspi: NSP, NS2,
 BRCMSTB SoC bindings
Date: Wed, 22 Jun 2016 15:51:41 +0100
Message-ID: <20160622145141.GN28202@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjavXC7V3ilNTWHC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466197433-11290-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BjavXC7V3ilNTWHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:03:49PM -0400, Kamal Dasu wrote:
> Added device tree bindings documentation for SoCs supported by the
> new spi-bcm-qspi driver.

To repeat what I said on your previous version:

| So this is a perfect example of why you should use standard formats for
| subject lines, if things don't look relevant they're likely to get
| missed.  In this case it's both the prefix and the fact that the version
| is added in a weird way.  Frankly I didn't even notice that it wasn't a
| cover letter.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.

> +- compatible:
> +    Must be one of :
> +    "brcm,spi-bcm-qspi"
> +    "brcm,spi-brmstb" spi-nor and/or "brcm,spi-brmstb-mspi" unmanaged SPI Master

What do these compatible strings mean, what are the differences between
them?  The last two sound like configuration of a single IP rather than
descriptions of hardware.

--BjavXC7V3ilNTWHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaqX8AAoJECTWi3JdVIfQJd0H/00kl8I4O5o7NuNqD8TosKFI
+8Qa5wNsFUxGIMWsYBrZWp2SaL7aDZKEGPo6rVTJL9AvfDS2x2eDMI1mEaTcK4lQ
h7zFR3PzsxpBU/q3QtjOYH7ZdCZeiOFwNK9NhmSD8tGkrpRXxbDdIuQo41T8HVGz
BHV6B7Ism86WyTGzbgkxxdMR1L6jioDTnNUlXtqGJDm1aWTRnPlagzcoq/z46uBG
2fqPU0cgotPS8v4aRqJGxJP5uRudRwLqEqwDyFryPH3/CmWwH+CVFoaf4GAjGPGC
k5Jm9WEdyKI12VmRW6/QNHHc1GmdjBLG7Z0ZDd9eyCo9h1KTczK+3sBB2c9BFrA=
=lgEq
-----END PGP SIGNATURE-----

--BjavXC7V3ilNTWHC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
