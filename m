From: Florian Fainelli <ffainelli@freebox.fr>
Subject: Re: [PATCH] fix spidev compilation when VERBOSE is defined
Date: Fri, 23 Oct 2009 09:51:22 +0200
Message-ID: <200910230951.22725.ffainelli@freebox.fr>
References: <200910061759.17327.ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, Maxime Bizon <mbizon@freebox.fr>,
	linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751607AbZJWHvX@vger.kernel.org>
In-Reply-To: <200910061759.17327.ffainelli@freebox.fr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

David,

Ping ?

On Tuesday 06 October 2009 17:59:16 Florian Fainelli wrote:
> (please CC me as I am not subscribed to spi-devel-general).
>
> When VERBOSE is defined in the spidev module, the compilation
> will throw an error on 'spi' not being defined:
>
> CC [M]  drivers/spi/spidev.o
> drivers/spi/spidev.c: In function 'spidev_message':
> drivers/spi/spidev.c:266: error: 'spi' undeclared (first use in this
> function) drivers/spi/spidev.c:266: error: (Each undeclared identifier is
> reported only once drivers/spi/spidev.c:266: error: for each function it
> appears in.)
>
> instead of using spi-> we should actually use spidev->spi.
> This patch fixes the build failure.
>
> CC: David Brownell <dbrownell@users.sourceforge.net>
> CC: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
> --
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 5d869c4..c80c31b 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -262,15 +262,15 @@ static int spidev_message(struct spidev_data *spidev,
>  		k_tmp->delay_usecs = u_tmp->delay_usecs;
>  		k_tmp->speed_hz = u_tmp->speed_hz;
>  #ifdef VERBOSE
> -		dev_dbg(&spi->dev,
> +		dev_dbg(&spidev->spi->dev,
>  			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
>  			u_tmp->len,
>  			u_tmp->rx_buf ? "rx " : "",
>  			u_tmp->tx_buf ? "tx " : "",
>  			u_tmp->cs_change ? "cs " : "",
> -			u_tmp->bits_per_word ? : spi->bits_per_word,
> +			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
>  			u_tmp->delay_usecs,
> -			u_tmp->speed_hz ? : spi->max_speed_hz);
> +			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
>  #endif
>  		spi_message_add_tail(k_tmp, &msg);
>  	}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Florian
