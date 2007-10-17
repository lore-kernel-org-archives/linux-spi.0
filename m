From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Wed, 17 Oct 2007 19:30:03 +0530
Message-ID: <01b001c810c6$053fdea0$6a8918ac@ent.ti.com>
References: <20071016175920.7FA2923BCED@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20071016175920.7FA2923BCED-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



>-----Original Message-----
>From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
>Sent: Tuesday, October 16, 2007 11:29 PM
>To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org;
>girishsg-l0cyMroinI0@public.gmane.org
>Subject: Re: [spi-devel-general] Status of Linux SPI slave

>
>> Now we are changing the role what the SPI controller and the device is
>> playing. SPI controller will now work as slave and device will be master
>to
>> the slave SPI controller.

>I don't follow that comment.  What do you mean when you say "device"?

Ok, I am adhering to the convention specified in
Documentation/spi/spi-summary. We know that SPI controller driver is a
master controller driver and spi protocol driver is for slave device.
(e.g., TouchScreen will have a spi protocol driver and registers to stack
with spi_driver_register() ). When I say "device" I meant SPI device (which
is slave device for SPI master controller driver).

Now, if the exisiting SPI controller driver (Which is a master controller
as of now) is modified to work in slave, then we would be having a Slave
SPI controller driver and spi device would be a master. I hope this time
I'm making myself clear :D.

>
>I'm guessing I will disagree with your comment about being master to
>the slave.  There's only one master in the system, and it's not on the
>slave side.  The slave driver must *REACT* to the master, which is why
>I said the interaction model must be different.

Yes, agreed about interaction model part.
Ok, to be clearer. I will be having a SPI slave controller registering to
stack (Assuming Stack gives me spi_slave framework). Now, how does the
protocol driver should fit in? It would still be for spi device(which will
be a master). Right? This is what I meant.


>> I had to only take care of module control registers and to deactivate
>the
>> cs0 between spi words as required by slave. And also correct
>configuration
>> of mosi/simo lines for slave.
>
>I'm still not following what you're saying here.  By definition, a
>slave has no control of chipselect ... the master manages that signal.
>
Actually, I have used the default master controller driver and modified it
to work as slave controller driver. So, I had to remove the asserting of
spi_cs between words which guess only works for master mode. This is what I
meant.

>Configuration of MOSI and MISO lines sounds like what you've actually
>got is DI and DO lines, which would need to be manually interchanged
>if the M and S roles change.  If the signal lines are true MOSI and
>MISO, the signal direction would change by the internal M/S switch.
>
Yes.

>
>Any badly written software can have redudant code.  :)
>
I was just contemplating how much code can be reused for slave support in
stack :)

>
>Slave support in a SOC is, I've assumed, mostly used with
>custom chip-to-chip communications.
>

Ok.


And ya, It would be better if I list down some points from top of my head,
it will make me clear. Following things done for slave;

1. Make SPI controller work in Master and Slave. There won't be any
separate controller driver for slave. (As of now there is no support from
stack, so stack will be blind about slave transaction)

2. Protocol driver will still register as spi_driver. No change here, only
difference is that the underlying device would be a master device and in
spi_board_info table it will populate a SPI controller info which will be
working as slave.

3. One more thing I wanted to ask was about spi_setup(). How about
supporting selecting/deselecting SPI mode (master/slave) through
spi_setup()? We can make protocol driver free enough to override selection
of SPI mode(master/slave).

4. If only single controller driver is used for Master/Slave, then by
default it should be registering as Master/slave with stack?

Actually, I have couple of slave model floating in my mind with lots of
questions :). I think I'll go back and try to understand more about
transaction model required in slave, so that I can consolidate things upon
that.

Regards,
Girish





-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
