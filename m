From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Thu, 27 Feb 2020 10:53:58 +0530
Message-ID: <22bb0c6c-db03-dee5-eccf-84b00216308f@ti.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
 <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
 <85178128-4906-8b1a-e3f1-ab7a36ff8c23@ti.com>
 <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
 <8c329860-84fd-463b-782f-83a788998878@ti.com>
 <98c90f35-297b-a13c-61ad-ce7a7f1d650f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>, <tien.fong.chee@intel.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98c90f35-297b-a13c-61ad-ce7a7f1d650f@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 26/02/20 7:02 am, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 25/2/2020 7:00 PM, Vignesh Raghavendra wrote:
>>
>> On 25/02/20 1:08 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>>>>> +
>>>>>>> +  cdns,fifo-depth:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description:
>>>>>>> +      Size of the data FIFO in words.
>>>>>> A 4GB fifo is valid? Add some constraints.
>>>>> 128 is valid, will update.
>>>> Nope, the width of this field is 8bits -> 256 bytes
>>> correct me if I am wrong, the width of this field is 4bits -> 128 bytes
>>> (based on QUAD mode) .
>> This has nothing to do with quad-mode. Its about how much SRAM amount of
>> SRAM is present to buffer INDAC mode data. For TI platforms this is 256
>> bytes.
>> See CQSPI_REG_SRAMPARTITION definition in your datasheet.
> Agreed, Thanks!
> Yes , I have gone through it , Intel and Altera SoC's SRAM(act as
> FIFO)size is 128 bytes and TI has 256 .
> BTW old legacy DT binding mentioned size is 128, as per your earlier
> suggestion you have mention that
> keep the contents from old dt bindings as it is, so shall I keep 128/256?

Old bindings does not impose a restriction that this needs to be 128
bytes always (Its just the example that shows this property to be set to
128)

What Rob is asking for is to add range of values that is valid for this
field and not single value. So, both 128 and 256 bytes should be allowed
as valid values for this property.


-- 
Regards
Vignesh
