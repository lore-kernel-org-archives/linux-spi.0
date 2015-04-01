From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Wed, 01 Apr 2015 09:20:02 -0600
Message-ID: <551C0CA2.40406@wwwdotorg.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org> <E13569A5-33E5-48ED-B25F-EC7374E144C9@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E13569A5-33E5-48ED-B25F-EC7374E144C9-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/31/2015 08:49 AM, Martin Sperl wrote:
>
>> On 28.03.2015, at 05:09, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>> As for testing: I have also tried to test with mmc_spi, but I have not
>>> been able to make that driver work reliably in any recent kernel
>>> versions.
>>> Most of the time I see timeouts - and with lots of different SD-cards...
>>>
>>> IIRC the last time I tested it successfully was with 3.12.
>>
>> It'd be great if you could use "git bisect" to track down the change
>> that broke this.
...
> Bisection between these shows the responsible commit is:
...
> commit 0589342c27944e50ebd7a54f5215002b6598b748
> Author: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Date:   Tue Oct 29 23:36:46 2013 -0500
>
>      of: set dma_mask to point to coherent_dma_mask
>
>      Platform devices created by DT code don't initialize dma_mask pointer to
>      anything. Set it to coherent_dma_mask by default if the architecture
>      code has not set it.
>
>      Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
...
> Now I went back to 4.0.rc5+ and patched it as follows:
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -179,9 +179,10 @@ static void of_dma_configure(struct device *dev)
>           * Set it to coherent_dma_mask by default if the architecture
>           * code has not set it.
>           */
> +/*
>          if (!dev->dma_mask)
>                  dev->dma_mask = &dev->coherent_dma_mask;
> -
> +*/
>          ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
>          if (ret < 0) {
>                  dma_addr = offset = 0;
>
> And now it works - the SD card gets detected immediately,
> I can mount it and everything...

Does that change cause the SDHCI core to use vs. not-use any of the 
SDHCI DMA modes? If so, I wonder if this is because the upstream kernel 
doesn't deal with the bcm2835's ARM physical address <-> SoC bus address 
conversions, which in turn can cause DMA and CPU access to not use the 
same caching settings and become incoherent, which in turn can cause DMA 
data corruption. See the following link for some background:

https://www.mail-archive.com/u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org/msg167376.html
[PATCH 2/3] ARM: bcm2835: implement phys_to_bus/bus_to_phys

(you'll want to read all of patches 1-3 for the complete background I 
think, but patch 2 describes the HW issue)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
