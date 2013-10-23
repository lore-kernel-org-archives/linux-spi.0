From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: only enable the clocks when we start to
 transfer a message
Date: Wed, 23 Oct 2013 10:05:30 +0100
Message-ID: <20131023090530.GH9388@sirena.org.uk>
References: <1382517110-29913-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382517110-29913-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2013 at 04:31:50PM +0800, Huang Shijie wrote:
> Current code keeps the clocks enabled all the time, it wastes the power
> when there is no operaiton on the spi controller.

Applied, thanks.

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ5FXAAoJELSic+t+oim9JqQQAJCCQ3XD8W7aD9/muaqVwl8o
tU73LXOtb4sf3k5yJrSHyjE15etxox90nzTbPPcTZgB9p5MK6jK/PYptwKBbK3H5
aSyn09VO0ha1IVCkMw3iHugonfAA6kbdLdPx0YWHrEGbaaBmVXIpxpRk+uixsLLZ
Y5lxerHpE6vBD76FlJdn7LL1O/8CeO9g8TK4RsFHVb7UQkJX9qbVpBnBiutWV9/0
QJAB6AQtUMqRJUVHtHPKO5GIUOQP/CJO7r7dhwUluQ3Urv9dU10sfxlvhLAUo2Qf
+l1Z85T6iPJw4+O2U1yzjbTzOu1xKB5uBjX+He6pTWc6TdDuwfl3Zhd3OWFQ53Aa
B8DLHEWywMWIflIgwxMmXZVwiKnHw6yA92pBsx+sBa/RuxieYcIQ8NjP7vs/tFkm
GNtozVkPfythHSjnpWmRsBBhcWkxvKFfwoeyw/Su6mOZ2ruRUzwk0habTafqEj4D
4oHTKVkbwPx5H8WkFAV9q41Adp9HCOln+nlyPZ9uYADy1RITkXdlFPaSrEwznHBc
/hqPVq85jMJ4iYeJUrhn2d9zyNvegfxQpYD40fz0bY4uIL/qd2Sdn3lj/zG4YSoS
qaXvtulkUEh/mGafLkykjVMwKdGpDky9+4y2tL7wEG6WIppN7jVkcP9FRKQ++ufd
j4f20mQXRrMqB+ozAQEK
=oqTk
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
