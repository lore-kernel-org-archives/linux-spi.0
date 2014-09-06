From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
Date: Sat, 6 Sep 2014 14:55:50 +0100
Message-ID: <20140906135550.GD2601@sirena.org.uk>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
 <20140904224132.GW29327@sirena.org.uk>
 <CAGsJ_4ysw0vy93N4evG_Aq2mMuymVXY6ig2U0EQBwQmz3uMyNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ysw0vy93N4evG_Aq2mMuymVXY6ig2U0EQBwQmz3uMyNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2014 at 04:14:17PM +0800, Barry Song wrote:

> i have no strong technical reason for this as the benefit is not
> always technical. you know....the commit log has provided the reason
> for this patch.
> the difficulty for me is maintaining the difference between mainline
> and local codes, but if we have to maintain two copies,  we can.

OK, well I think that's best though it would be better if we were able
to understand what benefit your customers believe they are seeing here
and hopefully address it in a better way.  Doing this sort of thing with
Kconfig options is not great, especially when you start trying to build
kernels that work with more than one board.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCxJlAAoJECTWi3JdVIfQXX8H/1QxEJoJkb4UlPUk7Z8CF/9A
7g6EsHPc5QTiqo08pNB5UeCC5s1rAE7qwG7SU7OMmQWh359hepwibpf0T9lnegtz
mtItoCgAPFCTwZKtvDIvGm2S48D8Oyo95vt9GG0QCK+qDGp94fBepWelsDNhejee
mlnXTamThc0MAyLF1I7dL+QYV+E203lghanj7kepNU/oLT8t9+LIU//JNq+2eM2c
z7DWpno7XvW230GABgLZuMQLTYcvlwJ5As040QEgesuZFL6bT/Ms0p93KMYwq8dM
88TbPy1G2qzorbfvMSpxQvxyaoyqoQtzDfUIlNr+KWJ0+x04AXD1GKggNoDh61s=
=sENR
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
