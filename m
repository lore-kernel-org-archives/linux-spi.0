From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
Date: Tue, 27 Jan 2015 00:09:03 +0000
Message-ID: <20150127000903.GM21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WGHZoVWEtLLpKyPH"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422029330-10971-12-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WGHZoVWEtLLpKyPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 05:08:43PM +0100, Ricardo Ribalda Delgado wrote:

> +	switch (xspi->bits_per_word) {
> +	case 8:
> +		*(u8 *)(xspi->rx_ptr) = data;
> +		break;
> +	case 16:
> +		*(u16 *)(xspi->rx_ptr) = data;
> +		break;
> +	case 32:
>  		*(u32 *)(xspi->rx_ptr) = data;
> -		xspi->rx_ptr += 4;
> +		break;
>  	}

Perhaps I'm missing something here but we only seem to be incrementing
rx_ptr for the 32 bit case here...

> +	xspi->rx_ptr += xspi->bits_per_word/8;

...which looks to duplicate this which handles all cases.  Also there's
a coding style thing - spaces around the / please.

--WGHZoVWEtLLpKyPH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxtceAAoJECTWi3JdVIfQfvwH/Amez0zurXwIRYoOV8hzJoyg
jZ4RRfoqe1Of9yn2RGxu1NNN6a4uwAAaXaBba6OkhufGY3/nJNRzp7HpQ2e/BE0T
QjVwHfwKYNoVkjA+tL74NUzxdw7EDtfZnKshluE4TSar9zYFomAddgIl4hH2WFeL
ubvncHsKki0a43m2dXpQhMHmIKe04sCoaAX0nZwB5LTGUUkkkNOC1klN0M8nZSTW
Dtsp3ZP2kIWFhHMYMfXC3Hm6TaPLP1xBYuYv4CFoHFLIQTkMzTE+dqnrnyTMDRuw
tDtCogi9pZV1CU2/TpZw1GqXYF/FQW0U1DX9GzedmPKgn+4yKR+qjG6WQ76ftGY=
=cJT8
-----END PGP SIGNATURE-----

--WGHZoVWEtLLpKyPH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
