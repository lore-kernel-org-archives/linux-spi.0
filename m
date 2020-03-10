From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date: Tue, 10 Mar 2020 09:10:35 +0100
Message-ID: <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
References: <20200310073313.21277-1-michael@walle.cc>
 <4beb5200a76f2d817be7276444543de4@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4beb5200a76f2d817be7276444543de4@walle.cc>
Sender: linux-media-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-10 08:40, schrieb Michael Walle:
> Am 2020-03-10 08:33, schrieb Michael Walle:
>> Use the correct device to request the DMA mapping. Otherwise the IOMMU
>> doesn't get the mapping and it will generate a page fault.
>> 
>> The error messages look like:
>> [    3.008452] arm-smmu 5000000.iommu: Unhandled context fault:
>> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
>> [    3.020123] arm-smmu 5000000.iommu: Unhandled context fault:
>> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
>> 
>> This was tested on a custom board with a LS1028A SoC.
> 
> Oh fu.. please disregard this patch. DMA mapping still isn't working.
> Somehow I missed that the transfer mode was turned back to its default
> XSPI mode.

Damn. I need more coffee.. this patch IS working. Only the first probe
fails due to EPROBE_DEFER.

[    2.539706] fsl-dspi 2120000.spi: rx dma channel not available (-517)
[    2.546200] fsl-dspi 2120000.spi: can't get dma channels
[    3.622774] spi-nor spi1.0: w25q128fw (16384 Kbytes)

-michael
