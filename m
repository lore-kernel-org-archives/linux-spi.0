From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Fri, 28 Feb 2020 11:08:59 +0800
Message-ID: <3ec7c41f-f074-3b0a-25c6-1ac04f524bbb@linux.intel.com>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227170748.GA19661@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com, marex@denx.de,
        mark.rutland@arm.com, linux-mtd@lists.infradead.org,
        dwmw2@infradead.org, richard@nod.at, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200227170748.GA19661@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On 28/2/2020 1:07 AM, Rob Herring wrote:
> On Thu, 27 Feb 2020 14:27:07 +0800, "Ramuthevar,Vadivel MuruganX" wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 142 +++++++++++++++++++++
>>   2 files changed, 142 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:

Thanks!,  Sorry for the trouble , next time will run and fix it up.

Regards
Vadivel
>
> warning: no schema found in file: Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: ignoring, error in schema: patternProperties: cdns,read-delay
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: {'description': 'Delay in 4 microseconds, read capture logic, in clock cycles.'} is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: 'not' is a required property
>
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1245559
> Please check and re-submit.
