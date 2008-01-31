From: "eric miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI related Kconfig warning
Date: Thu, 31 Jan 2008 17:27:01 +0800
Message-ID: <f17812d70801310127h64f77b10td33a4736b3a23836@mail.gmail.com>
References: <D5CED6F1-A708-4866-BA3D-75F3CCBA43F6@kernel.crashing.org>
	<200801302321.51120.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801302321.51120.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Jan 31, 2008 3:21 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 30 January 2008, Kumar Gala wrote:
> > Was wondering if anyone was looking at the cause of this warning in
> > top of linus's tree (8af03e782cae1e0a0f530ddd22301cdd12cf9dc0)
> >
> > drivers/spi/Kconfig:156:warning: 'select' used by config symbol
> > 'SPI_PXA2XX' refers to undefined symbol 'PXA_SSP'
> >
> > I was doing a build of a ppc kernel.
>
> Happens on x86, AVR32, and non-PXA ARM too.  Came from some PXA cleanup
> patches.  Eric, didn't you have a patch for this?
>

Nope.

If moving the symbol PXA_SSP to the "depends on" list, this option will
remain invisible if a careless user does not select PXA_SSP.

Yet I'm not sure this is the way to go or mandatory by the kconfig rules.

> (Of course I *still* don't understand why kconfig bothers to look
> at reverse dependencies whose "forward" ones can never be satisfied.
> If it stopped looking at those, lots of similar problems would vanish.)
>
> - Dave
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
