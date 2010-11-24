From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi/spi: don't release the spi device twice
Date: Wed, 24 Nov 2010 15:59:22 +0800
Message-ID: <20101124155922.76930387@feng-i7>
References: <20101122133503.GA25553@www.tglx.de>
	<20101123004301.GA1034746@jupiter.n2.diac24.net>
	<4CEB985F.90805@linutronix.de> <20101123222400.7cdf3074@feng-i7>
	<20101123145910.GA23880@www.tglx.de>
	<20101123164520.GA1384937@jupiter.n2.diac24.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101123164520.GA1384937-sd4rSCkhOesKVZNVnti56SRbHCANfdcW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 24 Nov 2010 00:45:20 +0800
David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org> wrote:

> > This was fixed by David Lamparter in v2.6.36-rc5 3486008
> > ("spi: free children in spi_unregister_master, not siblings") and
> > broken again in v2.6.37-rc1~2^2~4 during the merge of 2b9603a0
> > ("spi: enable spi_board_info to be registered after spi_master").
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > ---
> > -	dummy = device_for_each_child(master->dev.parent,
> > &master->dev,
> > -					__unregister);
> > +	dummy = device_for_each_child(&master->dev, NULL,
> > __unregister);
> 
> Signed-off-by: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
> 
> very simple merge/rebase/forward-port breakage...
> Feng, can you check 2b9603a0 for whether anything else got broken?
> 

I just checked, all other parts should be ok.

Thanks,
Feng

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
