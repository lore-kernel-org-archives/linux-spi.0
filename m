From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date: Tue, 10 Mar 2020 15:02:50 +0200
Message-ID: <CA+h21hqMoPhbq8YG0UeV1kP0iXApYsJvb9MZjPGX54dm2U-KnQ@mail.gmail.com>
References: <20200310073313.21277-1-michael@walle.cc> <4beb5200a76f2d817be7276444543de4@walle.cc>
 <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
        Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ea6ffa30ddc2459d07935e5e61a41172-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 10 Mar 2020 at 10:12, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Am 2020-03-10 08:40, schrieb Michael Walle:
> > Am 2020-03-10 08:33, schrieb Michael Walle:
> >> Use the correct device to request the DMA mapping. Otherwise the IOMMU
> >> doesn't get the mapping and it will generate a page fault.
> >>
> >> The error messages look like:
> >> [    3.008452] arm-smmu 5000000.iommu: Unhandled context fault:
> >> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> >> [    3.020123] arm-smmu 5000000.iommu: Unhandled context fault:
> >> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> >>
> >> This was tested on a custom board with a LS1028A SoC.
> >
> > Oh fu.. please disregard this patch. DMA mapping still isn't working.
> > Somehow I missed that the transfer mode was turned back to its default
> > XSPI mode.
>
> Damn. I need more coffee.. this patch IS working. Only the first probe
> fails due to EPROBE_DEFER.
>
> [    2.539706] fsl-dspi 2120000.spi: rx dma channel not available (-517)
> [    2.546200] fsl-dspi 2120000.spi: can't get dma channels
> [    3.622774] spi-nor spi1.0: w25q128fw (16384 Kbytes)
>
> -michael

I'm testing LS1028A with IOMMU_DEFAULT_PASSTHROUGH=y and I didn't have
time to change my setup now. I've also sent a v3 to my patch series
which is going to conflict with this one, sorry. I would have picked
your patch up with my series but I didn't have the right environment
to test it.

Thanks,
-Vladimir
