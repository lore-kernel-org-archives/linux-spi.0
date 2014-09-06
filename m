From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Sat, 6 Sep 2014 14:57:35 +0100
Message-ID: <20140906135735.GE2601@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
 <20140904191954.GO29327@sirena.org.uk>
 <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: swingboard <swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2014 at 11:34:57AM +0800, swingboard wrote:
> 2014-09-05 3:19 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > I'm not quite sure I understand the rationale here - as far as I can
> > tell this is making the GPIO request happen later not earlier so it's
> > not clear to me what the problem this is fixing in the existing code.
> > If the goal is to move the request around in the probe function why not
> > just move the existing code earlier in probe()?

> As GPIO cs can be high or low validate and the used GPIO pin with
> default value may high or low,
> it is need do spi device's chipselect invalidation work in spi_setup,
> the patch purpose for it.
> master->cs_gpios only assigned after spi_bitbang_start and the
> function call spi_setup,
> if keep the existing code there will result gpio usage before gpio request.
> just move gpio request code in spi_sirfsoc_setup before gpio use.

I'm still having a hard time understanding why pulling the code earlier
in probe isn't a better fix here.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCxLOAAoJECTWi3JdVIfQDZgH+waWoeK6TL8kSy3zM2rBbAko
iNkZl835hAtAVUfLCFEec8+/dP258FTf8B5IHiRoV+i9y48zGTiGEGObUg1ngVkc
I7mKuT1HekyXkqVYm4EY1iqiIZScodz65XrBvGaqtDqxsVIHOYGuCv5/kaL2vHsW
loCifKWFvQwmd3odetwISOIFxx1z9cCmoCoDII6bczy+VSgCxqz9pZXuELw4cVbP
q80S9vT+MxtMXE+5LnCDrYo9onXhbbRnhzPsmZ6m/uZ2IreTFqe/dRJso9WoBs2L
VBCWx3utT/M+72dqE66cERj+D3qmbJDYPdEzQh0EN437SBUmZC5m4aq5xriD+Ek=
=PZn3
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
