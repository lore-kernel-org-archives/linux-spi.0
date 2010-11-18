From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 00/49] spi: davinci: re-write existing driver
Date: Thu, 18 Nov 2010 12:23:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247388244@dbde02.ent.ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<20101117152426.GA5757@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101117152426.GA5757-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Wed, Nov 17, 2010 at 20:54:26, Grant Likely wrote:
> On Wed, Nov 17, 2010 at 04:13:32PM +0530, Sekhar Nori wrote:
> > This patch series represents a break-up into reviewable portions
> > of the work originally done by Brian and posted here:
> >
> > https://patchwork.kernel.org/patch/114924/
> >
> > While this series does not exactly add up to what Brian's patch
> > is, it is pretty close functionally.
> >
> > This series was tested by me on OMAP-L138, OMAP-L137, DM365 and DM355
> > EVMs and on their OMAP-L138 boards (not EVMs) by Brian and Michael.
> >
> > The patch series applies to latest of Linus's tree in hope that
> > it will be considered for merge in 2.6.37 since the series is
> > about bug fixes and clean-up.
> >
> > This series along with some patches to add SPI platform support
> > to OMAP-L1x EVMs and Mity-DSP board is also available here:
> >
> > http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite
>
> I went through all the patches, and it looks good to me.  Is there a
> public git:// url I can use to pull this series?

Thanks for the quick review.

Here is the pull request:

The following changes since commit 0a5b871ea4c6bfb2723ac2ffc7ef5c32452abb89:
  Linus Torvalds (1):
        hardirq.h: remove now-empty #ifdef/#endif pair

are available in the git repository at:

  git://arago-project.org/git/projects/linux-davinci.git for-grant

<short log and diffstat deleted>

Thanks,
Sekhar


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
