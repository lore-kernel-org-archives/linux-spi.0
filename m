From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Possible race in spi-tegra114.ko
Date: Mon, 31 Jul 2017 12:41:05 +0200
Message-ID: <20170731104105.GF26667@ulmo>
References: <2a037d00f975d05e41fb1164711e6813@rainloop.ispras.ru>
 <81025e89755197b09309794e3e08795b@rainloop.ispras.ru>
 <1013edec2ddb1fb49a0d5503179b20d6@rainloop.ispras.ru>
 <8a2122f5efa1082943906a44af8d23cd@rainloop.ispras.ru>
 <5db42bb986f91d2a55ffdd9b5253ad7c@rainloop.ispras.ru>
 <2cf0b5d2-1b04-1380-0930-b7a28b35bf99@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        khoroshilov@ispras.ru
To: Anton Volkov <avolkov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cf0b5d2-1b04-1380-0930-b7a28b35bf99@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:30:36PM +0300, Anton Volkov wrote:
> Hello.
> While searching for races in Linux kernel I've come across
> drivers/spi/spi-tegra114.ko module. Here is the question that I came up w=
ith
> while analysing results. Lines are given using the info from Linux v4.12.
>=20
> Consider the following case:
> Thread 1:                                  Thread 2:
> tegra_spi_probe
>   -> request_threaded_irq
>       (spi-tegra114.c: line 1070)
>   ------------interrupt comes------------- tegra_spi_isr_thread
>                                              -> handle_dma_based_xfer
>                                                   ->
> tegra_spi_start_dma_based_transfer
>                                                        ->
> tegra_spi_copy_client_txbuf_to_spi_txbuf
>                                                             ->
> dma_sync_single_for_cpu(tspi->dev, tspi->tx_dma_phys, ...) (spi-tegra114.=
c:
> line 368)
>   -> tspi->tx_dma_phys =3D ...
>      (spi-tegra114.c: line 621 or 625)
>=20
> If the situation above is feasible then the value of tspi->tx_dma_phys
> (which is 0) is passed to dma_sync_single_for_cpu and further down the
> callstack. This is probably not good.
> Note that other fields of tspi structure can also be affected using the
> similar templates.
> Similar cases can occur also for tspi structure in
> drivers/spi/spi-tegra20-slink.ko module and for tsd structure in
> drivers/spi/spi-tegra20-sflash.ko module.
> So the question is: is there a possibility of interrupt triggering before
> the registration of master (spi-tegra114.c: line 1125) or a write to
> tspi->def_command1_reg (spi-tegra114.c: line 1121)?
>=20
> Thank you for your time.

I suspect that it would be possible for an interrupt to be raised if the
bootloader had left it enabled and it was pending when the bootloader
passed control to the kernel. I'm not aware of any reports of this ever
happening, but that might just mean we've only dealt with reasonably
sane bootloaders so far.

I think the easiest would probably be to move the request_threaded_irq()
call to after everything required by the interrupt handler has been
initialized.

So the correct place would probably be right before the call to
pm_runtime_enable().

Laxman, any comments?

Thierry

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll/CT4ACgkQ3SOs138+
s6HO8g/+OEQ8iCT6Noj8bSOErcoFMpcPAT1r9iDkgaljrKKthABExs3sygqhrzhJ
dAEwjDdLC2GIQawpDB6TnMgboHqwH9pvKlNdlhp3NfyK1s+f/+5UZ5i0oLK8kogj
CqIOoQvMj4mAKSG2kAtiBoEJYAG2PMWE/3r2l1Rt9MRE//5QgCWZQqFLvwFj02PH
pjTW0nGaEvdOAyYgmInQkLdY8si6s9gGoeqUwgG+fLbXe3Q5KkslLho2klQTjn+F
7A2lLngvUEEIIbd+XwRxuqzxtQ8FcGIaaBve+eYmAmI622ocaSYKVnOlWBZFoMAZ
pKV/6a9wJg2y2Cg37QhmlI9U8bWhxiJcGlMX1dMx8FX+NTf5nQeweBQU1crl+EKs
3CulPUXWyXqhuiS0U3kOOYzw/HvcIjw1dmze4O/FcIAObBeZXKQKIzqSivFCrwxM
qSESn+aKIcajToH/jUAarC6mxKCPNwYAFAkomWA3/R68yE1sETqtXKd0x7d2dEN7
hXN8Lj1jpy76kpbpIXTYLkK8sxzxvbRPNqjI64OqPZmzBUHgpq5trv+fR7Hdu5so
pHUudsfBRL+bVgotWGaEWffnVpCyTpkWyFi05d+29O7PlFY6to+kRPD9bJjZzs85
gpFcha8PbraMZfCxzia8EZVVSuDACBWHVI98ihEeLetNRRbQwg4=
=e4p+
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
