From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: orion: Let spi core handle validating transfer
 length
Date: Sat, 1 Mar 2014 13:52:08 +0900
Message-ID: <20140301045208.GU29849@sirena.org.uk>
References: <1393327017.6723.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BrzieSmlpF6NDzIw"
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393327017.6723.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BrzieSmlpF6NDzIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 07:16:57PM +0800, Axel Lin wrote:
> spi core will handle validating transfer length since commit 4d94bd21b333
> "spi: core: Validate length of the transfers in message".
> So remove the same checking in this driver.

Applied, thanks.

--BrzieSmlpF6NDzIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEWd1AAoJELSic+t+oim9C+AP/3Z89syZKb8uAFAYZa984C2a
p10a4vP1NQ2VroaVsWK3zIimBX4Fbn6G1xcpID+gUV0wNVP2OWVBMlksgmAvQvlQ
US8tOzISAqVGlPFCIce0+n9BQF+BxMAq+TC4tafGXsg+PJiXPwJPVgNnEQcLQ3Hl
UD3zyF4wzesFjkSWAji6vcXdmnG2JArvddgIPVQdzPdumv8qhIKQBtNIWHR5GkXI
1iGRDHtrvdEzY22j9tPmPh5WAQFJYWzifZxEanolSVk55wETsaBkx/d3Aauk3eQ0
w01yg3I18YjFOvIRWpfoxiubd6H0FtLajMM6bVVCb1awHMY0rVG3P/gnrW5ZciH9
JB2P/4Rc2Y04DCx/QuE46bD71Iu9a3CP/jz40UM2p+FAJ5CJ6q39RvBUAR77y7RR
VX+BaRigHRDsWKYiwvNeByiX8bv4U/D9pAjWbK6J1qYQ/WtHlgQSiw7g36CyKye+
mlp75OX/EgDQh99vinu33CaZu23h6shQTBuYu9JwI3BUrBQLWJCTj3rYsLyXi55d
Kxkxog+sQhQ8yko/b1m5HJxmLm0peYu8cwCKqXBid0MrrtsfMTQKwbElFBgAzgCb
CuCzS1KP7axKfBkJPWbRlYbc/RO3MiW/HFFT+iO5SDzpD43rPgvNA6VCSSOHGZKK
DRgHYkcUuYH1pT3trqqq
=nI12
-----END PGP SIGNATURE-----

--BrzieSmlpF6NDzIw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
