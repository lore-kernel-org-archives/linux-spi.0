From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mpc512x-psc: Remove redundant code to get bus_num
 from DT
Date: Tue, 18 Feb 2014 11:04:23 +0900
Message-ID: <20140218020423.GH2669@sirena.org.uk>
References: <1392518598.18192.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cKDw3XFoqocuprIa"
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392518598.18192.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cKDw3XFoqocuprIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 16, 2014 at 10:43:18AM +0800, Axel Lin wrote:
> For DT case, spi core will call of_alias_get_id() and set master->bus_num if it
> was not set.

Applied, thanks.

--cKDw3XFoqocuprIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAr+kAAoJELSic+t+oim9H/YP/2z87bU8qBZTWPL6g/In+0An
2Gz+Zd9MneZiRDDgUA8kOn32lRVL+lULE0od/h46a6XJeGOM8vwpDpmwNdgOg+45
HcpEGhD9Fo4IIgBfvS55EIQ7rAS3q/M5WTMfPUBwcp077VaykLHxGmIa16/GV6HY
F0HSfMNE8PvYeMwIlycc9kjG75ZPMWkitpE0CI1KwqtPIcWrtFVG51ZdHf1Lced8
vWHuYObcDI1b+Yj0GvOAzgnwBJYacQnCFJM3hTCcmajsHxQ2UMCYntUoxaIaTWEP
sg3+QjbzHRJVsmv/imgK3aca+Nz84vQPBFv+MPj/n9Z9NLuz9712q4bXBxZs5sy3
pT6sc3IqP2OW0UYP/+hf5FVb9mE963IVuLNUrVNjreZwDcD5OnkXj501JRCZVT10
DI/SAP468k4lg/FFaUcOckjH/iKvC9QqHSdmTapa8GrnDQJvA3cwsMVD/iRN1luX
Vf5aG9uiei6q7X9uptYS9NT/QSVS3gPUV02DySU/XZYnZNkHRKycPukLMeTQT1Kk
EfEuv8BxcEi6fN0aUhUvJ1THla1BHDBGNnH2G+VMeyTMZR0SfsBbGc9IL2nN654Y
0ZPR6uCCM5d/pWChkUa+imgZ28iNOmBxz+iL0NN8xG0hsl8ivYHENM+TgIDr87qu
hzBOivjkr0LMhhdVwWYa
=C4N3
-----END PGP SIGNATURE-----

--cKDw3XFoqocuprIa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
