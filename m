From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 2/3] spi: Add spi driver for Socionext Synquacer
 platform
Date: Wed, 10 Jan 2018 10:08:11 +0000
Message-ID: <20180110100811.GA9003@sirena.org.uk>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
 <1515503448-9025-1-git-send-email-jassisinghbrar@gmail.com>
 <1515527945.25398.59.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: "jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515527945.25398.59.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 09, 2018 at 07:59:05PM +0000, Trent Piepho wrote:

> Usually when a device has a fifo that must be emptied before it
> overflows, it is either emptied from an interrupt handler or the
> interrupt handler will queue a work function or tasklet that will empty
> it.  Doing it from user context has a maximum latency that is too high.

It wouldn't be the first SPI controller that lacked interrupt support,
this is depressingly common.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpV5ggACgkQJNaLcl1U
h9AsXwf/WfMgkMYa8rvhyNICuLNn+InEZgGVNJvBV5HRwCV8gE98f0V6efON76Cw
YfX8OHYcNXZt006cPJbkjzptKzFv73zsRAt5TV3zOuPm3j02iKPSQWpLWX2hHCZH
RO+nWq1aGnYHkdq1f1Bjm/71kUSo2QRE2yJ7XLvv+GsoRhfZfF6UVeXcUigjFIq7
GF2OWUYngx09URu6zBBPwC4k/BTRq3eDMKs21d7chBCmcH3SKG8oW/lMmJaFKJTl
QmHCAM2Fg/Dha4ZXQwLrZArNgMJRR/f+xulIU/3FZssGXObtaDG+Egwtns3v4w66
O+okhpkmc2eJAoKdcPWy8ASZ93pQXw==
=xhmk
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
