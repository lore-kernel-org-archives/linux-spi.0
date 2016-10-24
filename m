From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: imx: support DMA for imx35
Date: Mon, 24 Oct 2016 18:04:53 +0100
Message-ID: <20161024170453.GE17252@sirena.org.uk>
References: <1476913104-2405-1-git-send-email-martin@kaiser.cx>
 <1476916945-2744-1-git-send-email-martin@kaiser.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476916945-2744-1-git-send-email-martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 12:42:25AM +0200, Martin Kaiser wrote:
> Support DMA transfers on imx35 and compatible chipsets (imx31, imx25).
>=20
> If DMA can be used, set the start mode control (SMC) bit to start the
> SPI burst as soon as data is written into the tx fifo. Configure DMA
> requests when the fifo is half empty during tx or half full during rx.
>=20
> Signed-off-by: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
> ---
> changes since v1:
>    fix indentation

Please don't send new patches as followups for old ones, it makes it
harder to follow what's going on when things get threaded.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDj80AAoJECTWi3JdVIfQpFsH/iQ4fuoFRR00/mZH0IRJTk0O
qnH5ACzfZz7CjtNQ/4Kh6bOoD91M4nHpg6u57FaUFx6upOfMuuFHJ4LyaxRz6cBw
zKGxuYXdXX+d8WJjgAl0IE0MK6Nrju6AT7F4ImUeKPDvSLSZkS5o6KijKeCqd3nK
jnSA82jrOp9Bhw1Nz7/h+bPptg5rVWZJCy0+Bc6Q8sbK4QZmFzC8XEKPutD9uBYG
AHccv5fAlcH4bROVUfQyxehsvY4PdAxHkE5tzMHaCIKL/avdh5EEL0Sa+vEDlRN9
OVTk03UywHjHP9tJwNPriIz1EZQciWr/MGMVa1hSMFYw6RdXtNwCJiKXl8C9shU=
=YQLp
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
