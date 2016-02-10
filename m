From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Bug in in spi-bcm53xx (rcu_sched) exposed by 0461a41 ("spi: Pump
 transfers inside calling context for spi_sync()")
Date: Wed, 10 Feb 2016 13:15:52 +0000
Message-ID: <20160210131552.GY13270@sirena.org.uk>
References: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q@mail.gmail.com>
 <20160210124828.GX13270@sirena.org.uk>
 <CACna6rzL-++_k68-VFQ4A9+gKHBJwhB5PJgU7wDwLQwi0vCCQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bNvn4bxlrUVLu6cT"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rzL-++_k68-VFQ4A9+gKHBJwhB5PJgU7wDwLQwi0vCCQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bNvn4bxlrUVLu6cT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 02:04:21PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 10 February 2016 at 13:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > It's most likely just hammering the CPU for a very long time without
> > scheduling due to doing a long PIO transfers.  That change just removes
> > some needless context switching.

> The fact is it happens only after flashing firmware, when flash is
> formatted for the first time. After flashing some changes from ramfs
> are likely flushed to the falsh. I guess it matches your theory of
> long time CPU hammering.

I bet you can trigger it with a heavy read load too (especially lots of
reads going on in parallel).  You'll have always been able to trigger
it, it's just that this has made it easier.

> Any idea how to handle this?

Don't busy wait in the driver, ideally implement DMA support.  Add some
sleeps if you really need to.  A PIO driver really isn't fit for purpose
with large transfers like you get on flash.

--bNvn4bxlrUVLu6cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuzgHAAoJECTWi3JdVIfQqcoH/iH+XlQulLw+8vGzc/+n90sA
+bRNeMm8MvYCpIBpTiBgtj6wFrJ9XvRLe/qK6R/h0yhiDKs/Qe7BN2cXXF7KiPIn
lu8iHmnePgQ1J7WEWOFjI02GAOSl2pVHzzrRh2bbslrzj/fEOhsKpa/nGyMc7qBc
XkUZSZpPLhP+SN4kWNg0T3k98o8BW3tA6tHfR89SO99cMJDYL/WuTkbbqwwcP3Jh
1qTLSL2FeiodfqGCqMary/+23iYTtVngWr8a1GPBMFVqAiFnYSutdJJXQZk3Z5Vg
iBpzKgkybGZSsmlRoNvyCrdZzmYWz4G/3kM8Dbw3dxRM++2Nd+i6PW/5cpLWuuo=
=w0YG
-----END PGP SIGNATURE-----

--bNvn4bxlrUVLu6cT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
