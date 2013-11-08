From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Fri, 8 Nov 2013 16:19:57 +0000
Message-ID: <20131108161957.GP2493@sirena.org.uk>
References: <20131106094854.GF11602@sirena.org.uk>
 <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
 <20131106113219.GJ11602@sirena.org.uk>
 <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
 <20131106162410.GB2674@sirena.org.uk>
 <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
 <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MCBkylF/aX/f/TlX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <86AE15B6-05AF-4EFF-8B8F-10806A7C148B-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MCBkylF/aX/f/TlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 03:16:57PM +0100, Martin Sperl wrote:

Please fix the formatting in your mails, odd line wrapping makes things
harder to read.

> While I am more concerned about the cost of running a prepare EVERY time =
we
> schedule a message - and that becomes significant CPU utilization if you=
=20
> look at my report (doing the setup calculation for the DMA of a message,
> with 2x2 Byte (write_then_read) transfer at 8MHz takes about as long as t=
he
> actual transfer over the bus. (if more data gets transmitted the ratio=20
> changes to the transfer side)

I'd be rather surprised if there's a meaningful benefit from doing such
a transfer using DMA in the first place, with most hardware you are
better off doing small transfers with PIO and using a completion
interrupt for the transfer.  Talking to the DMA controller tends to end
up being more work than it's worth.  Are you sure that you are
optimising the right thing here?

I'd want to see strong numbers from a real use case showing that the
complexity of trying to do this was worth it.

> But waiting for the spi_pump thread to wake up is wasting valuable
> time waiting for the scheduler - especially if you could submit the
> message to DMA immediately.

This is the sort of thing we can do sensibly enough once we don't have
to open code the logic in individual controller drivers, it doesn't seem
terribly connected with any external API changes though?

--MCBkylF/aX/f/TlX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfQ8qAAoJELSic+t+oim9choP/jTePWupR3bflr2HlYoQ1PZ/
yxhrLbQ2AR5kc3EWO1ZlI8XDOYZ/b62FBdlTezjmW+8xIylcL0FdIysxpp6qRbv7
tIbogE1ebALNtYDyVZgDdtwFpyY9bz+6i78aWaeG7Iy77IqYlMFM7JkM7LTlqpsJ
3maj+SoiBODSWw1bYBtrGNInGBl3AEvOkvWm185Uu2f7gUU7yTaHnV7ncGM6q+bz
iMqb0HoA4oFl1JjjWbzychN5Or6JE3amdVN6XXyasaNHSRCdcwHD1cuVcnbg8GzF
yB3qSFgltxRomqr7J6ZkhA5RbmO2VGt+acuC7E49YdVzTyHYky2LPTSw9cnosK31
/7li2yezDeH8+F936OLFTLZ/rkC/jm/ZHj7b17x3pa54d+qxSHoRJdS8aITCU5RY
ixUM1UoTjFvObg4K2lOnRh/p8Roq6e/gM3fJyq3MC+DCn+p1IJPPO2S6LXza9FaD
Gj2PW+MflW6UsOpx8DTQ8Kt9lBEYnQI+3U7d4CCDKrCyb5IGqGM13poYY/sQvzS5
ohBnqmBz7h4CtjaokdU24wVRXuc9qJ4ajjiInD+uDTC58ylHmjEOtx7McFcV0Zoq
0uZvkBSdJF/VSlyfFmx2EeGreuJREw9DTDZCAHLDjQuTkFL4WQyBQGIhuctYQjcT
o7WyQSqyveHtjT1ya1MD
=Vc6+
-----END PGP SIGNATURE-----

--MCBkylF/aX/f/TlX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
