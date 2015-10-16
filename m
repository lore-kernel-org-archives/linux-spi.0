From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 18:45:44 +0300
Message-ID: <CAHp75VdexZWSEEM8xjYEx9WU4dbrNrXeczvBpyKcRKn-qMN=-g@mail.gmail.com>
References: <1445009343-28307-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Sekhar Nori <nsekhar@ti.com>, ssantosh@kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>, m-karicheri2@ti.com,
	"Ivan T. Ivanov" <iivanov.xz@gmail.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	hkallweit1@gmail.com
To: Franklin S Cooper Jr <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445009343-28307-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 16, 2015 at 6:29 PM, Franklin S Cooper Jr <fcooper@ti.com> wrote:
> SPI controllers may need to be properly setup before chip selects
> can be used. Therefore, wait until the spi controller has a chance
> to perform their setup procedure before trying to use the chip
> select.
>
> This also insures that the chip selects pins are in a good
> state before asseting them which otherwise may cause confusion.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Does it mean I have to test it again?

> ---
> Keystone 2 devices currently fail to boot in linux-next after the
> below commit was applied:
>
> spi: bitbang: switch to the generic implementation of transfer_one_message
> commit: 0037686596832572bbca05ab168d9884d7d704c1
>
> This patch allows Keystone 2 devices to boot again in linux-next.
>
> Tested this patch on K2E evm and am437 starterkit which both have SPI
> devices to insure regressions aren't seen.
>
> V2 Changes:
> Update commit message.
>
>  drivers/spi/spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 4c638f3..9d5525a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2059,11 +2059,11 @@ int spi_setup(struct spi_device *spi)
>         if (!spi->max_speed_hz)
>                 spi->max_speed_hz = spi->master->max_speed_hz;
>
> -       spi_set_cs(spi, false);
> -
>         if (spi->master->setup)
>                 status = spi->master->setup(spi);
>
> +       spi_set_cs(spi, false);
> +
>         dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>                         (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>                         (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> --
> 2.6.1
>



-- 
With Best Regards,
Andy Shevchenko
