From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
Date: Wed, 13 Aug 2014 15:21:29 +0200
Message-ID: <b172f93e-b2fb-4cf4-a2de-d2ca62cdb83f@BN1BFFO11FD016.protection.gbl>
References: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
 <20140813123343.GR17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fNbvqeo5JA9pRX9lqDVIsH8MJji99pmRM"
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140813123343.GR17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--fNbvqeo5JA9pRX9lqDVIsH8MJji99pmRM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/13/2014 02:33 PM, Mark Brown wrote:
> On Wed, Aug 13, 2014 at 01:52:39PM +0200, Michal Simek wrote:
>> There is no need to init .owner field.
>>
>> Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> "mmc: remove .owner field for drivers using module_platform_driver"
>>
>> This patch removes the superflous .owner field for drivers which
>> use the module_platform_driver API, as this is overriden in
>> platform_driver_register anyway."
>=20
> Would it not be better to do this as a tree wide or at least subsystem
> wide sweep with something like cocinelle?

Feel free to use cocinelle for fixing this everywhere.
For me was just easier to fix all xilinx drivers to ensure
that none else will copy it for new drivers.

Thanks,
Michal




--fNbvqeo5JA9pRX9lqDVIsH8MJji99pmRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlPrZloACgkQykllyylKDCHKaQCeMyiabih/7wXIWOat2m26XP6k
HP8An2xwKezBcfPkTlCOVt4ioO2BSpVQ
=Pyw1
-----END PGP SIGNATURE-----

--fNbvqeo5JA9pRX9lqDVIsH8MJji99pmRM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
