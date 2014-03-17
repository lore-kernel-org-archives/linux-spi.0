From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] spi: core: Use master->max_speed_hz as transfer
 speed when xfer->speed_hz > master->max_speed_hz
Date: Mon, 17 Mar 2014 15:46:50 +0000
Message-ID: <20140317154650.GK11706@sirena.org.uk>
References: <1395022092.30299.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395022092.30299.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2014 at 10:08:12AM +0800, Axel Lin wrote:
> When xfer->speed_hz is greater than master->max_speed_hz, it's generally safe
> to use master->max_speed_hz as transfer speed.
> Thus use master->max_speed_hz as transfer speed rather than return error when
> xfer->speed_hz > master->max_speed_hz.

Applied, thanks.

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJxjnAAoJELSic+t+oim9qOkP/28oX4QNKXAq+554o20hmtQk
2tJOBeURkUIkm7lxHZ2qnkhai9SMgo4Gf02dPf/0YPvdnuxOJtjNVxH8ZshlR38z
/OZpgYuvvzZ8h9FhEfg+XgpSRcn6LkQ8lAcHI0gZGHVhVRtGyzPsUoD2x/tA8A8u
ctMyHPdRfDBVCsC7nHcHbeMckF/9ANO/8/ieaU6rIpwWKTrcHK8CEi4mQxO3wgnx
M5/6hSMG3+nIJnRyOog/YpImrIhxGmhBut3reE3TA3adTVpDausG/v+S41neuCab
fjTKatrEzRLTnqOJ43K7hEwOxz2p9heRRVInBU5EEslNhX0Nb7JeFpkB8SASn4x/
aOu0Wb2jwQ1+EavSxGonPKE+oFEM48EUjt0m1nyGBfsoQTf0JYzyQec+Ht5InHjx
7R2sUCS1uTC/hsPaXZ8i23rS5mBRRCyPhLO9CCbwtwBmUJRkS/stFQjoFzhWypdo
K6iq3eDdXuDF9YJLsRNsnnXHKJRWRhZ7yNwr/FNuLpqVmr6KJ+pR1SSzK4RFU/JN
RfogxV1vBc8JYuThK4X8/CcWLeAUTVY6Dp+NFJ9VWT5KOPDYpPoHg+pQYXL/DEMQ
PSanf70FzkJAUsrswPJV0a5qq+eF1xIM9SrC5XbNjTpqO5ArEq98NxAUm99kc4sF
hQWfQidbwMuLFTyo3+eQ
=b+l9
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
