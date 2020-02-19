From: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] Add dt-bindings for Cadence XSPI controller
Date: Wed, 19 Feb 2020 12:30:29 +0100
Message-ID: <20200219113028.GA3092@global.cadence.com>
References: <20200128124313.12837-1-konrad@cadence.com>
 <20200205183114.GA23752@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200205183114.GA23752@bogus>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The 02/05/2020 18:31, Rob Herring wrote:
>EXTERNAL MAIL
>
>
>On Tue, Jan 28, 2020 at 01:43:04PM +0100, Konrad Kociolek wrote:
>> Add dt-bindings documentation for Cadence XSPI controller to support
>> SPI based flash memories.
>>
>> Signed-off-by: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
>> ---
>> Changes between initial version and v2:
>>   - renamed yaml file
>>   - added missing include
>>
>>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 +++++++++++++++++++++
>>  1 file changed, 166 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>> new file mode 100644
>> index 000000000000..e8c43957fd90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>> @@ -0,0 +1,166 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
>
>Dual license new bindings:
>
>(GPL-2.0-only OR BSD-2-Clause)
>
>> +# Copyright 2020 Cadence
>> +%YAML 1.2
>> +---
>> +$id: "https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_schemas_spi_cdns-2Cxspi.yaml-23&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=G7iI7AW4JEOXbx13Fe5B7uVPtTH6HSiaA_R5uR2HQjY&m=vgq1v6AC47kHEnD4BGadbiavRIW3wUjNWfh5fCNtivI&s=5GznvYUXU7Lk0eHcHCnJAsz0aKwZmZqEsGGo5A9i2l8&e= "
>> +$schema: "https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_meta-2Dschemas_core.yaml-23&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=G7iI7AW4JEOXbx13Fe5B7uVPtTH6HSiaA_R5uR2HQjY&m=vgq1v6AC47kHEnD4BGadbiavRIW3wUjNWfh5fCNtivI&s=pm5-krCiP_J-P48RO4mlub5ARy9eGOBfV59k8d02Q4g&e= "
>> +
>> +title: Cadence XSPI Controller
>> +
>> +maintainers:
>> +  - Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
>> +
>> +description: |
>> +  The XSPI controller allows SPI protocol communication in
>> +  single, dual, quad or octal wire transmission modes for
>> +  read/write access to slaves such as SPI-NOR flash.
>> +
>
>Needs a ref to spi-controller.yaml
>
>> +properties:
>> +  compatible:
>> +    const: cdns,xspi-nor-fpga
>> +
>> +  reg:
>> +    maxItems: 3
>> +    description: |
>> +      Contains three entries, each of which is a tuple consisting of a
>> +      physical address and length. The first entry is the address and
>> +      length of the controller register set. The second entry is the
>> +      address and length of the Slave DMA data port. The third entry is
>> +      the address and length of auxiliary registers.
>
>Split into 3 descriptions:
>
>items:
>  - description: ...
>  - description: ...
>  - description: ...
>
>With that, drop 'maxItems' as it is implied.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  cdns,dqs-last-data-drop:
>> +    type: boolean
>> +    description: |
>> +      This parameter should be set when the Flash Device being used
>> +      issues data on negative edge of Flash clock and returns them with
>> +      DQS and the PHY is configured to sample data in DQS mode.
>> +      If this param is set the controller internally requests this redundant
>> +      data at the end of the transfer cleaning up the PHY FIFO.
>> +
>> +  cdns,phy-data-select-oe-start:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the starting point of the DQ pad output enable window.
>> +      Lower numbers pull the rising edge earlier in time and larger
>> +      numbers cause the rising edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-data-select-oe-end:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the ending point of the DQ pad output enable window.
>> +      Lower numbers pull the falling edge earlier in time and larger
>> +      numbers cause the falling edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-dqs-select-oe-start:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the starting point of the DQS pad output enable window.
>> +      Lower numbers pull the rising edge earlier in time and larger
>> +      numbers cause the rising edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-dqs-select-oe-end:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the ending point of the DQS pad output enable window.
>> +      Lower numbers pull the falling edge earlier in time and larger
>> +      numbers cause the falling edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-gate-cfg-close:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Normally the gate is closing then all bits of dfi_cebar are high
>> +      or when dfi_rd_pre_post_amble and rebar_dfi are high. This parameter
>> +      allows to extend the closing of the DQS gate. Recommended zero.
>> +
>> +  cdns,phy-gate-cfg:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Coarse adjust of gate open time. This value is the number of cycles
>> +      to delay the dfi_rddata_en signal prior to opening the gate in
>> +      full cycle increments. Decreasing this value pulls the gate earlier
>> +      in time. This field should be programmed such that the gate signal
>> +      lands in the valid DQS gate window.
>> +
>> +  cdns,phy-rd-del-select:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Defines the read data delay. Holds the number of cycles to delay
>> +      the dfi_rddata_en signal prior to enabling the read FIFO.
>> +      After this delay, the read pointers begin incrementing the read FIFO.
>> +
>> +  cdns,phy-clk-wr-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Controls the clk_wr delay line which adjusts the write DQ bit
>> +      timing in 1/256th steps of the clock period in normal DLL
>> +      locked mode. In bypass mode this field directly programs
>> +      the number of delay elements.
>
>For all of these, any constraints on the values? default?
>
>> +
>> +  cdns,phy-use-lpbk-dqs:
>> +    type: boolean
>> +    description: |
>> +      This parameter chooses lpbk_dqs to capture data for reads.
>> +      Instead memory DQS will be used.
>> +
>> +  cdns,phy-use-ext-lpbk-dqs:
>> +    type: boolean
>> +    description: |
>> +      This parameter chooses external lpbk_dqs for data capture
>> +      (lpbk_dqs connected to the lpbk_dqs_IO pad). When not used
>> +      mem_rebar_pad is used for data read capture.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - cdns,phy-data-select-oe-start
>> +  - cdns,phy-data-select-oe-end
>> +  - cdns,phy-dqs-select-oe-start
>> +  - cdns,phy-dqs-select-oe-end
>> +  - cdns,phy-gate-cfg-close
>> +  - cdns,phy-gate-cfg
>> +  - cdns,phy-rd-del-select
>> +  - cdns,phy-clk-wr-delay
>
>Is there no sensible default to make these optional?
>
Those parameters depend on connected flash memory, used FPGA board,
memory adapter and must be adjusted by user, to make memory
communication working.
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    xspi: spi@a0010000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "cdns,xspi-nor-fpga";
>> +        reg = <0x0 0xa0010000 0x0 0x10000>,
>> +              <0x0 0xb0000000 0x0 0x10000>,
>> +              <0x0 0xa0020000 0x0 0x10000>;
>> +        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-parent = <&gic>;
>> +        cdns,dqs-last-data-drop;
>> +        cdns,phy-data-select-oe-start = <0>;
>> +        cdns,phy-data-select-oe-end = <4>;
>> +        cdns,phy-dqs-select-oe-start = <0>;
>> +        cdns,phy-dqs-select-oe-end = <1>;
>> +        cdns,phy-gate-cfg-close = <3>;
>> +        cdns,phy-gate-cfg = <0>;
>> +        cdns,phy-rd-del-select = <5>;
>> +        cdns,phy-clk-wr-delay = <64>;
>> +        cdns,phy-use-lpbk-dqs;
>> +        cdns,phy-use-ext-lpbk-dqs;
>> +        mt35xu512@0 {
>
>flash@0
>
>> +            compatible = "spi-nor", "micron,mt35xu512";
>
>Wrong order. Most specific first.
>
>> +            spi-max-frequency = <75000000>;
>> +            reg = <0>;
>> +        };
>> +        mt35xu512@1 {
>
>flash@1
>
>> +            compatible = "spi-nor", "micron,mt35xu512";
>> +            spi-max-frequency = <75000000>;
>> +            reg = <1>;
>> +        };
>> +    };
>> --
>> 2.15.0
>>

-- 
--
Konrad Kociolek
