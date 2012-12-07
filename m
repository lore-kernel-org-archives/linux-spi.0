From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
	spi-orion
Date: Thu, 6 Dec 2012 17:14:33 -0700
Message-ID: <20121207001433.GG25069@obsidianresearch.com>
References: <20121121192335.GA14868@obsidianresearch.com>
	<20121206142521.4185A3E0948@localhost>
	<20121206172504.GB9676@obsidianresearch.com>
	<20121206232305.719E23E0B24@localhost>
	<20121206234917.GF25069@obsidianresearch.com>
	<20121206235311.GB21694@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121206235311.GB21694-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 06, 2012 at 06:53:11PM -0500, Jason Cooper wrote:
> On Thu, Dec 06, 2012 at 04:49:17PM -0700, Jason Gunthorpe wrote:
> > Jason: Do you have any of these possibly affected boards with a SPI
> > flash to test linux-next? dove, dreamplug, ts219 and lsxl
> 
> Yep, dreamplug ought to do.

Hmm, I just reviewed all the FLASH P/Ns datasheets in the affected DT
files, and they are all mode 0/mode 3 compatible - that is the linux
default mode so I expect everything to work OK.

If your dreamplug is fine lets just leave it?

Jason

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
