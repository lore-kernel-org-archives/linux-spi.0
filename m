From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: DUAL and QUAD support
Date: Fri, 9 Aug 2013 11:22:07 +0800
Message-ID: <CAHSAbzMOTk-xKDRx-1Ew67OZYbgWQnFCzfjEvu75Wyz6Yb-omA@mail.gmail.com>
References: <20130729064234.GS9858@sirena.org.uk>
	<1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
	<CAHSAbzNdvgTSPqDPHT2n3zXFwe7HBqTfyk4fB_-GsW1WSUXqRA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE356@DBDE04.ent.ti.com>
	<CA+7tXijduVqFdao3L3oJcFBYw_cffdyo-fwyAS2cBASfEMExpA@mail.gmail.com>
	<CAHSAbzPjk1M9RzMahYOUkFDJiU8pRWXO2-np0HgQefxEC+WXeA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9F1E1B@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9F1E1B-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi, Pekon

2013/8/8 Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org>:
>>
>> Hi,Trent
>>
>> Thanks for so many details.
>> 2013/7/30 Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> > On Mon, Jul 29, 2013 at 7:21 AM, Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org> wrote:
>> >>> >>                       spi->mode |= SPI_CS_HIGH;
>> >>> >>               if (of_find_property(nc, "spi-3wire", NULL))
>> >>> >>                       spi->mode |= SPI_3WIRE;
>> >>> >> +             if (of_find_property(nc, "spi-tx-dual", NULL))
>> >>> >> +                     spi->mode |= SPI_TX_DUAL;
>> >>> >> +             if (of_find_property(nc, "spi-tx-quad", NULL))
>> >>> >> +                     spi->mode |= SPI_TX_QUAD;
>> >>> >> +             if (of_find_property(nc, "spi-rx-dual", NULL))
>> >>> >> +                     spi->mode |= SPI_RX_DUAL;
>> >>> >> +             if (of_find_property(nc, "spi-rx-quad", NULL))
>> >>> >> +                     spi->mode |= SPI_RX_QUAD;
>> >>> >>
>> >>> >  [Pekon] I think its cleaner to use similar parameters for channel-width
>> >>> >  info everywhere. Like you have added separate fields  'tx_nbits' and
>> >>> >  'rx_nbits' in spi_transfer, Why not do similar here for 'spi_master' ?
>> >
>> > There are I think a total of five places that channel width can be
>> > used in the Linux SPI stack.
>> >
>> > a) In the master driver (spi_master)
>> > b) In a slave driver (spi_device)
>> > c) In a spi_message
>> > d) In a spi_transfer
>> > e) In the OF device tree, for DT nodes of a and/or b, as they appear in the
>> dt.
>> >
> [Pekon]: Just to be aligned here..
> (a) master_driver (spi_master) == like spi/spi-omap2-mcspi.c .. correct ?
> (b) slave_driver (spi_device) ==  like mtd/devices/m25p80.c .. correct ?
>
Yes, that's it.

