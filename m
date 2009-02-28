From: Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi_bitbang: Add support for
	non-blocking	synchronous transfers
Date: Sat, 28 Feb 2009 16:29:09 +0530
Message-ID: <20090228105908.GA3150@fedora.yogi>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
	<20090228081117.31964.51155.stgit@fedora.yogi>
	<20090228100914.2ec2ff7f@lska2>
	<20090228095846.GA32044@fedora.yogi>
	<20090228111524.1594a58e@lska2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Kagstrom <simon.kagstrom-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090228111524.1594a58e@lska2>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Feb 28, 2009 at 11:15:24AM +0100, Simon Kagstrom wrote:
> On Sat, 28 Feb 2009 15:28:48 +0530
> Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org> wrote:
> 
> > The master is not spi_s3c24xx but spi_s3x24xx_gpio, whose txrx are
> > very simple code.
> > 
> > Additionally all of this has been tested and found to work. The code,
> > along with the modified new spi based lis302dl driver is all in
> > andy-tracking [1].
> 
> Oh, I didn't notice that. Nice then.
> 
> I see from the git logs that this and some other related patches have
> been added now. Another question I have then is about the name: to me 
> spi_non_blocking_transfer() sounds like it would do the opposite of
> what I guess it does - it would go ahead without blocking on the call.
> 

Yes, isn't that what it's supposed to do ? It's going to complete
without putting current to sleep.

> I guess what the name means is that it will not sleep during the call,
> but for pushing it upstream, could it be better to name it something
> else? Perhaps spi_sync and then rename the existing API name (which I
> think is more than a bit strange), or maybe spi_sync_nowait or
> something?

Yes, even I was not terribly happy with 'non_blocking_transfer'.
But I recommend against changing the behaviour of existing functions.
spi_sync_nowait seems good though. 

I hope to get more comments soon. Let's see what other people have to
say.

Thanks,
Balaji

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
