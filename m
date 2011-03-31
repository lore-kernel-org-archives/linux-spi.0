From: "Du, Alek" <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] spi/dw_spi: change poll mode transfer from byte
	ops to batch ops
Date: Thu, 31 Mar 2011 20:54:30 +0800
Message-ID: <20110331205430.133b8497@dxy2>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-4-git-send-email-feng.tang@intel.com>
	<20110331105448.0f6d0bd4@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110331105448.0f6d0bd4-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 31 Mar 2011 17:54:48 +0800
Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Wed, 30 Mar 2011 23:09:54 +0800
> Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > Current poll transfer will read/write one word, then wait till the
> > hw is non-busy, it's not efficient. This patch will try to read/write
> > as many words as permitted by hardware FIFO depth.
> 
> This is reported to cause a regression on internal testing. It's one of
> that set of changes which seems to be breaking the touchscreen.
> 

What's kind of touchscreen? Just do not understand how they are related.
You can see this patch only try to fill the TX FIFO more efficiently.


> Should we get that resolved before these go upstream ?


------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
