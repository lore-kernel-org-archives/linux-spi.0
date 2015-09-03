From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
Date: Thu, 3 Sep 2015 13:12:32 +0100
Message-ID: <20150903121232.GW12027@sirena.org.uk>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0DzvS/R5x22MwsQI"
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
	b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440570367-22569-2-git-send-email-ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0DzvS/R5x22MwsQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:

> To support dual parallel mode operation of ZynqMP GQSPI controller
> following API's are added inside the core:

As covered in SubmittingPatches please try to make each patch a single
change rather than having multiple separate changes in one commit.

> +	/* Controller may support more than one chip.
> +	 * This flag will enable that feature.
> +	 */
> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */

This isn't saying that the controller supports more than one chip, it's
saying that the controller supports asserting more than one chip select
at once which isn't the same thing.  I'm also not entirely sure that
this makes sense as a separate feature to the data striping one - I'm
struggling to think of a way to use this sensibly separately to that.

--0DzvS/R5x22MwsQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6DkwAAoJECTWi3JdVIfQXYgH/10ooGEfIRwg3+RXxCX4cCXQ
9tZHzQ8/VXSmmnYOZk5t7sGeX4V9+KxegIv7qYfF5xo6axxM7nR5YVsytqbFmxg6
U+RGTxUM3kTvgD6xSELunChkj4/TQo2WpNxUekG06ei7KW/fTHvp/LjpfhMvm9oO
Kyz9u7CU7Jw4IqxhjFOiy+zP6lWCE2Qqh5mThX9YvxFt8q4CDZRzI/ITlOVCnT4R
Cck5fqSeRIZtaNUjZJz4f7+ZSrNt/TqoFxRmfyoEgf7XUAiw1ZmBX7NqfMbgzOEX
msplicMkoGRWtgvS2MTX4eAL22pvbnuFZOq1YKyOLc5uxboB+lgIaz8jVeVDbkU=
=fCrY
-----END PGP SIGNATURE-----

--0DzvS/R5x22MwsQI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
