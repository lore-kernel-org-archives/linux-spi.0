From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 5/7] spi: spi-fsl-spi: Add support for setting a
 maximum number of bits per word
Date: Tue, 9 Apr 2013 17:57:38 +0100
Message-ID: <20130409165738.GU9243@opensource.wolfsonmicro.com>
References: <1360943547-2186-1-git-send-email-andreas@gaisler.com>
 <1360943547-2186-6-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5KENZRfAmuo1v8rU"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
	Kumar Gala <galak@kernel.crashing.org>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Andreas Larsson <andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360943547-2186-6-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2013 at 04:52:25PM +0100, Andreas Larsson wrote:
> Acked-by: Anton Vorontsov <anton@enomsg.org>
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

I'll apply this on account of it being part of the series and review
having been very slow but...

>  	/* Make sure its a bit width we support [4..16, 32] */
>  	if ((bits_per_word < 4)
> -	    || ((bits_per_word > 16) && (bits_per_word != 32)))
> +	    || ((bits_per_word > 16) && (bits_per_word != 32))
> +	    || (bits_per_word > mpc8xxx_spi->max_bits_per_word))
>  		return -EINVAL;

...we do have support for this in the core now, it would be good to
convert over to that.

--5KENZRfAmuo1v8rU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZEh7AAoJELSic+t+oim9xp8P/1P/87ySvedaTieZxJ569CFX
MleQwSz1P5B566/x63jWTH64ySGfk0ErUe9sQiKX8TPExFH1uytK/G5Ih3Lq4qTJ
vSS41N9MFiBxq5NVoX6Erun4uAE9Czlbu1gXDTuzh1lYUXYySEL1WC1NfR4t5C8w
/UN/y2DvoQUHpsEVhQs0qjpecymP7BbCuGcWyPh2Rh5VKCmjN9j/fv/is9opH7u8
XdfKYdeBmJVBwiBsOpPRzdq89sawOqZlpJt+XyRW+ta+Zb6ncS5jDYx30a0qoxER
Tqhj81AUmM+uxO2qwkzvj8yfZSjIBGc1P4XlLJ/L9LfGW44m+PXHYWDsLTwojX8B
pqO9axS/jW6gwxFH5I6tfdx5fxVnf8Pw09sv8Wp82Qhxq4jlPK4o/fdV+ZoOElpT
hlznwrCDEwJ36xDbw1QpeleH/Sr5H93OVVkPkDPJHQa8qS5sEmp2/woqOuO0s0sn
96qRipoUvT6OV4higmoZjoHun3wdbOvLxn58Y1afB6j5L0jYG7OnPqSHUIgdGZwu
+zoDqubeNnSCaoRGix0b5rY492g4ZLWTEYza2BG5XV5o7wMGGHwQGwEro7ddq2ke
JAxXH4kvXYd2BdFzA//sTqRHepfMUeYtUTUKZB9IYjnU6iCsFNm/GW83DB5OraiT
HaVJHT36MZCxwnQvuwVi
=Nigq
-----END PGP SIGNATURE-----

--5KENZRfAmuo1v8rU--
