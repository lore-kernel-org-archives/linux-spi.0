From: padma venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO level
Date: Fri, 1 Jul 2011 11:16:11 +0530
Message-ID: <BANLkTik0LERxBHmJc5ZnRotnD4CSveR-UQ@mail.gmail.com>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
	<1309437536-9315-2-git-send-email-padma.v@samsung.com>
	<BANLkTi=L7QeN75ebWFXdp_V5Pw1zEc-ZtA@mail.gmail.com>
	<BANLkTimeWUbD2Ej16KKmuzwSCFz8HOhyKQ@mail.gmail.com>
	<BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
	<BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Padmavathi Venna <padma.v@samsung.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, kgene.kim@samsung.com,
	sbkim73@samsung.com, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, tony.kn@samsung.com,
	naushad@samsung.com
To: Tony Nadackal <tonykn@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Tony,

On Thu, Jun 30, 2011 at 4:30 PM, Tony Nadackal <tonykn@gmail.com> wrote=
:
> Hi Padma,
> With regards to your patch, even though one can check the tx done sta=
tus
> using the TX_DONE bit, the present macro itself would work perfectly =
fine if
> the 'fifo_lvl_mask' is set properly.
> For example in 6450 channel 1, the fifo_lvl_mask should be 0x1ff (for=
 9bits,
> 15:23), while even in your patch, it is wrongly set as 0x7f(only 7bit=
s).
>
> Thus, if this fifo_lvl_mask was defined correctly, the existing macro=
 would
> itself have worked.
Thanks for your comment.
I considered changing to the fifo_lvl_mask to 1ff as you mentioned.
But I  think that the fifo_lvl_mask reflects the actual FIFO capacity
in the SPI driver.
=46or the failing channels the FIFO trigger level is 64 bytes and so i
retained that value.
In the driver it polls till the FIFO capacity level otherwise it goes
for DMA.So if we keep
the FIFO level as 1ff when the actual capacity is 7f then it fails.

Jassi what do you think about this?

Thanks&Regards
Padma

> Thanks,
> Tony
>
> On Thu, Jun 30, 2011 at 3:22 PM, Jassi Brar <jassisinghbrar@gmail.com=
>
> wrote:
>>
>> On Thu, Jun 30, 2011 at 2:35 PM, padma venkat <padma.kvr@gmail.com> =
wrote:
>> > Hi,
>> >
>> > On Thu, Jun 30, 2011 at 12:38 PM, Jassi Brar <jassisinghbrar@gmail=
=2Ecom>
>> > wrote:
>> >> On Thu, Jun 30, 2011 at 6:08 PM, Padmavathi Venna <padma.v@samsun=
g.com>
>> >> wrote:
>> >>> Fixed the bug in transmission status check for 64 bytes FIFO
>> >>> level.
>> >>>
>> >>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> >>> ---
>> >>> =A0drivers/spi/spi_s3c64xx.c | =A0 =A04 +---
>> >>> =A01 files changed, 1 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx=
=2Ehc
>> >>> index 795828b..8945e20 100644
>> >>> --- a/drivers/spi/spi_s3c64xx.c
>> >>> +++ b/drivers/spi/spi_s3c64xx.c
>> >>> @@ -116,9 +116,7 @@
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(((i)->fifo_lvl_mask + 1))) \
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0? 1 : 0)
>> >>>
>> >>> -#define S3C64XX_SPI_ST_TX_DONE(v, i) ((((v) >> (i)->rx_lvl_offs=
et) &
>> >>> \
>> >>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (((i)->fifo_lvl_mask + 1) <<
>> >>> 1)) \
>> >>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ? 1 : 0)
>> >>> +#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_d=
one))
>> >>> ? 1 : 0)
>> >>
>> >> IIRC the macro is already designed to deduct tx-done levels from =
other
>> >> fields.
>> >> Could you please _explain_ with one example where it fails ? It i=
s
>> >> difficult to see without
>> >> numbers.
>> > The existing macro fails for following scenarios.
>> > 1) S5P64X0 channel 1
>> > 2) S5PV210 channel 1
>> > 3) S5PV310 channel 1 and channel 2
>> >
>> > The FIFO data level supported in the above SoCs either 64 or 256
>> > bytes depending on the channel. Because of this the TX_DONE
>> > is the 25 bit in the status register.
>> >
>> > The existing macro works for the following scenarios
>> > 1) S3C6410 all channels
>> > 2) S5PC100 all channels
>> >
>> > The FIFO data level supported in the above SoCs 64 bytes
>> > on all the channels. Because of this the TX_DONE is the 21 bit
>> > in the status register.
>> >
>> > So when we use the existing macro for the non-working SoCs
>> > it is not anding with the TX_DONE bit but it is only anding the bi=
ts
>> > earlier to TX_DONE bit.
>> >
>>
>> I see.
>> I don't have access to post s3c64xx datasheets. Please confirm if TX=
_DONE
>> bit at same offset for all channels of an SoC. If so, I am OK with
>> these 2 patches.
>>
>> Thanks,
>> Jassi
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
