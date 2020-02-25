From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Tue, 25 Feb 2020 16:30:21 +0530
Message-ID: <8c329860-84fd-463b-782f-83a788998878@ti.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
 <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
 <85178128-4906-8b1a-e3f1-ab7a36ff8c23@ti.com>
 <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Dinh Nguyen <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex-ynQEQJNshbs@public.gmane.org>,
        <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c119a70d-b7ef-ab1b-4590-7ac77395297f-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 25/02/20 1:08 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>>> +
>>>>> +  cdns,fifo-depth:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Size of the data FIFO in words.
>>>> A 4GB fifo is valid? Add some constraints.
>>> 128 is valid, will update.
>> Nope, the width of this field is 8bits -> 256 bytes 
> 
> correct me if I am wrong, the width of this field is 4bits -> 128 bytes
> (based on QUAD mode) .

This has nothing to do with quad-mode. Its about how much SRAM amount of
SRAM is present to buffer INDAC mode data. For TI platforms this is 256
bytes.
See CQSPI_REG_SRAMPARTITION definition in your datasheet.

-- 
Regards
Vignesh
