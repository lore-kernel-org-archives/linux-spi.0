From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Wed, 15 Aug 2018 09:44:27 +0800
Message-ID: <CAMz4kuKb_5gxMbLG1cfPwFHS9n666epy38Akz1FhDcjeAUik9A@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180814202122.GA26606@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814202122.GA26606@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On 15 August 2018 at 04:21, Rob Herring <robh@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
>> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>>
>> This patch adds the binding documentation for Spreadtrum SPI
>> controller device.
>>
>> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-sprd.txt |   31 ++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
>> new file mode 100644
>> index 0000000..06ff746
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
>> @@ -0,0 +1,31 @@
>> +Spreadtrum SPI Controller
>> +
>> +Required properties:
>> +- compatible: Should be "sprd,sc9860-spi".
>> +- reg: Offset and length of SPI controller register space.
>> +- interrupts: Should contain SPI interrupt.
>> +- clock-names: Should contain following entries:
>> +     "spi" for SPI clock,
>> +     "source" for SPI source (parent) clock,
>
> Do the h/w block actually get this clock or the driver needs it? In the
> latter case, it should not be in DT.

Yes, we will get the actual SPI source clock form the "source" clock property.

>
>> +     "enable" for SPI module enable clock.
>> +- clocks: List of clock input name strings sorted in the same order
>> +     as the clock-names property.
>> +- #address-cells: The number of cells required to define a chip select
>> +     address on the SPI bus. Should be set to 1.
>> +- #size-cells: Should be set to 0.
>> +
>> +Optional properties:
>> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
>> +     converted to the delay clock cycles = interval number * 4 + 10.
>
> There are read and write delay properties you can use.

Right. We've agreed introducing another field for spi_transfer to
represent this and will remove 'sprd,spi-interval' from DT.

-- 
Baolin Wang
Best Regards
