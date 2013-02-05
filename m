From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: use request_threaded_irq() to fix deadlock
Date: Tue, 05 Feb 2013 17:13:33 +0000
Message-ID: <20130205171333.B4D483E0D17@localhost>
References: <1356120806-27964-1-git-send-email-m-karicheri2@ti.com>
	<20121222100803.88FCE3E0AD0@localhost> <50E44FEC.3080009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-ypw0egVD2fIeQtMskbmMgg@public.gmane.org>
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <50E44FEC.3080009-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2 Jan 2013 10:19:08 -0500, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> On 12/22/2012 05:08 AM, Grant Likely wrote:
> > On Fri, 21 Dec 2012 15:13:26 -0500, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>  wrote:
> >> With RT pre-empt patch applied to Linux kernel, the irq handler will be
> >> force converted to an irq thread. spi driver can get back to back messages
> >> from the slave device. In such cases, IRQ thread doesn't get a chance to
> >> run to read the slave data. Hence the irq handler must be run in hard irq
> >> context to read/write data from slave device. Otherwise, the kernel goes
> >> into a deadlock. This patch fixes this issue when PREEMPT_RT_FULL is
> >> enabled in the kernel. A dummy thread function is provided to satisfy the
> >> request_threaded_irq() API. Passing a NULL for function also causes the
> >> irq handler to be executed in the thread context.
> >>
> >> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
> > Thomas, would you mind taking a look at this for me. My gut feel is that
> > this is the wrong way to solve the problem that Murali is having and
> > that it really just hacks something that works.
> Grant,
> 
> Thanks for reviewing this. As per the RT patch, all of the IRQ handlers 
> will be converted to thread by brute force. This breaks the SPI driver 
> since the data is overwritten with back to back irq as thread is not 
> getting a chance to read the word before next irq happens.  What my 
> patch does is to keep the functionality as before by using a new irq 
> API. So though this is not the best solution, this solves the problem 
> and give an opportunity for improvement by splitting this into two part 
> to handle the irq. But I am not convinced if this is really needed.

Okay. Applied, thanks.

g.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
