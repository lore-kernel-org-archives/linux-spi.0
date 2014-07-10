From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Use pdev->id instead of pdev->dev.id for
 the SPI bus number
Date: Thu, 10 Jul 2014 12:39:14 +0200
Message-ID: <20140710103914.GZ30458@sirena.org.uk>
References: <1404981020-22640-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V8Y3+xXnhQGsvjWT"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404981020-22640-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--V8Y3+xXnhQGsvjWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2014 at 10:30:20AM +0200, Lars-Peter Clausen wrote:
> The Xilinx SPI driver initializes the bus_num field of the SPI master to
> pdev->dev.id. pdev->dev.id is always 0 for platform devices which causes bus
> number conflicts for the SPI controller when creating multiple device instances

Applied, thanks.

--V8Y3+xXnhQGsvjWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvm1PAAoJELSic+t+oim95jkP/A/9tQnNfb3Fl5oFFI7ayzje
fHZfGl0USBlrNJWhfbKbqpXxIbcTS/+VOf/+2ZhLDKC8uOMkx0pKYw1ssXLLsfog
EJhfJz1dbwtHcR60BRCTHd0IXK8gMpXxZwaTmUygA3M9canPv0SnGFD4m90uE10c
cBH5ue2Mw2J06EQx+npwo32UE/S0lLCrxWGMRaMj54pVxT1tjT4J6UPi05mMbAbW
226Acwmi0pThsZ1zut3jm4LlNClweRDCWl7BUEfHis/7VG1rIwDyPNev7eVZAFRC
0Znq1VmPa2CyYzpWcGY7WPqdodnp3ls3Wef2d/1MKjdPIpgWJAt4eTe4bzG1eqLu
Scp2kwRPQVVlOrrEyvys28yZh6S4yqCKp2X5tIXNjdB6PSRtqDwfjBIInLQ0sExe
dtdVja4uk462HvgaKt97NTZspVIL26o62JpfiSs+z2IrviGXakYrJId4Z+SuOHqw
pFepLUa9TObANkZ7YVqJOPYqFC0vc2Mx++Vdn2xBSBDUhZLwKwJoqXfR+cwmjunM
5MnIt7vFqUHbf2tyozrG167CzIMWAt7YtzIxaVEJeAqQZDUwHrMI3CHjCBImK8vA
2aC6TRvAbAQbAWE530wKEdwfs+HLTWLwl0rzNQc2whBVddvTpbjLB6AU1hdUdxdK
Bcx6vX0lN1/1+T7et8dS
=6ZF9
-----END PGP SIGNATURE-----

--V8Y3+xXnhQGsvjWT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
