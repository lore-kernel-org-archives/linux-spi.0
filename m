From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2] spi: Ensure that CS line is in non-active state
 after spi_setup()
Date: Fri, 20 Mar 2015 18:14:49 +0200
Message-ID: <1426868089.14974.12.camel@mm-sol.com>
References: <1426265029-12280-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1426265029-12280-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Fri, 2015-03-13 at 18:43 +0200, Ivan T. Ivanov wrote:
> Some devices samples state of the chip select signal during power up
> and act differently based on this state, so SPI core should ensure
> that CS line is driven in non-active state after spi_setup().
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---

Any comments on this one?

Forget to add changes since v1 [1].

CS is set to non-active state unconditionally before
spi->master->setup()

Regards,
Ivan

[1] http://www.spinics.net/lists/linux-spi/msg03056.html

>  drivers/spi/spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c64a3e5..4023cc9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1893,6 +1893,8 @@ int spi_setup(struct spi_device *spi)
>         if (!spi->max_speed_hz)
>                 spi->max_speed_hz = spi->master->max_speed_hz;
> 
> +       spi_set_cs(spi, false);
> +
>         if (spi->master->setup)
>                 status = spi->master->setup(spi);
> 
