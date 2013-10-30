From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 14:51:30 -0700
Message-ID: <20131030215130.GU2493@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
 <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
 <20131029225353.GB11424@sirena.org.uk>
 <F64AD25A-C7EC-4A0D-9169-850C12F4D8A3@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fxBYc4U7HLIDBZ2G"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F64AD25A-C7EC-4A0D-9169-850C12F4D8A3-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fxBYc4U7HLIDBZ2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 06:11:45PM +0100, Martin Sperl wrote:

> * schedule some "idle" DMA cycles to RX queue to wait until the clock is =
finished

I don't follow this, sorry.  What does 'schedule some "idle" DMA cycles
to RX queue' involve?  Please remember that I've never seen anything
about this specific hardware before...

> * if cs_change write 4 bytes to CS-register resetting the "transfer flags
>   also add some idle cycles so that CS does stay high for half a clock cy=
cle

If you're writing to registers doesn't that mean you need to do this
after the transfer has completed rather than having the hardware do
things autonomously (which seemed to be what you were describing)?

With the exception of these 'idle cycles' this all sounds like fairly
standard hardware with a DMA controller capable of chaining transfers
for scatter/gather.

> > You should be working against the latest development code, we're almost
> > at the merge window for v3.13, the v3.12 code is about 3 months old at
> > this point.  Also bear in mind that this is open source, you can extend
> > the frameworks if they don't do what you want.

> That is a bit more effort for me - if the RPI came with upstream code alr=
eady,
> then it would be much easier, but it does not...
> Device-tree came just before the RPI tree could get integrated, so I am l=
eft=20
> somewhat behind, because my main project relies on things that are not=20
> upstream and might take a long (RPI camera,...)

> Still I want to get these things upstream, because I hope that it will
> eventually happen...

Device tree is totally orthogonal to any of this, this is all about the
SPI core.  I can't think of anythning in the SPI core that is even
particularly dependant on advanced changes in the rest of the kernel,
you could probably just drop a new version into an old kernel with
minimal fixups for integration with the old kernel.

--fxBYc4U7HLIDBZ2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScX9fAAoJELSic+t+oim9oj0P/2Y/3kGi1W5SZ1GErgpt5pBI
nCkNet9di1odmzrv0LYeRuaBLPXqgZLbT4hFTsewor3GuHkwV+3fzrXNZtHVBIs7
4w8hIS+arP84jaGoIEkQOUWX3WUVyDmb2lueOBDqmWjZPKGISqzaEb6VdXUMNNp8
QEOq3Mya2slh4HPJZrMBvvC8ABysZyGgiXBhiERfrRY4VymOqnKVL7qvHKVZ3ygs
eporTRG+XtQryEnBDubgF/FdO8GXhQe3KXVdP1nOabhI2mM5j2eqIlAcheWpp6jo
I0bI6FWRRUs2P5LkTOSPouthcSrmY5cRm54/81eqdUDGE0fAYy/z/5htBi41Vb4T
h1azXQuYhneqctm1tl8gX6CqZgUGb54YT1pxrBjasjtTiYnk3JNVU/iNAIvilSRw
WeKlHg6iNXM+YGToLStHDrZqQLKzPLZkCjWJ5wd67+Ex2/HUq+8l9VjFMdI8U9MG
AMgl3ymjOxJYd17vdTBUicr3A0d8LLg7kgOY6rFED7zStnwGEq/FEkNjDaWaFG6H
uWxwWmbsqIMfoCSRK+QdBJ4KR+RzX1AcHIqkjRqF/UiuA2T2SVz+LZRNuFvzo8HS
quDk6y15yAAwD2jtMDPMTtsfJrRII8njfC4wu5/E0hWAVh0IhqObfq7Id2ZDQGj1
/iNnyLJey81RLm0pA79Q
=JALj
-----END PGP SIGNATURE-----

--fxBYc4U7HLIDBZ2G--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
