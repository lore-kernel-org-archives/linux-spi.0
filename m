From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: change .get_ro() callback
	semantics
Date: Tue, 3 Jun 2008 12:07:49 +0200
Message-ID: <200806031207.49843.marc.pignat@hevs.ch>
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
	<20080523154347.GC24862@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080523154347.GC24862-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

Hi all!

On Friday 23 May 2008, Anton Vorontsov wrote:
> get_ro() callback must return values >= 0 for its logical state, and
...
>  static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f2e9885..ef3b773 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -55,6 +55,9 @@ struct mmc_host_ops {
>  	 * Avoid calling these three functions too often or in a "fast path",
>  	 * since underlaying controller might implement them in an expensive
>  	 * and/or slow way.
> +	 *
> +	 * .get_ro and .get_cd should return >= 0 for their logical values,
> +	 * or negative errno value in case of error.
>  	 */

I would suggest to use something more strict (bulletproof), something like:

/*
 * get_ro will return:
 *   0 for a read/write card
 *   1 for a read-only card 
 *   -ENOSYS when not supported
 *   or a negative errno when something bad happened
 * 
 * get_cd will return:
 *   0 for a absent card
 *   1 for a present card 
 *   -ENOSYS when not supported
 *   or a negative errno when something bad happened
 */

I think we have missed one important information: which context these callbacks
can rely on (hard_irq, soft_irq, ...).



Best regards

Marc


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
