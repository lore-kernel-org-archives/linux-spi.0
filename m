From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi suspend/resume
Date: Thu, 12 Mar 2009 23:35:24 -0400
Message-ID: <49B9D47C.8050105@whoi.edu>
References: <1236771011.17708.37.camel@brutus> <49B91E76.3090309@whoi.edu>
	<1236880051.4605.37.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1236880051.4605.37.camel@brutus>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Daniel Ribeiro wrote:
> Em Qui, 2009-03-12 =C3 s 10:38 -0400, Ned Forrester escreveu:
>> You may want to check DCSR to make sure the run bits are set for the
>> assigned dma channels.  You will probably need more printk's just to
>> find out what channels were assigned; they are assigned in
>> pxa2xx_spi_probe().  It's hard to believe that these would not be set,
>> as it is done pump_transfers(), and you know execution is going there.
> =

> Indeed, i tried using the driver on PIO mode, and suspend/resume works!
> =

> Here is what i get with a little more debug and DMA enabled..
> =

> SUSPEND DRCMR_TX=3D00000084 DRCMR_RX=3D00000084
> RESUME DRCMR_TX=3D00000000 DRCMR_RX=3D00000000
> =

> Should i cook a patch to store DRCMR on suspend and restore on resume?
> Or is the proper fix something else?

Hmmm... This looks scary.  If the DRCMR registers went to zero, what
else has changed in the DMA setup?  A call to pxa2xx_spi_remove() would
have cleared these, but that should not be called for suspend/resume.
Have you checked all the other DMA related registers that are assigned
to the SSP device?  Are these the only ones that are anomalous, or are
these just the first ones you found?

Actually, I don't think there are any other registers, save the ones
that will be set up by pump_transfers(), anyway.  The PXA270 has a few
more DMA related registers than the PXA255, but I don't see anything
that looks like trouble, other than what you found above.

I would not jump to the conclusion (perhaps you haven't, but I don't
have the whole picture) that we just need to restore these two
registers.  You need to make sure that the assigned DMA channels are
still allocated.  I wonder what process cleared these registers and what
that might mean about the possibility that DMA channel assignments were
purged on resume.

There is code in arch/arm/mach-pxa/ssp.c ssp_probe() that assigns DMA
request numbers for each SSP channel.  I think, but I am not sure, that
these are really fixed numbers determined by the hardware wiring of
peripheral devices to DMA requests (see tables 5-9 and 5-21 of the dev
man).  If so, then the value passed is a constant anyway, and thus it
must still be valid.

In drivers/spi/pxa2xx_spi.c pxa2xx_spi_probe(), the DMA channel numbers
are allocated.  These are definitely not constants, as they are a
limited resource.  The channel numbers are then loaded into the DRCMR
registers to map the request to the channel.  I don't know how to check
that the previous assignment of DMA channels is still valid.

You could try a patch to restore DRCMR registers to see if that fixes
the problem or just makes things worse.  I don't recommend submitting
such a patch without guidance from someone more knowledgeable about DMA
and suspend/resume.

David, do you have any knowledge of what is happening to the DMA
request-to-channel assignment registers in the PXA, during suspend/resume?

--

In the process of searching for inspiration on this matter, I was
reminded of another poster who has tried getting suspend/resume to work.
 I don't think that the thread:

http://osdir.com/ml/linux.kernel.spi.devel/2008-02/msg00075.html

has any useful info for you, unless you find that the problem you
discovered has the same symptoms as Zeke described. He was on the wrong
track to fix, but maybe you have found the cause.  Unfortunately he had
to drop the problem before it got fixed.

-- =

Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=3D7212
http://www.whoi.edu/hpb/Site.do?id=3D1532
http://www.whoi.edu/page.do?pid=3D10079


---------------------------------------------------------------------------=
---
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
