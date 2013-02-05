From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Fixing eSPI controller driver: some queries
Date: Tue, 05 Feb 2013 17:32:14 +0000
Message-ID: <20130205173214.7B4853E166D@localhost>
References: <CAAXf6LUeAUYOUT70fbYWoG-zcr15Q495MB0f1YLd6su1CLqLEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Ronny Meeus <Ronny.Meeus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Thomas De Schampheleire <patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAAXf6LUeAUYOUT70fbYWoG-zcr15Q495MB0f1YLd6su1CLqLEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 18 Jan 2013 10:03:28 +0100, Thomas De Schampheleire <patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
> 
> The Freescale eSPI controller driver is broken in several ways. I already
> attempted to fix this with a patch many months back. The patch works for
> me, but never got feedback from the original author.
> (see https://patchwork.kernel.org/patch/988802/)
> 
> The same problems are still present on the current 3.x version of the
> driver. I will now re-investigate the problem, and submit a revised patch
> later.
> 
> I have some queries though:
> - When reading from memory devices, the first bytes received may not yet be
> the real contents of memory, but rather to-be-ignored bytes caused by the
> full-duplex nature of the transaction while sending the command and address
> bytes.
> Am I correct in understanding that these to-be-ignored bytes are to be
> transparently passed through to the requester of the transaction (i.e. a
> protocol driver or a userspace application through spidev) and that it's
> the requestor's responsability to know that these bytes are to be ignored?

Yes

> 
> - While investigating the various problems of the driver, I am adding print
> statements throughout the code, displaying certain variables and buffer
> contents. What should I do with these when the problems are fixed? Remove
> all such statements, or rather, use a mechanism like dev_dbg (or similar)
> and thus keep them in the code? What is your preference?

It is common to use dev_dbg(). They are turned off by removing #define
DEBUG from the top of the file. As long as they don't impair readability
of the code I would keep them in.

> - One of the aspects that seems to be broken in the driver is accesses that
> do not have either 8-bits-per-word or 16-bits-per-word, e.g. 7 bpw or 12
> bpw. The hardware defaults to sending least-significant-bits first, and the
> setting to change this is only allowed for 8 or 16 bpw:
> 
> -------- (datasheet)
> Reverse data mode. Determines the receive and transmit character bit order.
> 0 lsb of the character sent and received first
> 1 msb of the character sent and received first-for 8/16 bits data character
> only
> -------
> 
> However, the driver sets this bit (CSMODE_REV) by default, except when the
> mode SPI_LSB_FIRST is explicitly set. This means that a protocol driver
> that requests a 12bpw transaction, will inadvertently cause an illegal mode
> setting in the hardware. It doesn't and shouldn't know of this hardware
> restriction. Is this analysis correct?

Correct. The master driver needs to work around limitations of the
hardware, or reject them as unsupported.

> What is the correct way of handling this? Clear the bit in case of a sub-8
> or sub-16 bpw transaction, and do the bit swapping in software if
> SPI_LSB_FIRST is not explicitly set?

Probably

> Or force SPI_LSB_FIRST in these cases, leaving the bit swapping to the
> protocol driver?

No. it should be abstracted

> Or disable support for sub-8 and sub-16 bpw transactions?

Only if the first option isn't feasable.

g.


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
