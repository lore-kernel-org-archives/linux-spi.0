From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO level
Date: Thu, 30 Jun 2011 15:22:20 +0530
Message-ID: <BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
	<1309437536-9315-2-git-send-email-padma.v@samsung.com>
	<BANLkTi=L7QeN75ebWFXdp_V5Pw1zEc-ZtA@mail.gmail.com>
	<BANLkTimeWUbD2Ej16KKmuzwSCFz8HOhyKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Padmavathi Venna <padma.v@samsung.com>, kgene.kim@samsung.com,
	sbkim73@samsung.com, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: padma venkat <padma.kvr@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <BANLkTimeWUbD2Ej16KKmuzwSCFz8HOhyKQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 30, 2011 at 2:35 PM, padma venkat <padma.kvr@gmail.com> wro=
te:
> Hi,
>
> On Thu, Jun 30, 2011 at 12:38 PM, Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>> On Thu, Jun 30, 2011 at 6:08 PM, Padmavathi Venna <padma.v@samsung.c=
om> wrote:
>>> Fixed the bug in transmission status check for 64 bytes FIFO
>>> level.
>>>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>>> ---
>>> =C2=A0drivers/spi/spi_s3c64xx.c | =C2=A0 =C2=A04 +---
>>> =C2=A01 files changed, 1 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.hc
>>> index 795828b..8945e20 100644
>>> --- a/drivers/spi/spi_s3c64xx.c
>>> +++ b/drivers/spi/spi_s3c64xx.c
>>> @@ -116,9 +116,7 @@
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(=
((i)->fifo_lvl_mask + 1))) \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0?=
 1 : 0)
>>>
>>> -#define S3C64XX_SPI_ST_TX_DONE(v, i) ((((v) >> (i)->rx_lvl_offset)=
 & \
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((i=
)->fifo_lvl_mask + 1) << 1)) \
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? 1 =
: 0)
>>> +#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done=
)) ? 1 : 0)
>>
>> IIRC the macro is already designed to deduct tx-done levels from oth=
er fields.
>> Could you please _explain_ with one example where it fails ? It is
>> difficult to see without
>> numbers.
> The existing macro fails for following scenarios.
> 1) S5P64X0 channel 1
> 2) S5PV210 channel 1
> 3) S5PV310 channel 1 and channel 2
>
> The FIFO data level supported in the above SoCs either 64 or 256
> bytes depending on the channel. Because of this the TX_DONE
> is the 25 bit in the status register.
>
> The existing macro works for the following scenarios
> 1) S3C6410 all channels
> 2) S5PC100 all channels
>
> The FIFO data level supported in the above SoCs 64 bytes
> on all the channels. Because of this the TX_DONE is the 21 bit
> in the status register.
>
> So when we use the existing macro for the non-working SoCs
> it is not anding with the TX_DONE bit but it is only anding the bits
> earlier to TX_DONE bit.
>

I see.
I don't have access to post s3c64xx datasheets. Please confirm if TX_DO=
NE
bit at same offset for all channels of an SoC. If so, I am OK with
these 2 patches.

Thanks,
Jassi
