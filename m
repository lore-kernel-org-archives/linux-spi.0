From: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 00/12] mtd: spi-nor: add xSPI Octal DTR support
Date: Fri, 13 Mar 2020 21:20:45 +0530
Message-ID: <20200313155042.qof24ulzxfiguilp@ti.com>
References: <20200313154645.29293-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200313154645.29293-1-p.yadav-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+Cc Boris. Forgot to add you when sending.

On 13/03/20 09:16PM, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for octal DTR flashes in the spi-nor framework,
> and then adds hooks for the Cypress Semper flash which is an xSPI
> compliant Octal DTR flash.
> 
> This series assumes that the flash is handed to the kernel in Legacy SPI
> mode. That is why there is no tracking of the state the flash is in.
> Ability to detect the flash mode and then run the SFDP procedure in that
> mode will be added as a follow up series.
> 
> Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.
> 
> v1 can be found at [0]. v2 can be found at [1].
> 
> [0] https://lore.kernel.org/linux-mtd/20200211133348.15558-1-p.yadav-l0cyMroinI0@public.gmane.org/
> [1] https://lore.kernel.org/linux-mtd/20200226093703.19765-1-p.yadav-l0cyMroinI0@public.gmane.org/
> 
> Changes in v3:
> - Drop the DT properties "spi-rx-dtr" and "spi-tx-dtr". Instead, if
>   later a need is felt to disable DTR in case someone has a board with
>   Octal DTR capable flash but does not support DTR transactions for some
>   reason, a property like "spi-no-dtr" can be added.
> 
> - Remove mode bits SPI_RX_DTR and SPI_TX_DTR.
> 
> - Remove the Cadence Quadspi controller patch to un-block this series. I
>   will submit it as a separate patch.
> 
> - Rebase on latest 'master' and fix merge conflicts.
> 
> - Update read and write dirmap templates to use DTR.
> 
> - Rename 'is_dtr' to 'dtr'.
> 
> - Make 'dtr' a bitfield.
> 
> - Reject DTR ops in spi_mem_default_supports_op().
> 
> - Update atmel-quadspi to reject DTR ops. All other controller drivers
>   call spi_mem_default_supports_op() so they will automatically reject
>   DTR ops.
> 
> - Add support for both enabling and disabling DTR modes.
> 
> - Perform a Software Reset on flashes that support it when shutting
>   down.
> 
> - Disable Octal DTR mode on suspend, and re-enable it on resume.
> 
> - Drop enum 'spi_mem_cmd_ext' and make command opcode u16 instead.
>   Update spi-nor to use the 2-byte command instead of the command
>   extension. Since we still need a "extension type", mode that enum to
>   spi-nor and name it 'spi_nor_cmd_ext'.
> 
> - Default variable address width to 3 to fix SMPT parsing.
> 
> - Drop non-volatile change to uniform sector mode and rely on parsing
>   SMPT.
> 
> Pratyush Yadav (12):
>   spi: spi-mem: allow specifying whether an op is DTR or not
>   spi: atmel-quadspi: reject DTR ops
>   spi: spi-mem: allow specifying a command's extension
>   mtd: spi-nor: add support for DTR protocol
>   mtd: spi-nor: default to address width of 3 for configurable widths
>   mtd: spi-nor: get command opcode extension type from BFPT
>   mtd: spi-nor: parse xSPI Profile 1.0 table
>   mtd: spi-nor: use dummy cycle and address width info from SFDP
>   mtd: spi-nor: enable octal DTR mode when possible
>   mtd: spi-nor: perform a Soft Reset on shutdown
>   mtd: spi-nor: Disable Octal DTR mode on suspend.
>   mtd: spi-nor: add support for Cypress Semper flash
> 
>  drivers/mtd/spi-nor/spi-nor.c | 692 ++++++++++++++++++++++++++++++----
>  drivers/spi/atmel-quadspi.c   |   4 +
>  drivers/spi/spi-mem.c         |   3 +
>  include/linux/mtd/spi-nor.h   |  73 +++-
>  include/linux/spi/spi-mem.h   |  13 +-
>  5 files changed, 702 insertions(+), 83 deletions(-)
> 
> --
> 2.25.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
