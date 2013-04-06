From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Quick questions regarding the SPI interface
Date: Sat, 6 Apr 2013 18:22:27 +0100
Message-ID: <CACxGe6sNCdcj15AEFyXu3mfQ+icPVj058aLsKByr0hxHR+YsFw@mail.gmail.com>
References: <515F379A.8090006@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <515F379A.8090006-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 5, 2013 at 9:44 PM, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:
> Hi!
>
> I am trying to drive the spi driver of the raspberry-pi towards a fully DMA
> driven interface and have come a few open points that - as far as I can tell
> - are not specified detail in the documentation or header-files.
>
> 1) is the spi callback blocking further actions on the spi-bus until it is
> returns, or can other (asyncronously) scheduled spi transactions happen
> while the callback occurs (or is still pending)?
> 2) is a callback allowed to sleep (so it can not get run from a "normal"
> Irq-handler-context - i.e non-threaded IRQ)?

Which callback? The mesg->complete() callback? or the .transfer or
.transfer_one_message callbacks provided by the spi bus driver?

The ->complete() callback should not sleep because it may be running
in an atomic context in the spi bus driver.

The .transfer_one_message() callback can either sleep or return
immediately. For DMA driven transfers, you'll probably want to return
immediately and handle the message completion in the irq handler. A
new transaction can indeed be initiated before the complete() callback
on the preceeding transaction has actually been called. If a device
needs to have exclusive access to the bus then there is a separate bus
lock feature in the SPI infrastructure. The MMC subsystem uses this.

If the driver is still using .transfer, then you really should move to
.transfer_one_message(). It is much better and well documented in
Documentation/spi/spi-summary (look to the end of the file).

> 3) are there any absolute requirements on the sequence of callbacks or could
> reordering occur?

It is feasable for reordering of the completion callbacks to occur if
multiple requests are queued, but the SPI transactions themselves must
not be reordered.

> 4) does a spi_transfer require a payload(Len>0) when a delay is set? (that
> way "defined" delays could get used for sampling with an ADC or similar)

Hmmm, I don't think anyone has done that. Why wouldn't the delay be
made part of the preceding spi_transfer?

>
> All these answers are needed to get the spi-driver working in a fully
> pipelined dma mode and stay compatible with existing device-drivers that
> make use of the asynchronous interface.
>
> My interpretation right now are:
>
> ad 1) no, as it is an asynchronous interface, so we have to assume that
> there can be bus activity.
> ad 2) there are advantages to both - in interrupt-context the callback could
> schedule other spi_async transaction with minimal overhead (no
> task-switching required). But on the other hand there may be existing
> drivers that would break with this in place (as they might sleep in the
> callback for example).  Alternatively the driver would need to add a task to
> a work-queue or similar instead - this obviously means more latencies. Maybe
> an additional flag in spi_message signifying the callback is not sleeping
> (say callback_irqsafe), would be needed to get "best" of both worlds?
> Short-term this could get done via a module parameter.

Use .transfer_one_message. All of the above is handled transparently
and the spi_bus driver can choose to either sleep in
transfer_one_message and handle all phases in that context, or return
immediately and finalize the transaction in the interrupt handler. It
also means the driver doesn't need to implement any of the workqueue
stuff.

> ad 3) this essentially means if the callback needs to get implemented with a
> single global system queue or if per-CPU specific queues would be
> permissible.
> ad 4) I think that len may be 0 - if this is used in conjunction with an
> ADC, then a delay could get configured this way without a CS asserted. My
> thought for the DMA driver of the RPI  (which can daisy-chain different
> kinds of DMA transfer) was actually to "abuse" a DMA transfer of a
> Memory-page to a null sink to get those "exact" delays implement without the
> need for the CPU to get involved at all - this way for example a sample-rate
> can get very well controlled getting close to real-time performance with
> regards to jitter and more...
>
> Can you please give me your thoughts on these before I start implementing
> the next revision of the DMA enabled driver for the RPI hardware?
>
> It may also be of interest to document (some of) the answers for the above
> in spi.h for further reference.
>
> Thanks,
>                 Martin
>



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
