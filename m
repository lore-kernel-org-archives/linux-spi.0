From: Josh Boyer <jwboyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH]  jffs2 summary allocation
Date: Fri, 04 Apr 2008 20:11:10 -0500
Message-ID: <1207357870.3224.89.camel@vader.jdub.homelinux.org>
References: <713171.37644.qm@web26213.mail.ukl.yahoo.com>
	<200804041609.41092.david-b@pacbell.net>
	<1207351282.3224.79.camel@vader.jdub.homelinux.org>
	<200804041658.38499.david-b@pacbell.net>
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
In-Reply-To: <200804041658.38499.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Fri, 2008-04-04 at 16:58 -0700, David Brownell wrote:
> On Friday 04 April 2008, Josh Boyer wrote:
> > 
> > >   ... This means specifically that you may _not_ use the
> > >   memory/addresses returned from vmalloc() for DMA.  ...
> > > 
> > > So I'm rather surprised to see *ANY* kernel code trying to do
> > > that.  That rule has been in effect for many, many years now.
> > 
> > I don't think it was intentional.  You're going through several layers
> > here:
> > 
> > JFFS2 -> mtd parts -> mtd dataflash -> atmel_spi.
> > 
> > Typically MTD drivers aren't doing DMAs to flash and JFFS2 has no idea
> > which particular chip driver is being used because it's abstracted by
> > MTD.
> 
> That's true ... although I can imagine using DMA to
> avoid dcache trashing if its setup cost is low enough,
> with either NAND or NOR chips.
> 
> Still:  in this context vmalloc() is wrong.

Agreed.  One issue is that the summary code allocates a buffer that
equals the eraseblock size of the underlying MTD device.  For larger
NAND chips, that may be up to 256KiB.  I believe this is within the
allowable kmalloc size for most architectures these days, but the
summary code is 3 years old and was likely expecting a smaller limit.
And there is always the question on whether finding that much contiguous
memory will be an issue.

I don't see much harm with the actual patch itself, assuming larger
kmallocs work as I think they should.  It does make me wonder if we have
other cases of vmalloc'd buffers being passed to lower drivers using DMA
though.

josh


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
