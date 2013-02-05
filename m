From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] spi: make sure all transfer has proper speed set
Date: Tue, 05 Feb 2013 13:11:22 +0000
Message-ID: <20130205131122.8C84A3E0E27@localhost>
References: <1357325235-25485-1-git-send-email-ldewangan@nvidia.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, swarren@nvidia.com,
	Laxman Dewangan <ldewangan@nvidia.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357325235-25485-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 5 Jan 2013 00:17:14 +0530, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> When spi client does the spi transfer and if it does not set
> the speed for each transfer then set it as default
> of spi device in spi core before calling low level transfer.
> 
> This will remove the extra check in low level driver for setting
> speed.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 19ee901..9676a29 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1366,12 +1366,14 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>  	}
>  
>  	/**
> -	 * Set transfer bits_per_word as spi device default if it is not
> -	 * set for this transfer.
> +	 * Set transfer bits_per_word and max speed as spi device default if
> +	 * it is not set for this transfer.
>  	 */
>  	list_for_each_entry(xfer, &message->transfers, transfer_list) {
>  		if (!xfer->bits_per_word)
>  			xfer->bits_per_word = spi->bits_per_word;
> +		if (!xfer->speed_hz)
> +			xfer->speed_hz = spi->max_speed_hz;
>  	}
>  
>  	message->spi = spi;
> -- 
> 1.7.1.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
