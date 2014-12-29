From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi/pxa2xx: Clear cur_chip pointer before
 starting next message
Date: Mon, 29 Dec 2014 16:06:15 +0000
Message-ID: <20141229160615.GR17800@sirena.org.uk>
References: <1419842016-208334-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eL0RuSC1De0179CY"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Martin Oldfield <m@mjoldfield.com>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419842016-208334-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eL0RuSC1De0179CY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 10:33:36AM +0200, Mika Westerberg wrote:
> Once the current message is finished, the driver notifies SPI core about
> this by calling spi_finalize_current_message(). This function queues next
> message to be transferred. If there are more messages in the queue, it is
> possible that the driver is asked to transfer the next message at this
> point.

Applied, thanks.

--eL0RuSC1De0179CY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXv2AAoJECTWi3JdVIfQp78H/R1yP9VN//Cy6KRqxEHnESgE
b/pTDVvICyoQmW+yniiGmDSUhHlEI3KQLYHz/FV72Q6EU2hQKzll2qMwPsXVlgZi
+zM27DZpssHP/oKipvqfk+i+qVbJbpWE0R1PbSB2TZXxCUxez9pHp6EiW8BSm+nu
2W50gUWSCvWICWlPqemUeuNlYF/g19C7MI7ozUHSQUCgHLcDCv7k5S5Px5VI6VAL
YisgAICkztk87GMgkU+dUVkeqAQVNJ86AgTl15Fnbam0hDHX53vLJzU3xzCRSDR3
9OgpqO7KLeEXyDyqCIIb67D7afPBpos25QoRx9GTotRl4I7XHYzm8VwWqH1hlOw=
=PiFc
-----END PGP SIGNATURE-----

--eL0RuSC1De0179CY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
