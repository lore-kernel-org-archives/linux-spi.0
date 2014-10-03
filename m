From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
Date: Fri, 3 Oct 2014 15:29:58 -0500
Message-ID: <1412368198.13320.434.camel@snotra.buserror.net>
References: <20141003164916.DBD631AAFA2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141003164916.DBD631AAFA2@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
> On CPM1, the SPI parameter RAM has a default location. In fsl_spi_cpm_get_pram()
> there was a confusion between the SPI_BASE register and the base of the SPI
> parameter RAM. Fortunatly, it was working properly with MPC866 and MPC885
> because they do set SPI_BASE, but on MPC860 and other old MPC8xx that doesn't
> set SPI_BASE, pram_ofs was not properly set. This patch fixes this confusion.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Changes from v1 to v2: none
> 
>  drivers/spi/spi-fsl-cpm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
> index 54b0637..0f3a912 100644
> --- a/drivers/spi/spi-fsl-cpm.c
> +++ b/drivers/spi/spi-fsl-cpm.c
> @@ -262,15 +262,14 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>  		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>  		out_be16(spi_base, pram_ofs);
>  	} else {
> -		struct spi_pram __iomem *pram = spi_base;
> -		u16 rpbase = in_be16(&pram->rpbase);
> +		u16 rpbase = in_be16(spi_base);
>  
> -		/* Microcode relocation patch applied? */
> +		/* Microcode relocation patch applied | rpbase set by default */
>  		if (rpbase) {
>  			pram_ofs = rpbase;
>  		} else {
> -			pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> -			out_be16(spi_base, pram_ofs);
> +			pram_ofs = offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
> +				   offsetof(cpm8xx_t, cp_dpmem[0]);
>  		}
>  	}

Why is PROFF_SPI not coming from the device tree?  Why don't I see any
cpm spi in any device tree nor any binding for it?

-Scott
