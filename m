From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Wed, 5 Nov 2014 10:54:52 +0000
Message-ID: <20141105105452.GS3729@sirena.org.uk>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gV1yUYniiDLxW66s"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, setka-3PjVBYxTQDg@public.gmane.org,
	tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415140617-2028-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gV1yUYniiDLxW66s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:36:56PM -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> When speed_hz is not declared in a SPI transfer, the transfer speed is
> not updated for the next read/write on /dev/spidevX.Y. The element

Why is the behaviour of spidev relevant here, if there is a problem with
spidev why is it being addressed in a specific driver?

> spi_transfer->speed_hz is filled with spi->max_speed_hz. The test of
> if (transfer->speed_hz != speed) doesn't work because the chip->speed_hz
> matches transfer->speed_hz and the clock divider is not updated.

In what way does the test "not work"?  What should the test be doing and
what is it actually doing?

> +	/* Always calculate the desired clock divider */
> +	speed = transfer->speed_hz ? transfer->speed_hz : chip->speed_hz;

Please avoid using the ternery operator standalone, write a normal if to
help people read the code.  Though in this case the core should always
ensure that there is a speed set on each transfer so I'm not clear when
this test would ever use anything other than transfer->speed_hz anyway.

--gV1yUYniiDLxW66s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWgH7AAoJECTWi3JdVIfQLUQH/3tY/TrhfwPHJik3TzFZFMKV
at23KcBocV5N7GLwiZx1p52pbZWqcgTToYSS1rB8sTdg1HXxfPHzsLUD3JsRvEEm
eB5w7rzD7ngh1/zftQUYOe0n2k7VQ9XaONnHiNtzauTzT0GRZneka68a8XwZBCWA
zaISVx18pCXZhMSumL6zyCYPxT4nlmKHWciodsu7rTasjOr0gGO4y6zXJBHQMxeQ
AbfDemSDpc7NY/LRnMq0+A8n1l2+efGX7hprQHaFtzrbExOb0bZeAKZD1jjtRjcN
9VUrjtwJtoiQdJbQwO81O5VBw/+Moq5htqx30WeL59XjeUXV+VJPGNVBQFVW8/E=
=fh2n
-----END PGP SIGNATURE-----

--gV1yUYniiDLxW66s--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
