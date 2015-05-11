From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: enable dma modes for transfers meeting
 certain conditions
Date: Mon, 11 May 2015 18:30:32 +0200
Message-ID: <5550D928.6020708@tronnes.org>
References: <1431290849-11151-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431290849-11151-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Den 10.05.2015 22:47, skrev kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Conditions per spi_transfer are:
> * transfer.len >=3D 96 bytes (to avoid mapping overhead costs)
> * transfer.len < 65536 bytes (limitaion by spi-hw block - could get e=
xtended)
> * an individual scatter/gather transfer length must be a multiple of =
4
>    for anything but the last transfer - spi-hw block limit.
>    (some shortcut has been taken in can_dma to avoid unnecessary mapp=
ing of
>     pages which, for which there is a chance that there is a split wi=
th a
>     transfer length not a multiple of 4)
>
> If it becomes a necessity these restrictions can get removed by addit=
ional
> code.
>
> Note that this patch requires a patch to dma-bcm2835.c by Noralf to
> enable scatter-gather mode inside the dmaengine, which has not been
> merged yet.
>
> That is why no patch to arch/arm/boot/dts/bcm2835.dtsi is included - =
the
> code works as before without dma when tx/rx are not set, but it write=
s
> a message warning about dma not used:
> spi-bcm2835 20204000.spi: no tx-dma configuration found - not using d=
ma mode
>
> To enable dma-mode add the following lines to the device-tree:
>          dmas =3D <&dma 6>, <&dma 7>;
>          dma-names =3D "tx", "rx";
>
> Tested-by: Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
> (private communication)
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>   drivers/spi/spi-bcm2835.c |  303 ++++++++++++++++++++++++++++++++++=
++++++++++-
>   1 file changed, 301 insertions(+), 2 deletions(-)
>
> Tested with:
> * 2x mcp251x
> * 1x enc28j60
> * 1x fb_st7735r
>
> Note that to make it work it requires the patch to dma-engine by
> Noralf Tronnes for scatter/gather DMA.
>
> Also it is recommended that the patch for the race-condition in
> spi_finalize_current_message is applied to avoid a free before unmap
> situations (this only happens only in some configurations)

A couple of throughput tests using the fbtft drivers:

I set up 2 SPI display devices running a movie on both framebuffers.
Since I don't have an easy way to hook up 2 displays, the test was run
without anything connected. Throughput was measured to ~2.5MB/s on one
device and ~3.0MB/s on the other in bursts of ~50ms with ~10ms delay
between frames. 'top' shows cpu util of ~25% for each mplayer process
and ~10% for system (30-35% idle).

Log details:
[    2.833071] graphics fb1: fb_ili9341 frame buffer, 320x240, 150 KiB=20
video memory, 16 KiB DMA buffer memory, fps=3D50, spi32766.0 at 48 MHz
[    3.036245] graphics fb2: fb_ili9341 frame buffer, 320x240, 150 KiB=20
video memory, 16 KiB DMA buffer memory, fps=3D50, spi32766.1 at 48 MHz

[   76.863674] fb_ili9341 spi32766.0: Display update: 2576 kB/s (58.217=
=20
ms), fps=3D14 (69.997 ms)
[   76.894161] fb_ili9341 spi32766.1: Display update: 3077 kB/s (48.735=
=20
ms), fps=3D16 (59.431 ms)


Only 1 display connected (35ms burst, 15ms delay):
[    2.826042] graphics fb1: fb_ili9341 frame buffer, 320x240, 150 KiB=20
video memory, 16 KiB DMA buffer memory, fps=3D50, spi32766.0 at 48 MHz

[   51.000128] fb_ili9341 spi32766.0: Display update: 4429 kB/s (33.856=
=20
ms), fps=3D20 (49.968 ms)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
