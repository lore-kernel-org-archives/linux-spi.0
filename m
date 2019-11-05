From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Tue, 5 Nov 2019 10:00:40 +0530
Message-ID: <b553b1e8-1c35-fd7c-6855-75a4c1c943fe@ti.com>
References: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 30/10/19 1:41 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 

The new driver being added in patch 2/2 is supposed to replace
drivers/mtd/spi-nor/cadence-quadspi.c. Therefore the bindings should be
exactly same as
Documentation/devicetree/bindings/mtd/cadence-quadspi.txt. Otherwise, it
breaks DT backward compatibility. There cannot be two different sets of
bindings for same HW IP.

Therefore please rewrite yaml schema to match existing bindings at
Documentation/devicetree/bindings/mtd/cadence-quadspi.txt.
And then include a patch dropping older bindings.


> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence,qspi.yaml      | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> new file mode 100644
> index 000000000000..295501f01e5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence QSPI Flash Controller support
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  Add support for the Cadence QSPI controller,This controller is
> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
> +  has been tested On Intel's LGM SoC.
> +
> +properties:
> +  compatible:
> +    const: cadence,qspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clocks-names:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +examples:
> +  - |
> +    spi@ec000000 {
> +          compatible = "cadence,qspi";
> +          reg = <0xec000000 0x100>;
> +          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
> +          clock-names = "qspi";
> +          resets = <&rcu0 0x10 1>;
> +          reset-names = "qspi";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash: flash@1 {
> +              compatible = "spi-nand", "jedec, spi-nor";

s/"jedec, spi-nor"/"jedec,spi-nor" (i.e no space after comma)

> +              reg = <1>;
> +              spi-max-frequency = <10000000>;
> +          };
> +    };
> +
> 

-- 
Regards
Vignesh
