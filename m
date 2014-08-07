From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 09/12] [v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
Date: Thu, 7 Aug 2014 10:27:21 +0200
Message-ID: <CAMuHMdU+o=CGFMyDVSxSKbpAx1oi1id7zABf-pm_pYzvuGOrWw@mail.gmail.com>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
	<1407329949-5695-10-git-send-email-geert+renesas@glider.be>
	<20140807003755.GF32652@verge.net.au>
	<20140807003908.GA30872@verge.net.au>
	<20140807004107.GB30872@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140807004107.GB30872-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Simon,

On Thu, Aug 7, 2014 at 2:41 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Thu, Aug 07, 2014 at 09:39:08AM +0900, Simon Horman wrote:
>> On Thu, Aug 07, 2014 at 09:37:56AM +0900, Simon Horman wrote:
>> > On Wed, Aug 06, 2014 at 02:59:06PM +0200, Geert Uytterhoeven wrote:
>> > > Add a DMA property to the QSPI node
>> > >
>> > > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>> > > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > > ---
>> > > This depends on "[PATCH v2 8/8] ARM: shmobile: r8a7791: Add DMAC devices
>> > > to DT" of series "[PATCH v2 0/8] R-Car Gen2 DMA Controller driver".
>> >
>> > Hi Geert, Hi Laurent,
>> >
>> > Am I correct in assuming that with this patch applied things
>> > will continue to work the old way until the patch above applied
>> > to the same tree and from there on the user will get the new behaviour?
>> >
>> > If so I think that I can take this patch as although the driver hasn't been
>> > merged the relevant bindings were added to the subsystem maintainers tree
>> > by "dmaengine: rcar-dmac: Add device tree bindings documentation" and are
>> > available in linux-next.
>> >
>> > Likewise for "[v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIO".
>>
>> ... and "ARM: shmobile: r8a7790 dtsi: Enable DMA for QSPI"
>
> ... and "ARM: shmobile: r8a7790 dtsi: Enable DMA for MSIO"
>
> and any other similar patches I didn't list above :)

Yes[*].

If rcar-dma is not available, drivers fall back to PIO, cfr. for rspi:

-renesas_spi e6b10000.spi: DMA available
+renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
+renesas_spi e6b10000.spi: DMA not available, using PIO
 renesas_spi e6b10000.spi: registered master spi0
 spi spi0.0: setup mode 0, 8 bits/w, 30000000 Hz max --> 0
 m25p80 spi0.0: s25fl512s (65536 Kbytes)
 3 ofpart partitions found on MTD device spi0.0
 Creating 3 MTD partitions on "spi0.0":
 0x000000000000-0x000000080000 : "loader"
 0x000000080000-0x000000100000 : "bootenv"
 0x000000100000-0x000004000000 : "data"
 renesas_spi e6b10000.spi: registered child spi0.0

and sh-msiof:

-spi_sh_msiof e6e20000.spi: DMA available
+spi_sh_msiof e6e20000.spi: dma_request_slave_channel_compat failed
+spi_sh_msiof e6e20000.spi: DMA not available, using PIO
 spi_sh_msiof e6e20000.spi: registered master spi1
 spi spi1.0: setup mode 3, 8 bits/w, 6000000 Hz max --> 0
 spi_sh_msiof e6e20000.spi: registered child spi1.0

and everything still works, but slower.

[*] If the individual DMA slave drivers properly handle DMA request
    failures. If they don't, they will already fail now, as there is no DMA
    platform configuration without the dmas/dma-names properties
    (ignoring Magnus' DMA prototypes using auxdata, as DT is the way
     forward).

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
