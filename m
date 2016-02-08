From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Mon, 8 Feb 2016 08:41:34 +0530
Message-ID: <20160208031134.GI2531@localhost>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <56AF01B6.6030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56AF01B6.6030204-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> Hello Vinod,
>=20
> Is there any chance apply the DMA patches?:-)

I was waiting for any ACKs on ARM patches before I merge this series.

> =E5=9C=A8 2016=E5=B9=B401=E6=9C=8822=E6=97=A5 19:06, Caesar Wang =E5=86=
=99=E9=81=93:
> >This series patches are apply on linus master branch.
> >Okay, this series patches verified on my github.
> >(https://github.com/Caesar-github/rockchip/commits/for-dma-tests)
> >
> >Linux version 4.4.0+ (wxt@ubuntu)  (Ubuntu/Linaro 4.7.3-12ubuntu1) )=
 #14
> >SMP Fri Jan 22 18:13:12 CST 2016
> >
> >The perious version 6 from Shawn.
> >(http://www.spinics.net/lists/dmaengine/msg06606.html)
> >I pick them up to go on upstream since Shawn hasn't much time to tra=
ck them.
> >----
> >
> >The purpose of the DMAFLUSHP instruction:
> >- Tell the peripheral to clear its status and control registers.
> >- Send a message to the peripheral to resend its level status.
> >
> >There are 3 timings described in PL330 Technical Reference Manual:
> >- Timing 1: Burst request, can work well without DMAFLUSHP.
> >- Timing 2: Single and burst request, DMAC will ignore the single
> >             transfer request. This timing happens if there are sing=
le
> >             and burst request.
> >- Timing 3: Single transfers for a burst request, DMAC should signal=
s
> >             datype to request the peripheral to flush the contents =
of
> >             any control registers. This timing happens if there is
> >             not enough MFIFO to places the burst data.
> >
> >A peripheral may signal a DMA request during the execution of
> >DMAFLUSHP instruction, that cause DMA request being ignored by DMAC.
> >
> >But DMAC and all peripherals on RK3X SoCs DO NOT support DMAFLUSHP.
> >It can't send a message to the peripheral to resend DMA request,
> >and the peripheral can't acknowledge a flush request from DMAC.
> >So all DMA requests should NOT be ignored by DMAC, and DMAC will not
> >notify the peripheral to flush.
> >
> >To fix this problem, we need:
> >- Do NOT execute DMAFLUSHP instruction.
> >- Timing 2 and timing 3 should not happen.
> >
> >Because on RK3X SoCs, there are 6 or below  channels and 32 MFIFO de=
pth
> >for DMAC_BUS, and 8 channels and 64 MFIFO depth for DMAC_PERI, it is
> >impossible to hit the timing 3 if burst length is equal or less than=
 4.
> >
> >Since the request type signal by the peripheral can only be set by
> >software. We can set Rockchip Soc's GRF_PERIDMAC_CON0[2:1] to select=
 single
> >or burst request, if it is set b01,  all of the peripharals will sig=
nal a brust
> >request. So the timing 2 will not happen, too.
> >
> >So DMAC on RK3X can support single or burst transfer, but can't supp=
ort
> >mixed transfer.
> >
> >Because burst transfer is more efficient than single transfer, this =
is
> >confirmed by our ASIC team, who strongly suggest to use burst transf=
er.
> >And this is confirmed by Addy's test on RK3288-Pink2 board, the spee=
d of
> >spi flash burst transfer will increase about two times than single t=
ransfer.
> >Also, I have tested dw_mmc with pl330 on RK3188 platform to double c=
onfirm
> >the result. That means burst transfer is reansonable.
> >
> >So we need a quirk not to execute DMAFLUSHP instruction and to use b=
urst
> >transfer.
> >
> >Note:
> >- The Rockchip Soc default value of GRF_PERIDMAC_CON0[2:1] is b01. T=
o
> >   support brust transfer, these bits should not be changed in bootl=
oader.
> >
> >Todo:
> >remove the patches releated to i2s, that will send them at later.
> >- https://patchwork.kernel.org/patch/7399581/
> >- https://patchwork.kernel.org/patch/7399671/
> >
> >
> >Changes in v7:
> >- As vinod comments, fix the subsystem name.
> >- modify the subject to be better match.
> >- fix the subsystem.
> >- fix the subject.
> >- fix the subject.
> >
> >Changes in v6:
> >- remove expose quirk and add dma max_burst caps for clients
> >- remove expose quirks and add max_burst for dmaengine
> >- remove quirks and get dma caps in order to limit burst
> >
> >Changes in v5:
> >- add Mark's tag for spi changes
> >- remove unnecessary whitespace change
> >- use switch statement for i2s quirk
> >
> >Changes in v4:
> >- remove spi & i2s dts changes and query quirk from dmaengine API
> >   suggeseted by Mark.
> >- fix typo
> >- Add dmaengine_get_quirk hook and implement it for pl330
> >
> >Changes in v3:
> >- add Sunny's tag
> >- add more rockchip drivers' changes in this patchset
> >- add Reviewed-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >- add Reviewed-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >- add Reviewed-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >
> >Changes in v2:
> >- amend the author
> >- reorder the patches suggested by Doug
> >- add Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> for
> >   rk3288.dtsi patch and arm-pl330.txt patch
> >- add Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >- amend the author
> >- fix Olof's mail address
> >- amend the author
> >- add Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >- amend Olof's mail address
> >
> >Changes in v1:
> >- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
> >   by Krzysztof.
> >- add From original author.
> >- remove Sunny's tag
> >- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
> >   by Krzysztof.
> >- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
> >   by Krzysztof.
> >- remove Sunny's tag
> >- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
> >   by Krzysztof.
> >   - remove Sunny's tag
> >- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
> >   by Krzysztof.
> >
> >Addy Ke (3):
> >   dmaengine: pl330: add quirk for broken no flushp
> >   ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3288 platfo=
rm
> >   spi: rockchip: modify DMA max burst to 1
> >
> >Boojin Kim (1):
> >   dmaengine: pl330: support burst mode for dev-to-mem and mem-to-de=
v
> >     transmit
> >
> >Caesar Wang (1):
> >   ARM: dts: add pl330-broken-no-flushp quirk for rk3036 SoCs
> >
> >Shawn Lin (4):
> >   dt/bindings: arm-pl330: add description of arm, pl330-broken-no-f=
lushp
> >   ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3xxx platfo=
rm
> >   dmaengine: core: expose max burst capability to clients
> >   dmaengine: pl330: add max burst for dmaengine
> >
> >  .../devicetree/bindings/dma/arm-pl330.txt          |   1 +
> >  arch/arm/boot/dts/rk3036.dtsi                      |   1 +
> >  arch/arm/boot/dts/rk3288.dtsi                      |   3 +
> >  arch/arm/boot/dts/rk3xxx.dtsi                      |   3 +
> >  drivers/dma/dmaengine.c                            |   1 +
> >  drivers/dma/pl330.c                                | 106 +++++++++=
++++++------
> >  drivers/spi/spi-rockchip.c                         |  12 ++-
> >  include/linux/dmaengine.h                          |   4 +
> >  8 files changed, 99 insertions(+), 32 deletions(-)
> >
>=20
>=20
> --=20
> Thanks,
> Caesar
>=20

--=20
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
