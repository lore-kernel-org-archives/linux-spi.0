From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/4] spi: add new SPI_CS_WORD flag
Date: Sun, 16 Sep 2018 12:29:59 +0100
Message-ID: <20180916122959.271e4aba@archlinux>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-2-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
To: David Lechner <david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913003920.30600-2-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 12 Sep 2018 19:39:17 -0500
David Lechner <david@lechnology.com> wrote:

> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
> that a SPI device requires the chip select to be toggled after each
> word that is transferred.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Just a general patch ordering / combining comment.

Seems odd to introduce a flag that a driver might use in a patch
preceding any implementations!

I would have combined this with the next patch so the software fallback
would be in place when the ability to turn it on is added.

Jonathan
> ---
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d698f9db3484..7bb36145e2ba 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -163,6 +163,7 @@ struct spi_device {
>  #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> +#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;
> @@ -177,7 +178,6 @@ struct spi_device {
>  	 * the controller talks to each chip, like:
>  	 *  - memory packing (12 bit samples into low bits, others zeroed)
>  	 *  - priority
> -	 *  - drop chipselect after each word
>  	 *  - chipselect delays
>  	 *  - ...
>  	 */
