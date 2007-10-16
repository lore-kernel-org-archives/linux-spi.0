From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Tue, 16 Oct 2007 19:20:50 +0530
Message-ID: <014101c80ffb$917d1200$6a8918ac@ent.ti.com>
References: <20071016002211.6F45E23BCEC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20071016002211.6F45E23BCEC-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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
>Sent: Tuesday, October 16, 2007 5:52 AM


>That seems moderately common, even for non-microcontroller hardware.
>
>For some reason, chip vendors don't design hardware with assumptions
>that they've got to stick with (current) Linux limitations ... they
>even (gasp!) allow for a variety of custom RTOS environments!  ;)
>

I got it :). Then, as of today I think not much of slave side transaction
is needed by most of the RTOS, guess the use case is very limited.

>
>And the interaction model.  Masters choose when to interact with
>the hardware to send messages ... slave must react to those
>choices, e.g. by seeing that they've been selected/deselected
>and by processing the data they've been fed.  Plus, there are
>faults that can appear only in slave mode (notably, "data arrived
>but nobody was listening").

Yes, the faults you mentioned should be taken care. And I think these
faults would depend upon the type of device connected to slave spi. I think
am not missing anything.

>
>Yes, but how is that message used?  One common scenario would be to
>have one message which reads the first N bytes (while transmitting
>something ... ones, zeroes, the last sample, whatever), then interpret
>those bytes as a command used to decide what a second message should
>do.  That is, while a master might issue one request/response message,
>the slave would need to manage that same interaction as two messages.
>

I think interaction model shouldn't change drastically except couple of
points you mentioned. As I understand, the spi device usually takes care of
the interaction needed. I mean, once the command comes on mosi the device
will reply to it as per its convention. As such SPI controller driver
wouldn't worry about that, it only does the transfer/receive.
Now we are changing the role what the SPI controller and the device is
playing. SPI controller will now work as slave and device will be master to
the slave SPI controller. If my understanding is right then, in this
scenario too the device will take care of interpreting the data on somi.
I mean in either case the SPI controller will only do the transfer
functionality. Interpreting the data will be done by device interface,
irrespective of its mode (master/slave).

>
>I think that the current "minimal functionality" example is sample
>data streaming ... where there's always a message queue, and where
>the channel is never deselected.  I think it's fair to say that is
>not a typical application for SPI.
>
Ok, I got that.

>
>Well, you said that you already did it.  What did you do?
>
I had to only take care of module control registers and to deactivate the
cs0 between spi words as required by slave. And also correct configuration
of mosi/simo lines for slave.
As such there was no real use case for testing SPI controller in slave
mode. I had to use two SPI on the board connected externally with wires,
making one as Master and other as slave. And pump data from slave/master.
Yes, we can't rely on externally connected wires for data integrity on
higher speed. This was more like a plane test scenario with not much
interpreting of the data. Assuming interpreting the data would be taken
care by the actual device connecting to SPI.

>If I were to do that, I'd have a "spi_slave" struct wrapping the

So, you mean to say that the controller driver would register with stack
using spi_slave structure? If we have this new structure then we need to
have registering mechanism for spi_slave too. If am not wrong, on a whole
there could be some redundant code across master/slave in stack. Hope I'm
not missing anything here.

>hardware, and drivers would normally keep some kind of message
>posted to it.  Events visible to the slave driver would be the

Here "slave driver" is SPI controller driver?

>completion of a message (standard callback) and slave deselect
>(which might well terminate the pending message queue) ... also
>RX underrun (e.g. when there was no buffer for incoming data).
>
Yes, this looks meaningful.
I am still thinking of the use case for SPI in slave mode. I haven't seen
any device having Master SPI interface. I guess not even in community
people seem to have such device. Just wondering is/can there be any such
device which needs SPI controller in slave mode? I would be interested to
know!

>I'd also spend time analysing interaction models.  The one I
>sketched above is basic request/response.  There would also be
>ways to stream data in one or two directions.
>
Yes, and thanks for throwing light on this part of SPI, having good
learning from you. :)


Thanks and Regards,
Girish



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
