From: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Fri, 14 Feb 2020 13:02:22 +0100
Message-ID: <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200214114618.29704-1-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.

This is v9 and still, none of the altera maintainers are on CC?
How will it be ensured that this doesn't break altera if it is merged?

Regards,
Simon

>
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
>
> Thanks a lot!!! Vignesh for the review, suggestion to optimize the patch.
> Tested with mx25u12835f on LGM platform.
>
> changes from v8:
>  -- remove the depends MTD macro
>  -- comment into C++ style
>  -- remove spaces and tabs where not applicable.
>  -- align the macro string as same as existing one.
>  -- replace QUAD to op->data.buswidth variable.
>  -- add CQSPI_NEEDS_ADDR_SWAP instead of soc_selection variable
>
> changes from v7:
>  -- remove addr_buf kept like as original
>  -- drop bus-num, chipselect variable
>  -- add soc_selection varible to differetiate the features
>  -- replace dev->ddev in dma function
>  -- add seperate function to handle the 24bit slave device address
>     translation for lgm soc
>  -- correct sentence seems incomplete in Kconfig
>  -- add cqspi->soc_selection check to keep the original TI platform
>     working code.
>
> changes from v6:
>  -- Add the Signed-off-by Vignesh in commit message
>  -- bus_num, num_chipselect added to avoid the garbage bus number
>     during the probe and spi_register.
>  -- master mode bits updated
>  -- address sequence is different from TI and Intel SoC Ip handling
>     so modified as per Intel and differentiating by use_dac_mode variable.
>  -- dummy cycles also different b/w two platforms, so keeping separate check
>  -- checkpatch errors which are intentional left as is for better readability
>
> changes from v5:
>  -- kbuild test robot warnings fixed
>  -- Add Reported-By: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> changes from v4:
>  -- kbuild test robot warnings fixed
>  -- Add Reborted-by: tag
>
> changes from v3:
> spi-cadence-quadspi.c
>  -- static to all functions wrt to local to the file.
>  -- Prefix cqspi_ and make the function static
>  -- cmd_ops, data_ops and dummy_ops dropped
>  -- addr_ops kept since it is required for address calculation.
>  -- devm_ used for supported functions , removed legacy API's
>  -- removed "indirect" name from functions
>  -- replaced by master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_OCTAL;
>     as per Vignesh susggestion
>  -- removed free functions since devm_ handles automatically.
>  -- dropped all unused Macros
>
> YAML file update:
>  -- cadence,qspi.yaml file name replace by cdns,qspi-nor.yaml
>  -- compatible string updated as per Vignesh suggestion
>  -- for single entry, removed descriptions
>  -- removed optional parameters
>   Build Result:
>    linux$ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml dt_binding_check
>     CHKDT   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>     SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>     DTC     Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
>     CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add schema for Cadence QSPI Controller driver
>   spi: cadence-quadpsi: Add support for the Cadence QSPI controller
>
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  147 ++
>  drivers/spi/Kconfig                                |    8 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-cadence-quadspi.c                  | 1508 ++++++++++++++++++++
>  4 files changed, 1664 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>  create mode 100644 drivers/spi/spi-cadence-quadspi.c
>
> --
> 2.11.0
>
