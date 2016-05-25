From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 19:48:54 +0100
Message-ID: <20160525184854.GF8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <20160525184421.GB10753@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iCxjWVNlaRgNFyM"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160525184421.GB10753@rob-hp-laptop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2iCxjWVNlaRgNFyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 01:44:21PM -0500, Rob Herring wrote:

> For SPI, I think we should use "label" which reflects a name that is=20
> defined by the h/w design and is meaningful to the user. Then perhaps=20
> the device becomes "/dev/spi/by-name/<label>/spidev.0" or simply=20
> "/dev/spidev-<label>.0".

I agree - this makes a lot more sense.

--2iCxjWVNlaRgNFyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRfOVAAoJECTWi3JdVIfQNvIH/0TF/eEXfSFv/VnWOtPRNFdB
bxfRNw2o9+efhLTyPLXu4k90EuM+XcOPVJ8a0wlLCMjXiWEKIOFs/hhsy0Gy38sL
D23mlYMFcNR+yYJfHbLahji1l/6wCITZa88LkwAUW3VypkLsYWRhJtBSl804Ddc/
RGakVc3qXMlQg4fp7z0924q1t5zvoXos8IIJ47F2lioC0DVz48IkrP1i0GJxLccI
ceuvnq4dRiVpwNDIFJZl7nmu1TRywcYa5dRvrRmrL660WVg+XbyMwdlSwHy5RZPi
9/c7xJcVLlBikjhVH6Dbz8OsMb2HaAieCmKUx7MFAh0QamKxVIHE731gEXe6T+w=
=mIlY
-----END PGP SIGNATURE-----

--2iCxjWVNlaRgNFyM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
