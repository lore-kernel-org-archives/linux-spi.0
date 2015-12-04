From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] spi: lm70llp: remove printk
Date: Fri, 4 Dec 2015 12:16:23 +0000
Message-ID: <20151204121623.GA26072@sirena.org.uk>
References: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1449147599-26705-6-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXAoLeOWtqbacoe/"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449147599-26705-6-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OXAoLeOWtqbacoe/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2015 at 06:29:58PM +0530, Sudip Mukherjee wrote:
> Using pr_* macros are more prefferable than using printk. Start using
> pr_* family of macros and define pr_fmt to be used with it.
> While at it remove DRVNAME from an existing pr_info() as the name is now
> being printed by pr_fmt.

> @@ -246,9 +245,7 @@ static void spi_lm70llp_attach(struct parport *p)
>  	 */
>  	status =3D spi_bitbang_start(&pp->bitbang);
>  	if (status < 0) {
> -		printk(KERN_WARNING
> -			"%s: spi_bitbang_start failed with status %d\n",
> -			DRVNAME, status);
> +		pr_warn("spi_bitbang_start failed with status %d\n", status);
>  		goto out_off_and_release;
>  	}
> =20

When we have a struct device available it's even better to use
dev_warn() and so on.

--OXAoLeOWtqbacoe/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYYQWAAoJECTWi3JdVIfQsqUH/1WyKG3P8CmenWgCuc+YoVnP
XgcY9ibUaGsWodWHZw3HWwMcvlo2mwULnQy9QcnmCg5CWxX+XgRpGbqxcxti07ns
vUeByf+auc3EB8Jq+kMQeAlGQ7eZd/FBqRxns9I0+PlKh1d36WZmEOSrlJQo30jE
5Q6DcMBQMPN1xhCRmfMrJnrr8GlCqDn6rBcuyCqQNfssblu5Eq0JD2shb0SskQKz
+DuEs4YWxl2UdPcV4eevnYknwUOQTp2yOr2qzKxdEFz5Gt/RkG14Ehu94CT8dXH/
gTYigj7l/OsFVxihyF2Y4gsikHlNLoZ4Lnhat9aP6N5cZ4B1QxFRNhu0RfGSrZA=
=K/ao
-----END PGP SIGNATURE-----

--OXAoLeOWtqbacoe/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
