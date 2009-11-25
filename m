From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Allow using spi_bitbang_setup() with custom
	txrx_bufs()
Date: Wed, 25 Nov 2009 15:15:54 -0700
Message-ID: <fa686aa40911251415q624f3610n92cbc20437b12bf6@mail.gmail.com>
References: <20091125082603.25618.57438.sendpatchset@rxone.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935192AbZKYWQO@vger.kernel.org>
In-Reply-To: <20091125082603.25618.57438.sendpatchset@rxone.opensource.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 25, 2009 at 1:26 AM, Magnus Damm <magnus.damm@gmail.com> wr=
ote:
> From: Magnus Damm <damm@opensource.se>
>
> This patch modifies the shared spi bitbanging code
> to allow using spi_bitbang_setup() even though the
> txrx_word[] callbacks are unset. Useful for drivers
> that want to make use of spi_bitbang_setup() but
> have their own txrx_bufs() callback.
>
> While at it, drop the MSIOF driver workaround.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
> =A0Depends on the MSIOF driver.
>
> =A0drivers/spi/spi_bitbang.c =A0| =A0 25 ++++++++++++++-----------
> =A0drivers/spi/spi_sh_msiof.c | =A0 11 -----------
> =A02 files changed, 14 insertions(+), 22 deletions(-)
>
> --- 0001/drivers/spi/spi_bitbang.c
> +++ work/drivers/spi/spi_bitbang.c =A0 =A0 =A02009-11-25 15:30:45.000=
000000 +0900
> @@ -176,6 +176,14 @@ int spi_bitbang_setup_transfer(struct sp
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_bitbang_setup_transfer);
>
> +static int spi_bitbang_bufs(struct spi_device *spi, struct spi_trans=
fer *t)
> +{
> + =A0 =A0 =A0 struct spi_bitbang_cs =A0 *cs =3D spi->controller_state=
;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nsecs =3D cs->n=
secs;
> +
> + =A0 =A0 =A0 return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t);
> +}
> +
> =A0/**
> =A0* spi_bitbang_setup - default setup for per-word I/O loops
> =A0*/
> @@ -183,6 +191,7 @@ int spi_bitbang_setup(struct spi_device
> =A0{
> =A0 =A0 =A0 =A0struct spi_bitbang_cs =A0 *cs =3D spi->controller_stat=
e;
> =A0 =A0 =A0 =A0struct spi_bitbang =A0 =A0 =A0*bitbang;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode_mask =3D=
 SPI_CPOL | SPI_CPHA;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 flags;
>
> @@ -196,9 +205,11 @@ int spi_bitbang_setup(struct spi_device
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* per-word shift register access, in hardware or bitb=
anging */
> - =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_word[spi->mode & (SPI_C=
POL|SPI_CPHA)];
> - =A0 =A0 =A0 if (!cs->txrx_word)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (bitbang->txrx_bufs =3D=3D spi_bitbang_bufs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_word[sp=
i->mode & mode_mask];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs->txrx_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }

Hmmm... this smells like an ugly hack to me.  It seems to me that if
some bitbang backend drivers don't want this code, then it should be
encoded into a callback so it can be overridden.  Thoughts.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
