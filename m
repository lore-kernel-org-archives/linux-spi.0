From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Fri, 8 Nov 2013 18:09:34 +0000
Message-ID: <20131108180934.GQ2493@sirena.org.uk>
References: <20131106113219.GJ11602@sirena.org.uk>
 <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
 <20131106162410.GB2674@sirena.org.uk>
 <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
 <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H5oeNUPfJ0vte6JU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5F70E708-89B9-4DCF-A31A-E688BAA0E062-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H5oeNUPfJ0vte6JU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 06:31:37PM +0100, Martin Sperl wrote:
> On 08.11.2013, at 17:19, Mark Brown wrote:

> > I'd want to see strong numbers from a real use case showing that the
> > complexity of trying to do this was worth it.

> I remember having shared all sorts on values in my earlier posts=20
> regarding to absolute measurements.
> * from CPU utilization to receive 3000 CAN messages/s
> * to latency perspective (interrupt to SPI Message)
> * to time spent "preparing" a message.

This sounds like an artificial benchmark attempting to saturate the bus
rather than a real world use case, as does everything else you mention,
and the contributions of the individual changes aren't broken down so it
isn't clear what specifically the API change delivers.

I'd like to see both a practical use case and specific analysis showing
that changing the API is delivering a benefit as opposed to the parts
which can be done by improving the implementation of the current API.

--H5oeNUPfJ0vte6JU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfSjbAAoJELSic+t+oim9K2AP/R8ZxJOg3gbrDUaeN4f3cwHd
gM3fZ2fxF+sva7lLQtaXhOERMbf3+wi4ogd53W3NO5W6OaMHKzELAPk4kmzYXK5a
uCf7bWRIM1rM7Xz/7YS0b+zVHtFPPBydXi3c2UMcKOnKyNy2mhu5Fp6EQtAr0zXL
DriczGedFbDr6+hYdGL92yL+8UaC8heA+GXSZZNremDOaf/NhKKiqtWsErsw5Kg6
0mfnEfMJYm9ojEGLixx5fjLAg9BoCUh6AD1c3YtpaOS6fFWUdIlAsJg02bpeTnjC
KlazzWH65RgTvPvI3O/5svAY7xhLzYZMzYyVwODuaBuhdSDw8YtWNgTXWDSZetfA
dGgcwA+KUDevPPGoLGUhOcfhu2S1lr7xfCLgY8YQ96ABeZDT2wFFuEZ3jZyaLqry
qGOXIgNDqIUrkCVnG5MDcuCaf9jWRvO7H0CWFTv1wHuWvJrE2j704F158RmQwjtS
LOWgwFEKRyFhmBurQk0Z+gmza6PaYXstRi4LzIl8H9zXFO+f2aYIb76o/qO4XJ+F
4yBHtF1w88ZS+bbYEFsYN1EBRMhkCOnRAh5/C5qKnQSmrb5lA4gg6+DqtULTakBv
ITpY7brx0hwNeuT+oUpbQYYoeooq0lpxlyCobZtkgg8QfGuZA7+rdvJArrXJOMWs
PtVXzu+fmrTYsQdhvz2s
=nbyp
-----END PGP SIGNATURE-----

--H5oeNUPfJ0vte6JU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
