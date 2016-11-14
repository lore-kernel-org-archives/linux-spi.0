From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/10] spi: fsl-espi: remove remaining usage of struct
 fsl_spi_platform_data
Date: Mon, 14 Nov 2016 10:35:35 +0000
Message-ID: <20161114103535.rz5pe4ul3esplvji@sirena.org.uk>
References: <882d05f1-a963-c03a-38ae-2dd701f561a6@gmail.com>
 <46d0ab77-d645-1db3-cca4-99b1b04d599c@gmail.com>
 <75bd88e0-e1bf-9729-6cd0-e88633d940e6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yij3dtmigczana7z"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <75bd88e0-e1bf-9729-6cd0-e88633d940e6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yij3dtmigczana7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 13, 2016 at 02:36:39PM +0100, Heiner Kallweit wrote:
> Use master->num_chipselect directly instead of pdata->max_chipselect.
> In this context let of_fsl_espi_get_chipselects return max_chipselect.

Something is screwed up with the way you're sending these - none of this
series is threaded together except this which is threaded with patch 1.
Generally it's best to use git send-email to send patches, it will get
things right with little effort on your part.

--yij3dtmigczana7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKZN2AAoJECTWi3JdVIfQRKQH/12RUTC2DbR0z01eytgKUJ1j
L7MRwwyi8lMw5Fa4UzvHuT5QOMrzMfYRpDzPLtwfhgHvMQBqhDaDqsINqzsda7UH
TD8qaHM/sBjm0+f6jh4KI961IaWGNwXj0oDX/dk+IvP72GJU1nubEM2bjDxqjwuG
j/ov2TZgpEdETAebk98XlJ21UJL2myE70nntU3MMLPi8fgq7TV511AqcjmtNC4lZ
+rObxetINTCW6B532EQDr3Ga9j360gUXcCIpChVcUxRj/ILZ7bdMg3xj5YXxmECP
208Vk+rtUFLvYpKz5Pl21YzbtK2iAJpMVKdsy6cglghiI1SG/G8IP/c0L38+iA4=
=NlLL
-----END PGP SIGNATURE-----

--yij3dtmigczana7z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
