From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: refactor spi-coldfire-qspi to use SPI queue
	framework.
Date: Fri, 11 May 2012 14:03:25 +0530
Message-ID: <CAM=Q2cuxbUcXUz6iQFoYfU8xmFXvNtiVxrBAjPE9u34wNnrAbw@mail.gmail.com>
References: <201205100926.55444.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201205100926.55444.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Steven,

On Thu, May 10, 2012 at 9:56 PM, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org> wrote:
> Use the new SPI queue framework; remove use of workqueue, replace
> mcfqspi_transfer with mcfqspi_transfer_one_message, add
> mcfqspi_prepare_transfer_hw and mcfqspi_unprepare_transfer_hw, update power
> management routines.

By update are you attempting to convert to runtime framework also?

>

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
