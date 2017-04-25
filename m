From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 0/5] *** SPI Slave mode support ***
Date: Tue, 25 Apr 2017 11:31:13 +0100
Message-ID: <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lyxm4mylxjgwr253"
Cc: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lyxm4mylxjgwr253
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2017 at 12:55:21PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:

> > Our use case is to use spidev as an interface to communicate with external
> > SPI master devices.
> > meanwhile the SPI bus controller can also act as master device to send data
> > to other
> > SPI slave devices on the board.

> That sounds a bit hackish to me. SPI was never meant to be a multi-master bus.
> While it can be done, you will need external synchronization (signals) to
> avoid conflicts between the SPI masters.

> > I found in your implementation, SPI bus controller is limited to either work
> > in master mode or
> > slave mode, is there any reasoning to not configure SPI mode based on SPI
> > devices use case?

> If you really need both master and slave support, you can use 2 subnodes
> in DT, the first representing the master, the second the slave.

> Mark, what's your opinion about this?

That sounds like a mess...   we *could* put the slave flag on the device
rather than the controller I guess but there's also going to need to be
something representing whatever avoids collisions on the bus somewhere.

--lyxm4mylxjgwr253
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj/JXEACgkQJNaLcl1U
h9D3xAf/atRUjYimqLCfoOcqGSAoGXE4qnLqiwKNjC1y70Yed/AsQYlmgSVHaFzR
7vDGhyqODzLdoc90Aypu9cfzVk1wc2sNRdNcN8xbGIc0inn/FoI5yIA5ZO559EdK
A1IjZRgH8OtJjnAE/qKL2u90WdTXtHPApOek7fDcCEycc7Reebvu/+DuzKamypBz
00wB22HLjkQCwcwVAn7xtlAwK4Nl/lUU38hkx4cK+aV965qNMpuu+hUGzS398Q6m
Owm5iCmr9wTz29+mEBMH65juTZ8ItFr/u3jqf1zTso84Xr8j4HvTEqAsBCHwJJDH
lkCJ3mMbyXDt7lDhyVUMvy6ybXtHwQ==
=mJ/U
-----END PGP SIGNATURE-----

--lyxm4mylxjgwr253--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
