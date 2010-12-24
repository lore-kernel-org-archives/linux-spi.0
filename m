From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH REPOST v2] spi/spi: don't release the spi device twice
Date: Thu, 23 Dec 2010 20:39:11 -0700
Message-ID: <AANLkTikxQJffL8=_Dqij-405TF92CZqqOfoo5yoxLcdN@mail.gmail.com>
References: <20101220171330.GA15344@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101220171330.GA15344-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 20, 2010 at 10:13 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> This was fixed by David Lamparter in v2.6.36-rc5 3486008
> ("spi: free children in spi_unregister_master, not siblings") and broken
> again in v2.6.37-rc1~2^2~4 during the merge of 2b9603a0 ("spi: enable
> spi_board_info to be registered after spi_master").
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
> ---
>
> Andrew, I resent this to you because it fixes a regression which was
> introduced in the merge window for v2.6.37.
> I posted this patch at 2010-11-23 14:59:10 and sent a ping 2010-12-09
> 16:06:22 and got no response so far from the maintainer. The patch is at
> https://patchwork.kernel.org/patch/349721/

Sebastian, sorry I've been completely AWOL for the last month and a
half (or more).  I got completely overwhelmed this fall and it took
until just now to get myself dug out again.  I'm not doing any travel
for the next 4 months, and I've *finally* got an autotest instance set
up so I can properly pick up and test patches quickly, so things
should be better in the new year.

Andrew, Thanks for picking this one up and sending it on.  I've
rearranged the way I work on my end, so this situation shouldn't
happen again.

g.

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
