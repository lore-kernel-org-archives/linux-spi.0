From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Sun, 6 Mar 2016 22:42:06 +0100
Message-ID: <20160306214206.GW8418@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wYehVJ3WBY9OQfE8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wYehVJ3WBY9OQfE8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 01:51:51PM +0100, Michal Suchanek wrote:
> Hello,
>=20
> On 26 February 2016 at 13:25, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Feb 26, 2016 at 07:56:56AM +0200, Priit Laes wrote:
> >> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> >>
> >> This patch adds support for 64 byte or bigger transfers on the
> >> sun4i SPI controller. Said transfers will be performed via DMA.
> >>
> >> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> >> Tested-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Tested-by: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
> >> ---
> >
> > You *must* sign off any patches you are sending, please see
> > SubmittingPatches.
>=20
> I have sent these patches in the past.

Mike's point was that since it's Priit that he's submitting the
patches, he must add his SoB.

> Besides this non-technical objection there were multiple technical
> objections.
>=20
> IIRC one was that the driver does not handle the case when the DMA
> channels are not available. As I understand it the channels are
> exclusively reserved for a particular peripherial on sunxi platform so
> this ShoulNotHappen(tm). So it's probably fine for the driver to fail
> probe  when you have broken DT or no DMA engine support for sunxi
> platform.

There's a quite trivial scenario that would trigger this: if the dma
driver or dmaengine is not enabled / loaded.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--wYehVJ3WBY9OQfE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3KQuAAoJEBx+YmzsjxAg2gUQAIXU7Bea+5R5MbEA3WC95kR6
RVwwRsaCw0dgK1gIy/r9j+pgSs+NuXjmT+3uF1MTHTfizkmYNQjixhMEIymA9n12
zV7Du84CMQyyiu5d2l6KEQFEGWaXxkiqSOlU8gqDLgQbhbxWJm0Oh2FMcuYJmWFk
IpBWNZA1HAtsM1UPw16/UtZv52OtOe/xJXAAzKb7FihF6MitVBa3e+uN6o6qbw5l
V1/RwpbGWfYwMM77aQGlPW6kMera+UlziOMMjdfIAIopowQOQH2UZH6aIPvI0/52
kQRh8vczWgDRDzlZ9POHUGzBWf0WpCz6rsXx62vo1bsgz8FAnBtFmC+tZxgZp/xF
2rigUtHXCxWkumRxEnNz7IV0jMtJ05klOfL8O1Q6iSHjPLh/MjN33ejrDqtGCCPa
u3hGAZJPV7WVZYk7FCOyMjJMmE/JJ/cXV8r0JDTfXF9X6v5QlVYbsoqwBKPOGOlK
3BOP5VApF5HLRL++vUJNJOtDTyKelFp341a6IfNbKJ8EptXD7SortEpzoOBGoXbl
bcy2BqLNR0v9CXGUSnV9Kh28au+8vpDQ9/dBnxhCx/hPraRf+suNqAHcX61FKGsd
60YEZCOhvdpT89UCTM7ns1CIbFODCSRLnFMC7XOluxU+HU42vZ7AaVPGwBz9NDLt
2Rs/V2/V+jIqC/9hN7zn
=D8N+
-----END PGP SIGNATURE-----

--wYehVJ3WBY9OQfE8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
