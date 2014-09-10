From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] spi: spi-imx: add DMA support
Date: Wed, 10 Sep 2014 16:52:16 +0100
Message-ID: <20140910155216.GI7960@sirena.org.uk>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <20140910102105.GR2601@sirena.org.uk>
 <20140910112258.GA30794@Robin-OptiPlex-780>
 <20140910114530.GD7960@sirena.org.uk>
 <20140910151759.GA31462@Robin-OptiPlex-780>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140910151759.GA31462@Robin-OptiPlex-780>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 11:18:01PM +0800, Robin Gong wrote:
> On Wed, Sep 10, 2014 at 12:45:30PM +0100, Mark Brown wrote:

> > > Yes, you're right. I should use "transfer->tx_sg->sgl == NULL" or
> > > "transfer->rx_sg->sgl == NULL" instead of usedma flag in driver, right?

> > Right.

> But looks spi core framework can make sure every rx or tx transfer in sequence.
> If so, can_dma will never be called until this transfer finished
> (spi_pump_messages), and my usedma flag also never be modified until next
> transfer start. Please correct me if I am wrong, thanks.

Even if that were true currently this would still not be good code since
it would break in the face of SPI core changes.  In any case the
assumption isn't true for the current SPI core, the DMA mapping is done
for all transfers in a message before we start running them and it's
entirely likely that we will have patterns like a short PIO transfer
followed by a big data block.

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEHOvAAoJECTWi3JdVIfQV9sH/Agna4stZVyvQdwq6YB+z8GN
kzgxx9olg5NLHG7I8vq77SLCGKtekh8PqLORW/dtFnYIOqFX9JyPofUXwDyP5Ng6
QqpT7RzOo6OsyF3Qd1LzVJwQszWS1rPjKMg7XMMzsDzUJOrBb+BSS5fvn9sQZuVi
Q7A4w7z47vaOYiu6OqOy3B2mVjC+WITRY/JNZW5FceR4CaH+EkzgYqc457We9xwN
y3PG/hKj8uX/R80MRKO+wqtwL/2+9PwewkEDcX7T7KDZoG9JqGtaTt+/OGjskUsf
EoTDurIHao3ROUxZj1EIz94kZ9Yfqi6V8Xh6z1cRXFq3kUXpNUlYKhmmA7edsTI=
=Y9Ey
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
