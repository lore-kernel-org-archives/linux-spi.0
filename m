From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Fri, 3 Apr 2015 12:17:31 +0200
Message-ID: <A1AEABE2-F0D2-481B-BD83-E1AD7861E960@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org> <E13569A5-33E5-48ED-B25F-EC7374E144C9@martin.sperl.org> <551C0CA2.40406@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551C0CA2.40406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 01.04.2015, at 17:20, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> Does that change cause the SDHCI core to use vs. not-use any of the SDHCI DMA modes? If so, I wonder if this is because the upstream kernel doesn't deal with the bcm2835's ARM physical address <-> SoC bus address conversions, which in turn can cause DMA and CPU access to not use the same caching settings and become incoherent, which in turn can cause DMA data corruption. See the following link for some background:
> 
> https://www.mail-archive.com/u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org/msg167376.html
> [PATCH 2/3] ARM: bcm2835: implement phys_to_bus/bus_to_phys
> 
> (you'll want to read all of patches 1-3 for the complete background I think, but patch 2 describes the HW issue)

I can also just patch out the assignement to dev_dma here and it works as well:
	if (spi->master->dev.parent->dma_mask) {
		struct device   *dev = spi->master->dev.parent;

		host->dma_dev = dev;
		host->ones_dma = dma_map_single(dev, ones,
				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
		host->data_dma = dma_map_single(dev, host->data,
				sizeof(*host->data), DMA_BIDIRECTIONAL);
So DMA there is not an issue with SDHCI - it is just when using the
"normal" spi-bcm2835 that I can reproduce it.

If you read the mmc_spi driver there is a lot of places where we have 
constructs like this:
        if (host->dma_dev) {
                host->m.is_dma_mapped = 1;
                dma_sync_single_for_device(host->dma_dev,
                                host->data_dma, sizeof(*host->data),
                                DMA_BIDIRECTIONAL);
        }
        status = spi_sync_locked(host->spi, &host->m);

        if (host->dma_dev)
                dma_sync_single_for_cpu(host->dma_dev,
                                host->data_dma, sizeof(*host->data),
                                DMA_BIDIRECTIONAL);

Similar constructs exist for: dma_map_page and dma_unmap_page.

As far as I can tell these are the "typical" dma-related calls.

But the point is that the spi-bcm2835 driver does not implement DMA (yet),
so some things may not be fully set up for mapping inside 
spi->master->dev.parent and some mapping options may fail/not work as
expected. This may results in possibly "bad" behavior, just because dma_mask
 is set.

So i am not sure if this "mapping" issue you are mentioning is really the
root-cause - also I test on a RPI1, but have also tried on a RPI2 with the 
foundation kernel.

On top my reading/experience with DMA on the bcm2835 is that I was always
using 0xC0000000 as the bus-address, as the L1/L2 addresses in the
documentation are only related to VideoCore caches - and that is I guess
why the "L2 preload" is explicitly mentioned in the documentation - probably
to speed up the GPU by  prefetching the necessary data via DMA and thus 
avoiding to wait for data to get read from SRAM.

Unfortunately I can not test if the the mmc_spi issue exists on a
beaglebone, as the mmc_spi driver can not even get compiled there because
of CONFIG_HIGHMEM being set which conflicts with KConfig portion for
mmc_spi...


Ciao,
	Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
