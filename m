From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] spi: Push the BKL down into the
	drivers
Date: Fri, 23 May 2008 12:09:48 +0100
Message-ID: <20080523120948.4b992d67@core>
References: <20080522224509.29ede566@core>
	<200805221740.51016.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805221740.51016.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 22 May 2008 17:40:50 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> On Thursday 22 May 2008, Alan Cox wrote:
> > Another step to removing ->ioctl and to removing the BKL
> 
> This happens to not apply with the latest patches; I'll
> address that.
> 
> Where is the writeup about exactly what lock_kernel() is
> supposed to have been protecting against in ioctl code?

There isn't one. The big problem we have is that the ioctl methods were
implicitly called under the big kernel lock. Without pushing them down
into drivers we can't take the step of actually thinking at the driver
level "is this needed". Historically therefore we've never documented
*why* or *if* it was needed - it's just there. Pushing them into the
driver means the subsystem owner gets to see the implicit locking and can
actually ask the right questions with internal driver knowledge.

Whether it is needed is dependant on the internal locking model of the
driver - does it handle parallel ioctls correctly, are there races
against other functions in the driver (eg hot unplugs). That can't be
evaluated at a high level.

It's also made harder by the fact lots of drivers have buggy assumptions
about ioctl locking (watchdog was a fine example).

Alan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
