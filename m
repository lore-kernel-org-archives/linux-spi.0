From: chri <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI device driver suspend
Date: Sat, 29 Dec 2007 08:40:25 +0100
Message-ID: <cabda6420712282340h61fee210t7a9bdba8e385c827@mail.gmail.com>
References: <cabda6420712280451x59e87ed5xef5cbe4002e84cde@mail.gmail.com>
	<200712281021.40429.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200712281021.40429.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Dec 28, 2007 7:21 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>
> Hmm, I thought that create_singlethread_workqueue() was
> supposed to create non-freezable workqueues ... which won't
> be stopped before the suspend() callback dance begins.
>
> Are you sure that's the reason for your deadlock?  Did you
> turn on all the debug options and have the kernel report
> to you that's what was happening?
>


Sorry for the noise, you are completely right. The problem was mine
trying to flush the workqueue I created in the driver. Without that
everything is all right. I learned that before suspend workqueues
should be just left alone.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
