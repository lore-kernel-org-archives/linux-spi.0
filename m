From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
Date: Tue, 12 Apr 2016 07:10:07 +0100
Message-ID: <20160412061007.GY3351@sirena.org.uk>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3C3ZMpwu25Mtx3MN"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460039969-9835-1-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3C3ZMpwu25Mtx3MN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 08:09:27PM +0530, P L Sai Krishna wrote:

> + * @dummy_cycles: number of dummy cycles. If host controller requires
> + * 	dummy cycles rather than dummy bytes which send along with Cmd
> + *	and address then this dummy_cycles is used.

I'm having a very hard time parsing this, partly because it is entirely
flash specific (the whole concept of cmd and address is missing from
SPI).  As Cyrille said perhaps this should go in a flash specific
interface?

--3C3ZMpwu25Mtx3MN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDJE9AAoJECTWi3JdVIfQbdgH/i6pQrJlheEnY2+TpzqaJH9N
0gliGNtTfhiTWHRE+5bQwYR35WuWGrz21nKodsX1eTlHB9aF22Wee3zo7qRWodnp
PwJpNcpKTTG2sjzAeC25gRQ2WYNHiQzgCou7kP3yut8AvsFTqyTa/mQ1yHXNW6dW
8sc63rb9zIFoFGF5vRRBfffADUv8GCOymFKGLVL+7nuSW+zi6xZc77FAZ+dToz54
qKpEinZ4cIUYuwKY7u3V5HYRyrfB3WhnkAM8DWFTxMVo5xp6ICPv8RBmEZZd1+jH
ic74Pv1GUyckoB2mj9h9LTAoINTJVSW7adAtaZhIy3zw78oJz4tPNlvHnm0yNnE=
=Rl6x
-----END PGP SIGNATURE-----

--3C3ZMpwu25Mtx3MN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
