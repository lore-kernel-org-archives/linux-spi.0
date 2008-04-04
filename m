From: Josh Boyer <jwboyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH]  jffs2 summary allocation
Date: Fri, 04 Apr 2008 18:21:22 -0500
Message-ID: <1207351282.3224.79.camel@vader.jdub.homelinux.org>
References: <713171.37644.qm@web26213.mail.ukl.yahoo.com>
	<20080404124812.d39fa640.akpm@linux-foundation.org>
	<200804041609.41092.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Michael Trimarchi <trimarchimichael-whZMOeQn8C0@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804041609.41092.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Fri, 2008-04-04 at 16:09 -0700, David Brownell wrote:
> On Friday 04 April 2008, Andrew Morton wrote:
> 
> > I'm assuming from the trace that the arm code tried to put that memory
> > under DMA (or at least, passed it into part of the DMA management code to
> > get the various caches sorted out) and that the arm DMA support code
> > doesn't like being given vmalloced memory.
> 
> Actually, Documentation/DMA-Mapping.txt has a section right up
> front called "What memory is DMA'able?" ... which despite its
> ungrammatical title, says clearly:
> 
>   ... This means specifically that you may _not_ use the
>   memory/addresses returned from vmalloc() for DMA.  ...
> 
> So I'm rather surprised to see *ANY* kernel code trying to do
> that.  That rule has been in effect for many, many years now.

I don't think it was intentional.  You're going through several layers
here:

JFFS2 -> mtd parts -> mtd dataflash -> atmel_spi.

Typically MTD drivers aren't doing DMAs to flash and JFFS2 has no idea
which particular chip driver is being used because it's abstracted by
MTD.

josh


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
