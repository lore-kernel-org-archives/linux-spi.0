From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Tue, 16 Oct 2007 10:59:20 -0700
Message-ID: <20071016175920.7FA2923BCED@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <014101c80ffb$917d1200$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org,
	girishsg-l0cyMroinI0@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <014101c80ffb$917d1200$6a8918ac-tAZopdYwApTQT0dZR+AlfA@public.gmane.org>
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

> >And the interaction model.  Masters choose when to interact with
> >the hardware to send messages ... slave must react to those
> >choices, e.g. by seeing that they've been selected/deselected
> >and by processing the data they've been fed.  Plus, there are
> >faults that can appear only in slave mode (notably, "data arrived
> >but nobody was listening").
>
> Yes, the faults you mentioned should be taken care. And I think these
> faults would depend upon the type of device connected to slave spi. I think
> am not missing anything.

No, that particular fault would depend on whether the driver
provides adequate response time.  A master clocking data too
fast for the slave to keep up might cause such issues.


> >Yes, but how is that message used?  One common scenario would be to
> >have one message which reads the first N bytes (while transmitting
> >something ... ones, zeroes, the last sample, whatever), then interpret
> >those bytes as a command used to decide what a second message should
> >do.  That is, while a master might issue one request/response message,
> >the slave would need to manage that same interaction as two messages.
>
> I think interaction model shouldn't change drastically except couple of
> points you mentioned. As I understand, the spi device usually takes care of
> the interaction needed. I mean, once the command comes on mosi the device
> will reply to it as per its convention. As such SPI controller driver
> wouldn't worry about that, it only does the transfer/receive.

SPI devices usually implement a state machine which resets when the
chip deselects.  The controlelr driver would need to change in order
to expose that to the slave driver...


> Now we are changing the role what the SPI controller and the device is
> playing. SPI controller will now work as slave and device will be master to
> the slave SPI controller.

I don't follow that comment.  What do you mean when you say "device"?

I'm guessing I will disagree with your comment about being master to
the slave.  There's only one master in the system, and it's not on the
slave side.  The slave driver must *REACT* to the master, which is why
I said the interaction model must be different.


>	If my understanding is right then, in this
> scenario too the device will take care of interpreting the data on somi.
> I mean in either case the SPI controller will only do the transfer
> functionality. Interpreting the data will be done by device interface,
> irrespective of its mode (master/slave).

Again, I don't follow.  Interpreting the data is in a layer above
the device controller driver, certainly ... but what "device"?


> >Well, you said that you already did it.  What did you do?
>
> I had to only take care of module control registers and to deactivate the
> cs0 between spi words as required by slave. And also correct configuration
> of mosi/simo lines for slave.

I'm still not following what you're saying here.  By definition, a
slave has no control of chipselect ... the master manages that signal.

Configuration of MOSI and MISO lines sounds like what you've actually
got is DI and DO lines, which would need to be manually interchanged
if the M and S roles change.  If the signal lines are true MOSI and
MISO, the signal direction would change by the internal M/S switch.


> As such there was no real use case for testing SPI controller in slave
> mode. I had to use two SPI on the board connected externally with wires,
> making one as Master and other as slave. And pump data from slave/master.
> Yes, we can't rely on externally connected wires for data integrity on
> higher speed. This was more like a plane test scenario with not much
> interpreting of the data.

Sounds like what I might call a concept or breadboard demo.
I've done that, but saw signal glitching with 18 MHz signals.


>	Assuming interpreting the data would be taken
> care by the actual device connecting to SPI.
>
> >If I were to do that, I'd have a "spi_slave" struct wrapping the
>
> So, you mean to say that the controller driver would register with stack
> using spi_slave structure? If we have this new structure then we need to
> have registering mechanism for spi_slave too. If am not wrong, on a whole
> there could be some redundant code across master/slave in stack. Hope I'm
> not missing anything here.

Any badly written software can have redudant code.  :)

The controller driver might have lots of internal code sharing;
basic data transfer logic would likely be the same.  What would
differ would be the control/interaction model.


> >hardware, and drivers would normally keep some kind of message
> >posted to it.  Events visible to the slave driver would be the
>
> Here "slave driver" is SPI controller driver?

No; using the terminology in Documentation/spi/spi-summary that'd
be a "slave protocol driver", not a "slave controller driver".


> >completion of a message (standard callback) and slave deselect
> >(which might well terminate the pending message queue) ... also
> >RX underrun (e.g. when there was no buffer for incoming data).
>
> Yes, this looks meaningful.

Good.  :)


> I am still thinking of the use case for SPI in slave mode. I haven't seen
> any device having Master SPI interface. I guess not even in community
> people seem to have such device. Just wondering is/can there be any such
> device which needs SPI controller in slave mode? I would be interested to
> know!

Again, what do you mean by "device"?  Off the shelf parts are
going to be either slave chips (EEPROM, flash, ADC, sensor,
UART, etc) or some kind of SOC.  SPI support on a SOCs usually
supports either master or slave role, with master mostly used
to talk to slaves (LCD panels, audio codec control, touchscreen,
flash, FPGA, etc).

Slave support in a SOC is, I've assumed, mostly used with custom
chip-to-chip communications.


> >I'd also spend time analysing interaction models.  The one I
> >sketched above is basic request/response.  There would also be
> >ways to stream data in one or two directions.
>
> Yes, and thanks for throwing light on this part of SPI, having good
> learning from you. :)

:)

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
