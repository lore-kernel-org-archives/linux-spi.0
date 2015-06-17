From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] spi: img-spfi: Same Edge bit set to double supported
 transfer speed
Date: Wed, 17 Jun 2015 16:31:09 +0200
Message-ID: <CAOiHx=mibfR8nJALUe_9Sa98ypmPgbEE6UTQHmd9Jzb51V4wLg@mail.gmail.com>
References: <1434535262-7393-1-git-send-email-sifan.naeem@imgtec.com>
 <CAOiHx=ntO2tp7SjU7-f=1oxDa3FJZ6z4gxeu7ZBsUsaijpAK0g@mail.gmail.com> <A0E307549471DA4DBAF2DE2DE6CBFB7E4961964D@hhmail02.hh.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A0E307549471DA4DBAF2DE2DE6CBFB7E4961964D-brIQrgj5TFtJFJhlrACyRFBRoQTxkR7k@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Wed, Jun 17, 2015 at 3:36 PM, Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Jonas,
>
>> -----Original Message-----
>> From: Jonas Gorski [mailto:jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org]
>> Sent: 17 June 2015 13:12
>> To: Sifan Naeem
>> Cc: Mark Brown; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> Andrew Bresticker
>> Subject: Re: [PATCH v2] spi: img-spfi: Same Edge bit set to double supported
>> transfer speed
>>
>> Hi,
>>
>> On Wed, Jun 17, 2015 at 12:01 PM, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> wrote:
>> > Same edge bit set in SPFI Control register to double the supported
>> > spfi clock speed. Setting this bit increases the supported spfi
>> > frequency from 1/8 to 1/4 of the core clock frequency.
>> >
>> > Without this bit set the maximum speed supported was 25MHz on
>> > Pistachio.
>> >
>> > Change-Id: I26782ea88ac3567e72dac11e46c5b5f5f52c5e3d
>> > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  drivers/spi/spi-img-spfi.c |    2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
>> > index 788e2b1..acce90a 100644
>> > --- a/drivers/spi/spi-img-spfi.c
>> > +++ b/drivers/spi/spi-img-spfi.c
>> > @@ -40,6 +40,7 @@
>> >  #define SPFI_CONTROL_SOFT_RESET                        BIT(11)
>> >  #define SPFI_CONTROL_SEND_DMA                  BIT(10)
>> >  #define SPFI_CONTROL_GET_DMA                   BIT(9)
>> > +#define SPFI_CONTROL_SE                        BIT(8)
>> >  #define SPFI_CONTROL_TMODE_SHIFT               5
>> >  #define SPFI_CONTROL_TMODE_MASK                        0x7
>> >  #define SPFI_CONTROL_TMODE_SINGLE              0
>> > @@ -491,6 +492,7 @@ static void img_spfi_config(struct spi_master
>> *master, struct spi_device *spi,
>> >         else if (xfer->tx_nbits == SPI_NBITS_QUAD &&
>> >                  xfer->rx_nbits == SPI_NBITS_QUAD)
>> >                 val |= SPFI_CONTROL_TMODE_QUAD <<
>> > SPFI_CONTROL_TMODE_SHIFT;
>> > +       val |= SPFI_CONTROL_SE;
>> >         spfi_writel(spfi, val, SPFI_CONTROL);  }
>>
>> Don't you also need to update master->max_speed_hz? And if it doubles the
>> clock speed, don't you need to reflect that in the calculation for the devider?
>> Currently it looks like it would just cause all transfers to go with the doubled
>> requested rate. But maybe I'm missing something.
>>
> max_speed_hz is already set to 1/4  of the Core clock. So I don't think we need to change that.
> In Pistachio SoC the max speed of SPFI block is limited to 1/4 of the core clock or to 50Mhz, to achieve these values the change suggested in this patch should have always been set. In the device tree node for SPFI we have to mention the limit of 50Mhz as spi-max-frequency = <50000000>;

So it calculated the wrong divisor before, and the resulting speed was
half of that and setting this bit actually fixes it? Or does the block
just treat speeds > 25 MHz as 25 MHz when this bit is set? I'm still
trying to wrap my head around that setting a single bit in a register
allows going from 0~25 MHz to 0~50 MHz without needing to update the
calculation of the divisor.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
