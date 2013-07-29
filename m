From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: DUAL and QUAD support
Date: Mon, 29 Jul 2013 16:26:38 -0700
Message-ID: <CA+7tXijduVqFdao3L3oJcFBYw_cffdyo-fwyAS2cBASfEMExpA@mail.gmail.com>
References: <20130729064234.GS9858@sirena.org.uk>
	<1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
	<CAHSAbzNdvgTSPqDPHT2n3zXFwe7HBqTfyk4fB_-GsW1WSUXqRA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE356@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9EE356-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 29, 2013 at 7:21 AM, Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org> wrote:
>> >>                       spi->mode |= SPI_CS_HIGH;
>> >>               if (of_find_property(nc, "spi-3wire", NULL))
>> >>                       spi->mode |= SPI_3WIRE;
>> >> +             if (of_find_property(nc, "spi-tx-dual", NULL))
>> >> +                     spi->mode |= SPI_TX_DUAL;
>> >> +             if (of_find_property(nc, "spi-tx-quad", NULL))
>> >> +                     spi->mode |= SPI_TX_QUAD;
>> >> +             if (of_find_property(nc, "spi-rx-dual", NULL))
>> >> +                     spi->mode |= SPI_RX_DUAL;
>> >> +             if (of_find_property(nc, "spi-rx-quad", NULL))
>> >> +                     spi->mode |= SPI_RX_QUAD;
>> >>
>> >  [Pekon] I think its cleaner to use similar parameters for channel-width
>> >  info everywhere. Like you have added separate fields  'tx_nbits' and
>> >  'rx_nbits' in spi_transfer, Why not do similar here for 'spi_master' ?

There are I think a total of five places that channel width can be
used in the Linux SPI stack.

a) In the master driver (spi_master)
b) In a slave driver (spi_device)
c) In a spi_message
d) In a spi_transfer
e) In the OF device tree, for DT nodes of a and/or b, as they appear in the dt.

For a, all the widths supported would be specified.  In b, c, and d,
only the width to be used would be specified.  So, there is some
difference here, as we need a method that allows multiple modes to be
specified for a but not for the others.

Since some slaves will want to send a single spi message with multiple
transfers of different widths (e.g., single bit read command followed
by quad bit data xfer) it's necessary to specify the width in d.  With
the widths specified at the lowest level, it is not actually necessary
to supply the width for C or B.

While it's not necessary to specify the width for B, doing so would be
consistent with other fields that can be specified in the spi_transfer
and in the spi_device, like bits_per_word and speed_hz.  It's worth
pointing out that none of the mode bits from the spi_device can be
specified in in a spi_transfer.  Currently, if you want to change
anything in mode you must call spi_setup() on the device.  Since width
can be changed on a transfer by transfer basis, maybe that is a good
reason to say it doesn't belong in mode.

If the default width is in the spi_device, then a spi_transfer needs a
width state to mean "unspecified".  I.e., the read width can be one,
two, four, (eight), or unspecified bits.  Unspecified gets changed to
the default from the spi_device, whereas one bit wide means one bit
wide.

Allowing the spi_device to have a width means the width can be checked
against the master's supported widths at spi_setup() time, like the
other mode bits.  But, since width can be set on a transfer by
transfer basis and each transfer is not checked in the spi core, this
doesn't really do the master driver much good.  The master driver
still needs to check each transfer to see if the width is allowed.

I don't see the point of putting the width in C.  Current a
spi_message can't change any of the settings from the spi_device or
supply a default for the the settings in a spi_transfer, and I don't
see why width is any different here.

For the OF device tree, I don't think the master's node should have
anything about the widths supported.  There is nothing about any of
the other spi master capabilities in the DT.  The master driver
supplies this information.

For the OF slave device node, it's not clear it needs to be there
either.  The current existing use cases are for memories that only use
dual and quad for certain parts of certain commands.  Setting the
width for the slave overall doesn't make sense.

But, the memory might have four data lines connected on the board or
it might just have one.  That does seem like information about board
layout that belongs in the device tree.  So there does need to be done
"enable quad mode" property.  However, is this a SPI property or a
property of the memory device's driver?  Turning on quad mode support
isn't the same that as setting the clock polarity.  Clock polarity it
a SPI property supplied to spi_setup.  Quad mode means the driver
should use the quad read command and the appropriate spi_transfers for
using it.

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
