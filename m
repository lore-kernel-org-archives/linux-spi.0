From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Wed, 13 Apr 2016 06:59:46 +0100
Message-ID: <20160413055946.GH14664@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk>
 <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk>
 <570DD967.8010703@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570DD967.8010703-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 07:30:15AM +0200, Stefan Roese wrote:
> On 12.04.2016 21:27, Mark Brown wrote:

> >Writing something in the DT won't magically configure anything in the
> >hardware which is (as I said) the bit I'm missing.

> The MBus driver (drivers/bus/mvebu-mbus.c) takes care of the MBus
> window mapping. This is done, if the board dts files has one (or
> multiple) entries for the SPI device(s) added to the 'ranges'
> property of the 'soc' node.

I'm still unclear how mapping the windows in results in connecting the
windows to the SPI block.  It also seems like we need to document what
the meaning of the reg properties of the device is, it's all very well
saying that there's a generic MBus binding but we still need to say how
the device will interpret the MBus windows that it has (assuming they
are configured to specific hardware functions transparently).

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDeBRAAoJECTWi3JdVIfQiW8H/iGM2kwKdLW3VjgRj2Hn/+E9
yQwIEtqTDYiq5DiIF8fAXHStcSFvfDNhtI2xGnZLW6RDNWrbM8MUMckl0/PEbB4I
U9nCDhF6DEqAQODRMX+R5gl8BeM+RAw48qjmNrGwiu96+kCz4UzmoeAVvb9EWWqA
oew3F7v02sZkqVZ2anfnMT5i8vFFFv1jEf8SpoHxFids65lowaeK+3dIgxXmYsVD
TKAu9+mcIZsQgf5J4i+p+iy+er8PUQdfQptiKiE5P0SHNe9i8S3lYeSdDtmLg7bG
Sums19+dMPZ1S9oUGHTjQMqijFpzsERZ/mVGNlU7Qh9EFEpa216BakHTjX86SiM=
=6xVm
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
