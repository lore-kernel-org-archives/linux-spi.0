From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFT] spi: spi-xcomm: Fix wrong setting for SPI_XCOMM_SETTINGS_CPHA
Date: Wed, 05 Dec 2012 18:39:04 +0100
Message-ID: <50BF86B8.4020805@metafoo.de>
References: <1354602461.3286.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354602461.3286.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/04/2012 07:27 AM, Axel Lin wrote:
> The logic of setting SPI_XCOMM_SETTINGS_CPHA bit is reversed.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Lars,
> The logic of setting SPI_XCOMM_SETTINGS_CPHA bit looks wrong to me.
> Can you check if this patch works?
> 
> Thanks,
> Axel

Hi Axel,

Thanks for the patch. But the code is correct as it is. The CPHA definition
of the chip is inverted to that of Linux.

Thanks,
- Lars


> 
>  drivers/spi/spi-xcomm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
> index 266a847..c2a3e8f 100644
> --- a/drivers/spi/spi-xcomm.c
> +++ b/drivers/spi/spi-xcomm.c
> @@ -99,9 +99,9 @@ static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
>  		*settings &= ~SPI_XCOMM_SETTINGS_CPOL;
>  
>  	if (spi->mode & SPI_CPHA)
> -		*settings &= ~SPI_XCOMM_SETTINGS_CPHA;
> -	else
>  		*settings |= SPI_XCOMM_SETTINGS_CPHA;
> +	else
> +		*settings &= ~SPI_XCOMM_SETTINGS_CPHA;
>  
>  	if (spi->mode & SPI_3WIRE)
>  		*settings |= SPI_XCOMM_SETTINGS_3WIRE;
