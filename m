From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: spi tree build warning
Date: Thu, 26 Nov 2009 01:35:05 +1100
Message-ID: <20091126013505.037e5751.sfr@canb.auug.org.au>
References: <20091125212959.601673f5.sfr@canb.auug.org.au>
	<fa686aa40911250630h764c4f26xb2e7cc735261e987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__26_Nov_2009_01_35_05_+1100_tbhnh57s9se/R6kc"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?UTF-8?B?IlJpY2hhcmQgUsO2amZvcnMi?=
	<richard.rojfors@mocean-labs.com>,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <fa686aa40911250630h764c4f26xb2e7cc735261e987@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Signature=_Thu__26_Nov_2009_01_35_05_+1100_tbhnh57s9se/R6kc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Wed, 25 Nov 2009 07:30:19 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> Trivial fix committed to next-spi branch:
>=20
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index b927812..9f38637 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -408,8 +408,8 @@ struct spi_master *xilinx_spi_init(struct device *dev=
, struc
>                 goto free_irq;
>         }
>=20
> -       dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=3D%d\n",
> -               (u32)mem->start, (u32)xspi->regs, xspi->irq);
> +       dev_info(dev, "at 0x%08llX mapped to 0x%p, irq=3D%d\n",
> +               (unsigned long long)mem->start, xspi->regs, xspi->irq);
>         return master;

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__26_Nov_2009_01_35_05_+1100_tbhnh57s9se/R6kc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksNQJkACgkQjjKRsyhoI8xBwgCeO+SzowWVPNo2nHEM1u6qkKIl
6fgAn0GHimYYVopCh9h954oQAW2rFygD
=MEzm
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Nov_2009_01_35_05_+1100_tbhnh57s9se/R6kc--
