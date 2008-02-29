From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Fri, 29 Feb 2008 12:44:10 +1100
Message-ID: <33e9dd1c0802281744g48c74670v6b71ced41edf1300@mail.gmail.com>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
	<33e9dd1c0802281502x3d045a03pcb6282a781ac4e56@mail.gmail.com>
	<47C76057.30705@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47C76057.30705-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
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

Here's the contents of the registers before suspend:

SSCR0=00000387
SSCR1=00000ec0
SSSR=0000f024
SSITR=00000000
SSTO=00000000
SSPSP=00000000

And after suspend:

SSCR0=00000000
SSCR1=00000000
SSSR=0000f004
SSITR=00000000
SSTO=00000000
SSPSP=00000000

I chose to reinitialise the registers to a known correct state rather
than leave them in their post-suspend state. You may have some better
ideas about what to do with them.

Cheers,
Zik

On Fri, Feb 29, 2008 at 12:31 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
>
>  Is it possible that you did not check individually to see which of these
>  registers is the culprit?  SSITR is a test register that is surely
>  initialized to 0 on powerup, and it is never touched by the driver.  So
>  why would this have changed?  Likewise, SSPSP is not ever set by the
>  driver.  SSCR0, SSCR1, are both set at the end of pump_transfers, just
>  before the first transfer starts, if they differ from the values in
>  hardware, as they most likely will after suspend (and if they don't,
>  then it should not matter).
>
>  Is is possible that after resume, not all of these registers recover
>  their power-up state?  Is SSPSP really different after resume than
>  before?  SSPSP should not matter if the PSP mode is not selected in SSCR0.
>
>  Can you shed some light on these questions, while I continue to look?
>
>  --
>
>
> Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
>  Oceanographic Systems Lab                                  508-289-2226
>  Applied Ocean Physics and Engineering Dept.
>  Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
>  http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
>  http://www.whoi.edu/hpb/Site.do?id=1532
>  http://www.whoi.edu/page.do?pid=10079
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
