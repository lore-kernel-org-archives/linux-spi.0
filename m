From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v12 1/4] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Fri, 20 Mar 2020 14:19:37 +0800
Message-ID: <13a92ddd-b7dd-0465-d747-cda9bca21dbf@linux.intel.com>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <c2ad909e-9042-6ba0-7213-83346c6b9908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        david.oberhollenzer-S6VGOU4v5edDinCvNWH78Q@public.gmane.org, miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
        tudor.ambarus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c2ad909e-9042-6ba0-7213-83346c6b9908-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 20/3/2020 2:05 pm, Vignesh Raghavendra wrote:
>
> On 10/03/20 7:22 am, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 +++++++++++++++++++++
>>   2 files changed, 127 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
> [...]
>
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fA-F]+$":
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Delay in 4 microseconds, read capture logic, in clock cycles.
>
> Not its not... See the old binding description please:
>
> -- cdns,read-delay : Delay for read capture logic, in clock cycles
>
> There is no mention of 4us. Range is 0x0 - 0xF
Sure, will update as you have suggested.
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
> Again see the description in old binding file:
>
>   cdns,tshsl-ns : Delay in nanoseconds for the length that the master
>                    mode chip select outputs are de-asserted between
> 	  	transactions.
>
> Need not be 50ns or its multiple
Sure, will update as you have suggested.
>> +
>> +  cdns,tsd2d-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, between one chip select being de-activated
>> +      and the activation of another.
>> +
> same here
>
>> +  cdns,tchsh-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
>> +
> Same here... Need not be 4ns...
>
>> +  cdns,tslch-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
>> +      first bit transfer.
>
> Same here...
>
> Above four values ( cdns,*-ns) come directly from the flash datasheets.
>
> These values are converted appropriate number of cycles depending upon
> the QSPI ref_clk frequency. So, there is no easy way to express the
> constraint (or range) in DT schema. I would recommend to just stick with
> the description that is there in the old binding file without any
> modifications.

Noted, will update.

Regards
Vadivel
>
> Regards
> Vignesh
