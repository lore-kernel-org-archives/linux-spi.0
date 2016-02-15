From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for
 Designware SPI driver
Date: Mon, 15 Feb 2016 17:45:40 +0000
Message-ID: <20160215174540.GS18988@sirena.org.uk>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <20160205110900.GA12311@sirena.org.uk>
 <56C18C07.2030209@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xUq7mlTLx96rFlBf"
Cc: qiujiang <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	charles.chenxin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C18C07.2030209-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xUq7mlTLx96rFlBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 04:27:51PM +0800, Hanjun Guo wrote:
> On 2016/2/5 19:09, Mark Brown wrote:

> > Intel are heavy users of this driver on their systems which also use
> > ACPI.  Have you discussed this binding with them?  I've copied Andy and
> > Jarkko who've worked on the driver recently.

> There is no ACPI code in this driver yet, seems "PRP0001" is used to reuse
> this driver directly.

No, on Intel systems the devices appear on the PCI bus.

--xUq7mlTLx96rFlBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwg7DAAoJECTWi3JdVIfQQUkH/iZIyyv5aQXnMun9sqlGlfjj
m/v7EPIx4TvNK7jzU79tUvSJ5r8qR9Dvup3fRKxhMDnwH9fEI5zvP00K7M71wiLO
Tl62m398ZEaYCoPtlufXaFVY/lSzQxffxqWEbxIYGE2JiJb5loPe3p7EgoeUraFE
YQOJi/Qbk3Yz23GXEYIKOPwx4RGh9DRWLfu12yp3hAyouf+b9dFayLaRFgqGW+1s
uHiQPoIp6imPfOlDj1W6yG/31qCkg5e/QUGOTUE4HyjdoczgMQkwpaLKZLC+oE1i
YF0sAqGeNFe+1WttPoGFk40d7dLUmG52kF+KmE7TScpkdc7mW+DzLSOAqvRj2kg=
=/6qf
-----END PGP SIGNATURE-----

--xUq7mlTLx96rFlBf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