>> > For a, all the widths supported would be specified.  In b, c, and d,
>> > only the width to be used would be specified.  So, there is some
>> > difference here, as we need a method that allows multiple modes to be
>> > specified for a but not for the others.
>> >
>> > Since some slaves will want to send a single spi message with multiple
>> > transfers of different widths (e.g., single bit read command followed
>> > by quad bit data xfer) it's necessary to specify the width in d.  With
>> > the widths specified at the lowest level, it is not actually necessary
>> > to supply the width for C or B.
>> >
> [Pekon]: Agreed.. This proposal is better of having..
> (b) spi_device->mode = SPI_RX_QUAD | SPI_TX_SINGLE;
> (c) spi_transfer.tx_nbits = 4; spi_transfer.rx_nbits = 4;
>
>> > While it's not necessary to specify the width for B, doing so would be
>> > consistent with other fields that can be specified in the spi_transfer
>> > and in the spi_device, like bits_per_word and speed_hz.  It's worth
>> > pointing out that none of the mode bits from the spi_device can be
>> > specified in in a spi_transfer.  Currently, if you want to change
>> > anything in mode you must call spi_setup() on the device.  Since width
>> > can be changed on a transfer by transfer basis, maybe that is a good
>> > reason to say it doesn't belong in mode.
>> >
>> what you said is ok. But b) and d) are not the same. d) will be set
>> based on b), but not equal to d)=b)(bits_per_word and speed_hz). So
>> don't you think that b) is more like a transfer mode and d) is the
>> detailed functions related to the mode. Also b) should be set in
>> spi_setup(), only d) width can be changed by transfer, but b) should
>> not be modifyed. But none of the mode bits from the spi_device can be
>> specified in in a spi_transfer, that is a point. Is that necessary to
>> add members like "transfer_mode" in spi_master and spi_device which do
>> the similar operation to "mode"?
>>
> [Pekon]: I did not fully understand your comments, But following
>  is my understanding of DT parsing.
>  There should two level of DT binding
> (a) For SPI controller:
> - describes the capabilities of H/W engine on SoC
> - goes into spi_master->mode
> (b) For SPI devices:
> - describes capabilities of each device on board (includes board
>    wire connections. (single controller can be connected to many SPI devices)
> - goes into spi_device->mode, by matching common compatibilities
>  between spi_master and spi_device_n
>
> This is important for where multiple SPI devices are connected to
> one controller which supports all modes (SINGLE, DUAL, QUAD) But;
> -  /dev/spi0 can have all 4 data-outputs connected on board
>    so can support QUAD mode
> - /dev/spi1 has only 2 data-outputs connected on board
>    so can support only SINGLE | DUAL
>
> So, you have defined DT bindings for (b) only.
> You need to add DT binding for (a) also.
>
well, if the final scheme is to make dual and quad in mode, I agree
with your point.

>> > If the default width is in the spi_device, then a spi_transfer needs a
>> > width state to mean "unspecified".  I.e., the read width can be one,
>> > two, four, (eight), or unspecified bits.  Unspecified gets changed to
>> > the default from the spi_device, whereas one bit wide means one bit
>> > wide.
>> >
>> what do you mean by default, is that without init value? Do you want
>> to use bit by bit in spi_transfer?
>>
> [Pekon]: So default here means common basic capability which all
> devices are expected to meet at-least.
> And I think this is SPI_SINGLE_FULL_DUPLEX mode.
>
If so, I still can not figure out what Trent means. Is that if
spi_device select the default mode, then we need to give
spi_transfer(tx_nbits and rx_nbits) a init value to make it not
unspecified?

>> > Allowing the spi_device to have a width means the width can be checked
>> > against the master's supported widths at spi_setup() time, like the
>> > other mode bits.  But, since width can be set on a transfer by
>> > transfer basis and each transfer is not checked in the spi core, this
>> > doesn't really do the master driver much good.  The master driver
>> > still needs to check each transfer to see if the width is allowed.
>> >
>> agree. so do it in __spi_async() and to make sure that spi_transfer <=
>> spi_device.
>>
>> > I don't see the point of putting the width in C.  Current a
>> > spi_message can't change any of the settings from the spi_device or
>> > supply a default for the the settings in a spi_transfer, and I don't
>> > see why width is any different here.
>> >
> [Pekon]: Agreed.. if you are already adding tx_nbits & rx_nbits in
> spi_transfer, then you don't need to add same in spi_message.
> (at-least not for now).
>
>> > For the OF device tree, I don't think the master's node should have
>> > anything about the widths supported.  There is nothing about any of
>> > the other spi master capabilities in the DT.  The master driver
>> > supplies this information.
>> >
> [Pekon]: Nope not correct. See example above of having multiple
> SPI devices connected to same controller.
>
>> > For the OF slave device node, it's not clear it needs to be there
>> > either.  The current existing use cases are for memories that only use
>> > dual and quad for certain parts of certain commands.  Setting the
>> > width for the slave overall doesn't make sense.
>> >
>> > But, the memory might have four data lines connected on the board or
>> > it might just have one.  That does seem like information about board
>> > layout that belongs in the device tree.  So there does need to be done
>> > "enable quad mode" property.  However, is this a SPI property or a
>> > property of the memory device's driver?  Turning on quad mode support
>> > isn't the same that as setting the clock polarity.  Clock polarity it
>> > a SPI property supplied to spi_setup.  Quad mode means the driver
>> > should use the quad read command and the appropriate spi_transfers for
>> > using it.
>> How to set DT depend on whether to seperate the dual and quad from
>> mode.
>>
> [Pekon] you need separate DT binding for controller and child devices.
> And then separate for Tx and Rx in each of them.
> Also, I suggest you add devicetree-discuss maillist when you update the
> Device-tree documentation for same.
>
Just as you said above, master node describe the total data wires on
SOC, slave node describe the detailed capability selected, which is
logically right. But to master, the drivers have already supplied this
infomation in probe, so do we still need to add in device tree and
provide another method in master driver to get the info from device
tree?

> I havn't seen any traffic on next version of this patch?
>  Did I miss, or you are working on it?
>
No, because of other jobs so didn't fix the patch in time, sorry for
that. Even now I still in puzzled that whether to make quad in mode or
add a new member in all the related struct. My trend is the previous
scheme. However they both have strong and weak points.

If add in mode:
[strong points]:
The existed operation such as compare master mode and device mode, DT
interface, mode set in master driver and so on which will be a benifit
to make the quad code clear and smooth.
[weak points]
But to expand mode will make spidev not back compatible and the
modified spidev code to fix the compatible problems looks a little
wierd.
Also another point from Trent, to make it consistent between
spi_transfer and spi_device. just like:
spi_transfer->speed_hz depend on spi_device->speed_hz;
spi_transfer->bits_per_word depends on spi_device->bits_per_word;
So is that add the similar member as below looks better?
spi_transfer->tx_nbits depends on spi_device->tx_nbits not spi_device->mode.

if add new member:
The previous strong points and weak points will become exchanged.

I still hope some suggestions to make one scheme extremely powerful
and I will provide the patch this week.

Best regards.

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
