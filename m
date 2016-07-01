From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 19:17:08 +0200
Message-ID: <20160701171708.GC6247@sirena.org.uk>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com>
 <20160701082101.GD6247@sirena.org.uk>
 <CAD=FV=W8gt+xgsJ5pPz1uCXGubDHkOnXoDz0mq--cDvkdf-j9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U/fatWn3w9i48dtV"
Cc: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=W8gt+xgsJ5pPz1uCXGubDHkOnXoDz0mq--cDvkdf-j9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--U/fatWn3w9i48dtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 10:05:50AM -0700, Doug Anderson wrote:

> I'm curious why you you need a timer at all.  Can't you just keep
> track of the jiffies that you last sent and do subtraction?  ...or you
> could get even more accurate and use a ktime_t.  That avoids a whole
> lot of synchronization / locking issues too...

Yeah, that'd be a lot better.

> Also: presumably you'll need to make sure that there's some margin in
> this whole thing.  I'd imagine that if the timeout is 10000
> nanoseconds and you do the calculation and you last sent 9999
> nanoseconds ago then you might decide that the other side isn't asleep
> yet.  ...but by the time the transfer starts it might be asleep...

Indeed.

--U/fatWn3w9i48dtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdqWTAAoJECTWi3JdVIfQpPcH/1RqynNoVoaPwW+/duV91Qd2
Q7QjYYWLqYiUI+5RcRjw21/gL58brlYLWwvXpexrr8IjSc4HAkkrM4UbjMFuy7H0
skrCzk6Wz/3Att+ajLr9PFELMBQBlA90tLyIqDUkKzLq8kgGyXfZeIpaIRQxLBX8
xy9GfaZnxWTxoDu2mQNkuwlXnKKlflmEpS/QNCUKmu4GtCSNv9TXbHB8E+iO1CwP
O2FyqVQwlsB+K4/46Ey6TjN/LEO9y6KbQeLXjHJZpLwF2gmm4F1hMOE04qVUj0Ze
NnR+EO5VNmTyzLBToO9ikg65BMiOWTApLla+d7brOpbW3suwnEjqz0T+xbkNxSM=
=6xhk
-----END PGP SIGNATURE-----

--U/fatWn3w9i48dtV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
