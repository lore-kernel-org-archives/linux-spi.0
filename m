From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: xlp: Add ACPI support for Vulcan SPI controller
Date: Mon, 8 Aug 2016 14:14:08 +0100
Message-ID: <20160808131408.GE10383@sirena.org.uk>
References: <1470658708-8203-1-git-send-email-kamlakant.patel@broadcom.com>
 <1470658708-8203-2-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k8ylJtLa18RSEDYA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470658708-8203-2-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k8ylJtLa18RSEDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2016 at 05:48:28PM +0530, kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org wrote:

> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "could not get spi clock\n");
> -		return -ENODEV;
> -	}
> +	if (IS_ERR(clk))
> +		return -EPROBE_DEFER;
> +

No, this is broken - if there really is a fatal error it'll silently
discard it and replace it with -EPROBE_DEFER.  This will cause things to
be incorrectly deferred if there is a real error making it harder for
people to diagnose problems.  You should just pass the error code you
get back to the caller.

--k8ylJtLa18RSEDYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqIWfAAoJECTWi3JdVIfQa6cH/RrSHoZ/k5vJ8vl4C2pfmqg6
PfuXB5RszSrDm42M4sblv0rwNGb4CyLPe/DpkaK8pscLSA4wwz9E5nB249tx25xK
W52hCrArvET+zJBeszlXWMzFyWqLSclyn6U8YggDgEOvT3pRIe3f0b0YY/1BK9UT
hGLWrBtkIH9rIP88/hWj/VkmYaS456Io4zd8PiUzStxtPYpE2kQhcoe0el+CwjwB
1n/JBZurtGA0pXNcRRyF4EVz72yiX9S8F+Vg997rTL51MJ+kDK017rTLNdSrweGS
jv83n9y5LqI6aBIS7Ik5jNdSYikRHLn9QOKmMVVJOJr1YrFn0c/ocKO2tPC2ZHo=
=6AwK
-----END PGP SIGNATURE-----

--k8ylJtLa18RSEDYA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
