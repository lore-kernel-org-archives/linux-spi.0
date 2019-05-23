From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH V5 4/4] spi: tegra114: add support for TX and RX trimmers
Date: Wed, 22 May 2019 18:02:35 -0700
Message-ID: <20190523010235.GA105588@archlinux-epyc>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        ldewangan@nvidia.com, broonie@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sowjanya,

On Mon, May 13, 2019 at 10:03:55PM -0700, Sowjanya Komatineni wrote:
> Tegra SPI master controller has programmable trimmers to adjust the
> data with respect to the clock.
> 
> These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
> fields of COMMAND2 register.
> 
> SPI TX trimmer is to adjust the outgoing data with respect to the
> outgoing clock and SPI RX trimmer is to adjust the loopback clock with
> respect to the incoming data from the slave device.
> 
> These trimmers vary based on trace lengths of the platform design for
> each of the slaves on the SPI bus and optimal value programmed is from
> the platform validation across PVT.
> 
> This patch adds support for configuring TX and RX clock delay trimmers
> through the device tree properties.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-tegra114.c | 67 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index e59ff7c1cee6..253a7f182fc9 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c

<snip>

> +static void tegra_spi_cleanup(struct spi_device *spi)
> +{
> +	struct tegra_spi_client_data *cdata = spi->controller_data;
> +
> +	spi->controller_data = NULL;
> +	if (spi->dev.of_node)
> +		kfree(cdata);
> +}
> +

This function is not called anywhere and it is marked as static so it
triggers an unused function warning. Was that intentional?

drivers/spi/spi-tegra114.c:938:13: warning: unused function 'tegra_spi_cleanup' [-Wunused-function]
static void tegra_spi_cleanup(struct spi_device *spi)
            ^
1 warning generated.

Cheers,
Nathan
