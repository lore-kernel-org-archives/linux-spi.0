From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] spi: dw-mid: avoid potential NULL dereference
Date: Fri, 6 Mar 2015 11:28:58 +0000
Message-ID: <20150306112858.GI21293@sirena.org.uk>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425320166-13788-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0IMrDVYXMQzqhO3"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425320166-13788-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/0IMrDVYXMQzqhO3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 08:15:58PM +0200, Andy Shevchenko wrote:
> When DMA descriptor allocation fails we should not try to assign any fields in
> the bad descriptor. The patch adds the necessary checks for that.

Applied, thanks.  The rest of the series all looks OK but it looks like
we should get patch 2 into stable like I said in reply to it - apply
that on fix/dw and then everything else on a merge of that and topic/dw.

--/0IMrDVYXMQzqhO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+Y95AAoJECTWi3JdVIfQsTEH/0axvqt3kwQSovXdbYftHeVi
sSO1Zsg4kPpBtApnxW8OBJ5Hh2xu3BmIATAR2sG95jExm+4SLdyp2JXvOnstodcy
Hk6SZfvPMgOEz3N76Y5ErgwrlAlWQyBpCS7m9nKLH8DqdehfoVud7ANyLjwFPwRI
o8RxWd7Z2KAVnYxLjGpuMMiRNPRPlQqfCuLmZFtd0HbDiKBTt0zfC1eWe/JWu+gM
XUVPpokH+cKSb2KfPJkb5F0kR5ducHMswkZaAF2adBHbteUnc/j/Sh466qDgmneg
gcWbWta2vctbXQDSUT/l56aAgelcUOVHwhCttL5ZTF616N2rW/4POhM6r/EMPpU=
=3yh7
-----END PGP SIGNATURE-----

--/0IMrDVYXMQzqhO3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
