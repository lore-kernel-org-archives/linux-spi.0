From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 0/2] spi: cadence-qspi: Add cadence-qspi support for
 Intel LGM SoC
Date: Mon, 16 Sep 2019 22:20:47 +0530
Message-ID: <c4555df5-89d5-e8a6-bed4-887c23ac4f0f@ti.com>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 16/09/19 1:08 PM, Ramuthevar,Vadivel MuruganX wrote:
> patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
> patch 2: cadence-qspi controller driver to support QSPI-NAND flash
> using existing spi-nand framework with legacy spi protocol.

Nope, you cannot have two drivers for the same IP (i.e Cadence QSPI)
just to support to different types of SPI memories. This is the reason
why spi_mem_ops was introduced.

Please rewrite this driver over to use spi_mem_ops (instead of using
generic SPI xfers) so that same driver supports both SPI-NOR and
SPI-NAND flashes. Once that's done drivers/mtd/spi-nor/cadence-quadspi.c
can be deleted.

There are few existing examples of spi_mem_ops users in drivers/spi/
(git grep spi_mem_ops) and materials here on how to write such a driver:

[1]
https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
[2] https://www.youtube.com/watch?v=PkWbuLM_gmU

> 
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
>   spi: cadence-qspi: Add QSPI support for Intel LGM SoC
> 
>  .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
>  drivers/spi/Kconfig                                |   9 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-cadence-qspi-apb.c                 | 644 +++++++++++++++++++++
>  drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
>  drivers/spi/spi-cadence-qspi.c                     | 461 +++++++++++++++
>  drivers/spi/spi-cadence-qspi.h                     |  73 +++
>  7 files changed, 1446 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>  create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
>  create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
>  create mode 100644 drivers/spi/spi-cadence-qspi.c
>  create mode 100644 drivers/spi/spi-cadence-qspi.h
> 

-- 
Regards
Vignesh
