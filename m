From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Date: Wed, 18 Sep 2019 13:59:06 +0800
Message-ID: <eeefa79b-0a3b-5d62-3a1b-c1e9dcb03aa7@linux.intel.com>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916113255.GA4352@sirena.co.uk>
 <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
 <20190917153650.GF3524@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917153650.GF3524@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

    Thank you for the review comments.

On 17/9/2019 11:36 PM, Mark Brown wrote:
> On Tue, Sep 17, 2019 at 10:11:28AM +0800, Ramuthevar, Vadivel MuruganX wrote:
>
>> *    spi-cadence.c* in *drivers/spi/*, which supports very old legacy
>> cadence-spi based devices(normal)
>> *    cadence-quadspi.c(drivers/mtd/spi-nor/)* : specific support to SPI-NOR
>> flash with new spi-nor layer.
>>      all the API's in this driver purely on spi-nor specific, so couldn't
>> proceed to adapt.
> Are these completely separate IPs or are they just different versions of
> the same IP?

These are same IPs , but different features Enabled/Disabled depends 
upon the SoC vendors.

for e.g: Intel LGM SoC uses the same IP, but without DMA and Direct 
access controller.

also dedicated support to flash devices.

Best regards

Vadivel
