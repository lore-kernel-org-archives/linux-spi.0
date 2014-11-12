From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/rockchip: remove redundant call to spi_master_put()
Date: Wed, 12 Nov 2014 15:04:28 +0000
Message-ID: <20141112150428.GL3815@sirena.org.uk>
References: <1415712171-20951-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWtcfo9uJO/zxEv7"
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415712171-20951-1-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JWtcfo9uJO/zxEv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 03:22:51PM +0200, Laurentiu Palcu wrote:
> The call to spi_master_put() in rockchip_spi_remove() is redundant since
> the master is registered using devm_. This patch removes it.

Applied, thanks.

--JWtcfo9uJO/zxEv7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY3b7AAoJECTWi3JdVIfQwcIH/3gB8d44Xt2tAViA6rn3AHlY
6IkmEB1rWzfKvwTnHjlBGUh3ipeV5Jht317K3U0Kphh9xmrhiwqJUOsbTY7Xiz1z
cVTdLHJ87JQ5kqdNPXZGlqykwlSR3ldIslXh9CEvZ2UKEXIO0M+eddS9UMdGEitz
5xAs2+pgw7wkHpt1C+0KUu1xSsTz016gYMnj9KJEo+xBP+U4VkwB99rnJNMH0L8t
My4PZuK0EdqBofGBmd81cvhXBg3WxEp9/2r7q0eLad++s7K5dbR+WA0ccq/wxCVi
Q8MoghM0DuvYm2wXDtEkmZCderynzepxq+qTO0lBEioIQWOUuLHmYymBfN6x8AA=
=POc4
-----END PGP SIGNATURE-----

--JWtcfo9uJO/zxEv7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
