From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date: Tue, 10 Mar 2020 08:40:28 +0100
Message-ID: <4beb5200a76f2d817be7276444543de4@walle.cc>
References: <20200310073313.21277-1-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310073313.21277-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 2020-03-10 08:33, schrieb Michael Walle:
> Use the correct device to request the DMA mapping. Otherwise the IOMMU
> doesn't get the mapping and it will generate a page fault.
> 
> The error messages look like:
> [    3.008452] arm-smmu 5000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> [    3.020123] arm-smmu 5000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> 
> This was tested on a custom board with a LS1028A SoC.

Oh fu.. please disregard this patch. DMA mapping still isn't working.
Somehow I missed that the transfer mode was turned back to its default
XSPI mode.

-michael
