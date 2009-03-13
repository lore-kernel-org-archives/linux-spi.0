From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi suspend/resume
Date: Fri, 13 Mar 2009 09:32:42 -0400
Message-ID: <49BA607A.5020509@whoi.edu>
References: <1236771011.17708.37.camel@brutus> <49B91E76.3090309@whoi.edu>	
	<1236880051.4605.37.camel@brutus> <49B9D47C.8050105@whoi.edu>
	<1236935461.623.38.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1236935461.623.38.camel@brutus>
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
> Em Qui, 2009-03-12 =C3 s 23:35 -0400, Ned Forrester escreveu:
> Everything else is OK. DRCMR is the only thing that gets nuked and is
> not restored by pump_transfers().

OK.  It would really be nice to know what is zeroing DRCMR.
pump_transfers() is assuming that once DMA channels have been allocated
and setup then the stay that way.  Obviously that is not a valid assumption.

>> I would not jump to the conclusion (perhaps you haven't, but I don't
>> have the whole picture) that we just need to restore these two
>> registers.  You need to make sure that the assigned DMA channels are
>> still allocated.  I wonder what process cleared these registers and what
>> that might mean about the possibility that DMA channel assignments were
>> purged on resume.
> =

> Currently I am restoring them to their probe() values on resume(), only
> if rx_channel and tx_channel are !=3D -1 (dma enabled). It seems to be
> working fine. I'm not sure if this is all that is needed, but I suspect
> it's enough.

OK.  That's good.

> And I think that it's not software that is nuking DRCMR, as I said on a
> previous email, I dont need to restore DRCMR if I use the "core" pm_test
> mode. (the core pm_test executes the suspend/resume routines just as if
> it was a normal suspend/resume, the only difference is that PXA will not
> be really suspend).

I'm not familiar with the core pm test, but I can see that it is useful.
 I could not find anything in the PXA270 developer's manual that
mentions the value of DRCMR being altered by any hardware action
involving suspend; however, I have found other omissions in the past.

> There is still a chance that my bootloader is nuking these registers on
> resume before giving control to kernel, I will check the bootloader code
> and see if this is the case. I suspect it isn't.

Interesting possibility.  I thought suspend/resume was just a low power
state that awakens by restarting the clocks.  Does the boot loader
actually run a bit on resume before discovering that memory is already
loaded?

>> You could try a patch to restore DRCMR registers to see if that fixes
>> the problem or just makes things worse.  I don't recommend submitting
>> such a patch without guidance from someone more knowledgeable about DMA
>> and suspend/resume.
> =

> It fixes the problem here, I'm not sure if it's all that is needed, so,
> lets wait for more comments on this before I submit the patch.

Hopefully Dave, or someone else knowledgeable will speak up.  Otherwise,
go ahead with submitting the patch.  And thanks for tracking this down.

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
