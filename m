From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: img-spfi: Increase DMA burst size
Date: Mon, 22 Dec 2014 17:54:23 +0000
Message-ID: <20141222175423.GE17800@sirena.org.uk>
References: <1418763946-22260-1-git-send-email-abrestic@chromium.org>
 <1418763946-22260-3-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WeoCK3UN7lwjrlbw"
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418763946-22260-3-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WeoCK3UN7lwjrlbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2014 at 01:05:46PM -0800, Andrew Bresticker wrote:

> A 1-byte burst size is rather inefficient and has been shown to cause
> TX issues during testing.  Increase the DMA burst size to 4-bytes for
> both RX and TX DMA when using the 8-bit FIFO.

This sounds like a fix for transmit issues so should go before patch 2
(which seems like it is a performance improvement rather than a bug fix)
but it depends on that patch - can you respin in the opposite order
please?

--WeoCK3UN7lwjrlbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmFrOAAoJECTWi3JdVIfQffMH/3kVEvTPoUPb2IwVV+KJFduj
9KkucTRLNV2/3hoEcgIYlXZ+iZO479ytbxDFILIieEnGsSa4Gom4FMhy/Wg+77/F
0EGR7hQag7Lx5qwzy2PjOyqaagjlzmhJdu/b3C5CwmSzv2SPh7jnuLHWvYc+LDNz
PujQrhJy2IZJtmpDnOGGJ/oaALW+p4BvM4qukWGaLKlVRKiiTl8PUpOvE8WE/jFd
a1QcKXKWpwT7YqaGf7ZAQN0BqqQrmFOl2tJyvIbg18uuqwDD06kVXXPihQWI30MD
wwUUqKVLglGJPgqgdgXp09F9ifvIuIzPfu1G/oogl0nRQrBNsnXmAdNtjekU/tQ=
=B5fd
-----END PGP SIGNATURE-----

--WeoCK3UN7lwjrlbw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
