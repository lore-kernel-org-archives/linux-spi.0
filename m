From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI device driver suspend
Date: Fri, 28 Dec 2007 10:21:40 -0800
Message-ID: <200712281021.40429.david-b@pacbell.net>
References: <cabda6420712280451x59e87ed5xef5cbe4002e84cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: chri <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cabda6420712280451x59e87ed5xef5cbe4002e84cde-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

On Friday 28 December 2007, chri wrote:
> Hi,
> 
> I'm facing a problem with a driver for a SPI device: I think the
> problem may be more general or perhaps I'm just missing something
> obvious. I want to put a SPI device to sleep and this is done by
> sending a command on the SPI bus. The first place I tried is the
> suspend callback of struct spi_driver.

That's certainly supposed to work ...


> That didn't work, the system 
> deadlocked on suspending (by writting mem to /sys/power/state). I
> guess the reason is that the SPI master driver uses bit banging code
> that relies on workqueues, which are kernel threads that are stopped
> before the suspend callback is invoked. Does this make sense or I'm
> doing something wrong? Any pointer to devices with similar needs for
> going to sleep that I may study?

Hmm, I thought that create_singlethread_workqueue() was
supposed to create non-freezable workqueues ... which won't
be stopped before the suspend() callback dance begins.

Are you sure that's the reason for your deadlock?  Did you
turn on all the debug options and have the kernel report
to you that's what was happening?

- Dave


> 
> Thanks!
> 
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
