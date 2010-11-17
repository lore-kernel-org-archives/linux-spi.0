From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 00/49] spi: davinci: re-write existing driver
Date: Wed, 17 Nov 2010 08:24:26 -0700
Message-ID: <20101117152426.GA5757@angua.secretlab.ca>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1289990661-30126-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 17, 2010 at 04:13:32PM +0530, Sekhar Nori wrote:
> This patch series represents a break-up into reviewable portions
> of the work originally done by Brian and posted here:
> 
> https://patchwork.kernel.org/patch/114924/
> 
> While this series does not exactly add up to what Brian's patch
> is, it is pretty close functionally.
> 
> This series was tested by me on OMAP-L138, OMAP-L137, DM365 and DM355
> EVMs and on their OMAP-L138 boards (not EVMs) by Brian and Michael.
> 
> The patch series applies to latest of Linus's tree in hope that
> it will be considered for merge in 2.6.37 since the series is
> about bug fixes and clean-up.
> 
> This series along with some patches to add SPI platform support
> to OMAP-L1x EVMs and Mity-DSP board is also available here:
> 
> http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite

I went through all the patches, and it looks good to me.  Is there a
public git:// url I can use to pull this series?

>  5 files changed, 587 insertions(+), 799 deletions(-)

Nice diffstat.  :-)

g.

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
