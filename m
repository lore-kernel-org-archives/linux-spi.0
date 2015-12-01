From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Tue, 1 Dec 2015 21:04:10 +0000
Message-ID: <20151201210410.GU1929@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BV9bEMyK3jSSO1UG"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448888695-2260-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BV9bEMyK3jSSO1UG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 30, 2015 at 01:04:52PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> +static struct spi_res *__spi_res_alloc(struct spi_device *spi,
> +				       spi_res_release_t release,
> +				       size_t size,
> +				       gfp_t gfp)

This has exactly one (tiny) user.  Why is it a separate function?

> +	sres = kzalloc(tot_size, gfp);
> +	if (unlikely(!sres))
> +		return NULL;

Don't use likely() or unlikely() annotations unless the code is *really*
performance critical, just let the optimiser get on with things.  The
annotations most likely cost more time in reading the code than they'll
ever save.

--BV9bEMyK3jSSO1UG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXgtJAAoJECTWi3JdVIfQ3JQH/iMuroeakcJBJI9XhKxEyx2m
qvUd4s/u1r8ZEvm22QEFetOF9ogkqFdsU9BTc3Z0yTXauL6/U5K3azizw/W74i0w
oPX27sSs49EuNFz+TS0Ufg+rPnKgnb5hQJUqGIcWQU+6dU79FHfhB4atjO/ZDkSR
Wynumr/inYu38Ygp0vqPqqmBHcVqdwAyRf75T+B7/fAT6Ky8Y3kcMmyOZLD/ES+P
kJyG57CBKBVBrlsxJzXKBGjRtBEsmmOCWoGrfy9+jowHt3TLJ5qwY9QXJwYcXbrU
4k1sLbySH7ScEHrI83TxxiiIXCmNCYFVpDgNJmBxcX/HHOjMmH1Zx6Hy2Jrmf6E=
=JdfJ
-----END PGP SIGNATURE-----

--BV9bEMyK3jSSO1UG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
