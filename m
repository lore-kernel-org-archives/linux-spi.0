From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Enable Slave Select with GPIO Chip Select.
Date: Thu, 6 Oct 2016 11:37:55 +0200
Message-ID: <20161006093755.kv6tondkeauu5oz2@sirena.org.uk>
References: <1475703538-5018-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ae2icfuas7dz3v5v"
Cc: andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475703538-5018-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ae2icfuas7dz3v5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2016 at 04:38:58PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> This patch adds the Slave Select locally so that the transfer will
> start and complete. The GPIO CS is taken care of earlier in the SPI
> framework (spi_set_cs).

This seems like something that other devices might need - it's not the
first time I heard of a device with the data transfer start and chip
select being tied together.  Why not make this a generic feature that
the core implements and drivers can enable?

--ae2icfuas7dz3v5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9htwAAoJECTWi3JdVIfQXqUIAIOwBbezrzCG+vo1W4jvdL69
0IIZVJi/hqAWRRyA4GwQkxtk9PeJulbcwCy5/2hBOu6nlHcg4Oa2+ggQzzkCVc0E
ToIshHZ6uxEgd2zCTSj6BwhCfZIadCCAOyY4L2ZqaeA/2AKUqP4daz0cLFjxGheZ
Ndso3mqge6hBd3SO5ZFov+XMC7w0rNxrAR50PtJgXUvj27/8ckP3/lLZLj6++VFP
vcrnIY4GjcrtasvwDaQeWz0xN0mdxDoEpjXu36uyC7nWjo/625fM0hQoNdLRGcUN
vU/BpACOq3GOyVdpsm0MGebsq2vobRqv766MqS5+lFS42nA0nImXskcfeN+OUtY=
=Lmk8
-----END PGP SIGNATURE-----

--ae2icfuas7dz3v5v--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
