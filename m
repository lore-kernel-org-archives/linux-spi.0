From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix possible ZERO_SIZE_PTR pointer dereferencing
 error.
Date: Wed, 24 Sep 2014 09:52:54 +0100
Message-ID: <20140924085254.GM4015@sirena.org.uk>
References: <1411540229-24915-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F67xnxMyVwCoXwbx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411540229-24915-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--F67xnxMyVwCoXwbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 02:30:29PM +0800, Xiubo Li wrote:
> Since we cannot make sure the 'n' will always be none zero here, and
> then if either equal to zero, the kzalloc() will return ZERO_SIZE_PTR,
> which equals to ((void *)16).

Applied, thanks.

--F67xnxMyVwCoXwbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoZmAAoJECTWi3JdVIfQZtAH+QGs2KU1RVC0mEQqFGXqs71j
tBjdUU3MepzLhZRLmL7NhLCypg0KR+U0JjZOr/1zEBdc6AfNtfqWdVgJ8DUswLof
1alBejdOq0JgYh4co5dLGgiAG2kuDRcJUsNFEuVXqkvFwFY3NKaoDlehQD592HEj
jotBNY81aRqeVoiQmURoVe4y1PFHOQSK6Kx1SNQWZkl7X3BudYLu7fhO0xvvFrKz
zxVTr9JRLTo0Q0q6xdSC2Vc+apr6rIWKYh0qmMO2UZEPp5z7ntDmQNMeEaU7jPcw
sq9+8JfoVH1BcX/jKAqHhK3zEIcs0sjzw6ZPC/+KbSMs/TYiWxa9gK804tVziuI=
=3g0j
-----END PGP SIGNATURE-----

--F67xnxMyVwCoXwbx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
