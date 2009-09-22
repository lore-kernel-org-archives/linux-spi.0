From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] spi: new SPI bus lock/unlock functions
Date: Tue, 22 Sep 2009 10:15:37 -0400
Message-ID: <8bd0f97a0909220715y48fb95bclda87370eca67dfd9@mail.gmail.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
To: Yi Li <yi.li@analog.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756571AbZIVOPz@vger.kernel.org>
In-Reply-To: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 17, 2009 at 18:03, Mike Frysinger wrote:
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -653,6 +653,54 @@ static void spi_complete(void *arg)
> +int spi_lock_bus(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (spi->master->lock_bus)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return spi->master=
->lock_bus(spi);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_lock_bus);
> +
> +int spi_unlock_bus(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (spi->master->unlock_bus)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return spi->master=
->unlock_bus(spi);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_unlock_bus);

there's nothing Blackfin-specific in the implementation of these
functions.  i think the way we should be handling these is by doing:
 - remove {lock,unlock}_bus functions from spi_master
 - move the {lock,unlock}_bus code from spi_bfin5xx.c to spi.c
 - drop the SPI_BFIN_LOCK Kconfig
 - add a new spi_master flag to spi.h like SPI_MASTER_HALF_DUPLEX --
SPI_MASTER_LOCK_BUS
 - have spi_bfin5xx.c/bfin_sport_spi.c add that flag to its master setu=
p
 - have the common spi code key off of that flag to return ENOSYS
 - have the mmc_spi code check that bit in the master before falling
back to its hack
-mike
