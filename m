From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: atmel: remove compat for non DT board when
 requesting dma chan
Date: Mon, 24 Nov 2014 18:57:48 +0000
Message-ID: <20141124185748.GF7712@sirena.org.uk>
References: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vnj+srGq+/SN26DJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415981574-11165-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vnj+srGq+/SN26DJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 05:12:53PM +0100, Ludovic Desroches wrote:
> All boards with a dma controller have DT support so using
> dma_request_slave_channel_compat is no more needed.

Applied both, thanks.

--vnj+srGq+/SN26DJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3+sAAoJECTWi3JdVIfQRqYH/1YCi/Mo8R8n/Sf6ftHWij9Q
a012RP5QI4xOTnf5g4CJ2nsJ6b4HPOrJzFUJqQxAS1sN4OkbvPnkROW7cQb5QPeJ
j9uG/4qQ4ax8tMuyrgRbytom6XIl9f0yA+ZipFqwIm40KC0/jbwzQmO6EAyWKG8T
TKz7eMCDf14CFJUiRY8AO2IFgatGMK7RrP1PVOFttMAkDqN7mByl80LookkP8vOx
CtdeF7mZblsMIt+txNFgwDh4MVkBftSKALDO4iOzCNM719e7JlH94q5125AKmebT
L7ZN56DVDA82rUhxbR/SXTK0MrtMM1PRFF9TyZDXLpyljunO979rMiYIte7VuWc=
=E/AC
-----END PGP SIGNATURE-----

--vnj+srGq+/SN26DJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
