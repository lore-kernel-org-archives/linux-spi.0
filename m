From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Mon, 15 Oct 2007 17:22:11 -0700
Message-ID: <20071016002211.6F45E23BCEC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <00bc01c80f45$9d218980$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org,
	girishsg-l0cyMroinI0@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00bc01c80f45$9d218980$6a8918ac-tAZopdYwApTQT0dZR+AlfA@public.gmane.org>
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

> From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
> Date: Mon, 15 Oct 2007 21:38:22 +0530
>
> >The first task is to come up with a workable design.  Then would
> >come implementing it.
> >
> >
> >A second issue is how to factor the programming interface.  The
> >notion of an spi_message isn't necessarily wrong, but when should
> >it get issued?  How would commands sent by the host be packaged?
> >How should chipselect/deselect be visible?
>
> I was looking for such discussion to be started on this thread from quite
> some time.

You should feel free to start such stuff yourself, you know ... :)


> Well, in my case, I have SPI hardware which can work in Master and Slave
> mode as well.

That seems moderately common, even for non-microcontroller hardware.

For some reason, chip vendors don't design hardware with assumptions
that they've got to stick with (current) Linux limitations ... they
even (gasp!) allow for a variety of custom RTOS environments!  ;)


>	Specifically speaking, Slave mode capabilities are as same as
> Master mode. Only major difference is in chipselect and clock generation.

And the interaction model.  Masters choose when to interact with
the hardware to send messages ... slave must react to those
choices, e.g. by seeing that they've been selected/deselected
and by processing the data they've been fed.  Plus, there are
faults that can appear only in slave mode (notably, "data arrived
but nobody was listening").


> As such, in this case, notion of spi_message would definitely hold good for
> both and also to some extent the whole stack which exists today.

Yes, but how is that message used?  One common scenario would be to
have one message which reads the first N bytes (while transmitting
something ... ones, zeroes, the last sample, whatever), then interpret
those bytes as a command used to decide what a second message should
do.  That is, while a master might issue one request/response message,
the slave would need to manage that same interaction as two messages.


> I see in community, some use SPI slave for minimal functionality. As I
> understand, we have to have a stack support for
> 1. SPI in slave side transaction (as similar as Master's).
> 2. SPI in slave side transaction with minimal functionality.

> I don't know how the latter one is.

I think that the current "minimal functionality" example is sample
data streaming ... where there's always a message queue, and where
the channel is never deselected.  I think it's fair to say that is
not a typical application for SPI.


>	But, in my case I was able to modify
> the controller driver to work for Master/Slave with full transaction
> without any stack changes. I know this is bad, as stack would never come to
> know about the slave side transaction :).
> I would like to know the best way we can make the stack know slave side
> transaction happening?

Well, you said that you already did it.  What did you do?

If I were to do that, I'd have a "spi_slave" struct wrapping the
hardware, and drivers would normally keep some kind of message
posted to it.  Events visible to the slave driver would be the
completion of a message (standard callback) and slave deselect
(which might well terminate the pending message queue) ... also
RX underrun (e.g. when there was no buffer for incoming data).

I'd also spend time analysing interaction models.  The one I
sketched above is basic request/response.  There would also be
ways to stream data in one or two directions.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
