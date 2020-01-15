From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Wed, 15 Jan 2020 11:43:26 +0530
Message-ID: <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191230074102.50982-1-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
> 



I am finally able to get spi-mem based cadence-quaspi driver working on
TI platforms with DMA and DAC mode. I have also incorporated changes to
disable DAC and autopolling for your intel SoC:

https://github.com/r-vignesh/linux/commits/qspi

(Top two patches are of interest)

I have tested both DAC and INDAC mode with s25fl flash and everything
seems to be fine. Could you re test the driver on your SoC? Feel free to
fold it into your series if everything works.

Regards
Vignesh
