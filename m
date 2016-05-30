From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
Date: Mon, 30 May 2016 12:23:50 +0100
Message-ID: <20160530112350.GI29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
 <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
 <CAOMqctS0AD6rHGt3wjxxyidee=_5xqby95t5TGuozAA12DdPjQ@mail.gmail.com>
 <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 27, 2016 at 03:10:11PM +1000, Julian Calaby wrote:
> On Fri, May 27, 2016 at 3:05 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> >> Also, should the changes for the drivers be in two separate patches also?

> > That's basically the same driver with different constants so I guess not.

> Fair enough, I withdraw my comment then.

If it's the same driver with different constants it should really
actually be the same driver - I did ask this when the drivers were
originally merged...

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTCLEAAoJECTWi3JdVIfQSz4H/RwucLquivJVkSSPBNkBGakj
Ne5QRN/akOKr5JosPlj8LOCYEr5oKa5hMtTuGH1kIZI1/nOeMb52OQopXYMcG+/O
3kUfPW4a4F5zt1F4Xj2ZwHMx/y2ZQQSQIxEoXz6u9qFzVUpQ4YRCgM0CbSSUAcWK
NzHcq5fhaMgCaxiWDpjILoQGgfdlSlp6KoMuVuQ4qxeXPmMF9UtfTEedKlJe90SG
DY6aUCIcehNfBml4S/ewLz0aK7PwKqBojxe0dhr39y1oO417LE6+HRukJYeNwqjE
QfKk3GHg0OSH6Vhd+2dt3pgN07C0Oop6hn8gl2VYYZTWjgEGkWI9zuXuwFH+SCA=
=7Xec
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
