From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Quick questions regarding the SPI interface
Date: Fri, 05 Apr 2013 13:44:10 -0700
Message-ID: <515F379A.8090006@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi!

I am trying to drive the spi driver of the raspberry-pi towards a fully DMA driven interface and have come a few open points that - as far as I can tell - are not specified detail in the documentation or header-files.

1) is the spi callback blocking further actions on the spi-bus until it is returns, or can other (asyncronously) scheduled spi transactions happen while the callback occurs (or is still pending)?
2) is a callback allowed to sleep (so it can not get run from a "normal" Irq-handler-context - i.e non-threaded IRQ)?
3) are there any absolute requirements on the sequence of callbacks or could reordering occur?
4) does a spi_transfer require a payload(Len>0) when a delay is set? (that way "defined" delays could get used for sampling with an ADC or similar)

All these answers are needed to get the spi-driver working in a fully pipelined dma mode and stay compatible with existing device-drivers that make use of the asynchronous interface.

My interpretation right now are:

ad 1) no, as it is an asynchronous interface, so we have to assume that there can be bus activity.
ad 2) there are advantages to both - in interrupt-context the callback could schedule other spi_async transaction with minimal overhead (no task-switching required). But on the other hand there may be existing drivers that would break with this in place (as they might sleep in the callback for example).  Alternatively the driver would need to add a task to a work-queue or similar instead - this obviously means more latencies. Maybe an additional flag in spi_message signifying the callback is not sleeping (say callback_irqsafe), would be needed to get "best" of both worlds? Short-term this could get done via a module parameter.
ad 3) this essentially means if the callback needs to get implemented with a single global system queue or if per-CPU specific queues would be permissible.
ad 4) I think that len may be 0 - if this is used in conjunction with an ADC, then a delay could get configured this way without a CS asserted. My thought for the DMA driver of the RPI  (which can daisy-chain different kinds of DMA transfer) was actually to "abuse" a DMA transfer of a Memory-page to a null sink to get those "exact" delays implement without the need for the CPU to get involved at all - this way for example a sample-rate can get very well controlled getting close to real-time performance with regards to jitter and more...

Can you please give me your thoughts on these before I start implementing the next revision of the DMA enabled driver for the RPI hardware?

It may also be of interest to document (some of) the answers for the above in spi.h for further reference.

Thanks,
                 Martin


------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
