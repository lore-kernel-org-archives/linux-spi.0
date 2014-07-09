From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Use correct device for DMA mapping with IOMMU
Date: Wed, 9 Jul 2014 23:52:22 +0200
Message-ID: <CAMuHMdWaYhSHU1toAM83V6Ee3dWdarz+Z3Q4De_idouEce_hhw@mail.gmail.com>
References: <1404901277-31107-1-git-send-email-geert+renesas@glider.be>
	<70265909.OPtNRHeAkP@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70265909.OPtNRHeAkP@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Laurent,

On Wed, Jul 9, 2014 at 11:38 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Wednesday 09 July 2014 12:21:17 Geert Uytterhoeven wrote:
>> To function correctly in the presence of an IOMMU, the DMA buffers must be
>> mapped using the DMA channel's device instead of the MSIOF platform
>> device's device.
>
> Shouldn't you also update the dma_unmap_single() calls ?

I guess I should ;-)

Thanks, will fix...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
