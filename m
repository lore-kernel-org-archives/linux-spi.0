From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Tue, 19 Aug 2008 20:59:59 -0400
Message-ID: <48AB6C8F.4040408@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>	<489C1B23.6040804@cam.ac.uk>	<48A0C35D.5010606@gmail.com>	<48A44F77.1020908@whoi.edu>	<48A4ED85.1030803@gmail.com>	<48A5D44D.6040106@whoi.edu>	<20080815223307.02db86aa@vsauder-lx.localdomain>
	<48A9C0D0.5050304@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A9C0D0.5050304-/d+BM93fTQY@public.gmane.org>
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

Ned Forrester wrote:
> Vernon Sauder wrote:
>> <opinion> As a user, it would seem that the SSP should work with
>> minimum fuss. If there are values that enable 99% of devices to work,
>> then why would you *not* want them to be the defaults? If the user
>> needs to tweak the values because they need more performance, then they
>> can. But if they only need a low bandwidth connection, causing
>> transfers to hang because they did not provide a "know-able" value
>> seems less than useful. I know it took me entirely too long to get this
>> working. I am only trying to help the next user that needs this.
>> </opinion>
> 
> I agree with your sentiment.  What I am not sure of is whether there are
> even 90% of applications that could use a single group of settings.  I
> think the DMA burst and the thresholds could likely be set to reasonable
> defaults: burst = bits/word (for 8, 16, and 32 bit words, this results
> in burst equaling half the FIFO), and thresholds of 8/8 (again, half the
> FIFO).  For the timeout, I'm less sure of the best approach; probably it
> should be very long, a millisecond or more (if we know what that
> translates to on a PXA270), and let users reduce it if they want faster
> response.  My main concern is the poor documentation of this in the PXA
> developer's manuals.

Vernon, have you had any more thoughts about this.  I am working on a
patch to deal with problems that were discovered a while ago, and which
finally tripped up another user (Re: [spi-devel-general] [PATCH]
pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode).  I
wondered if we are ready to converge on any changes.  On the one hand it
would be easy to throw improvement in the defaults in the with the other
changes, but on the other hand I think they are independent, and so they
should probably be in separate patches.

As a consequence of studying the driver for the other patch (regarding
transfer delays and chip select), I have a new understanding of the
timeout that simplifies the problems I discussed above.  I am now
reasonably sure (but cannot test) that a timeout value that is "too
short" will only result in excess interrupt service for unneeded
timeouts, and not in early termination of a transfer.  In
interrupt_transfer, acceptance of a timeout interrupt is conditioned on
being able to retrieve all expected characters from the RX FIFO; in
dma_transfer, acceptance is similarly conditioned on the whole transmit
process being complete (and thus the receive process is done or will be
in nsec).

The result is that neither a too short, nor a too long timeout is fatal,
and thus it IS reasonable to more firmly establish a default timeout,
even it is short.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
