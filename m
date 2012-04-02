From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 17:57:42 +0100
Message-ID: <20120402165742.GD24211@n2100.arm.linux.org.uk>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
	<CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com>
	<CACRpkda2zh=zR+A9bwhRXYHtQdFeUpiqG4d5g1i82mPCs1mXaQ@mail.gmail.com>
	<20120402101427.GA3172@opensource.wolfsonmicro.com>
	<20120402104357.GB24211@n2100.arm.linux.org.uk>
	<20120402113413.GA7560@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120402113413.GA7560-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 02, 2012 at 12:34:13PM +0100, Mark Brown wrote:
> On Mon, Apr 02, 2012 at 11:43:57AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 02, 2012 at 11:14:28AM +0100, Mark Brown wrote:
> 
> > > I was waiting for some pronouncement from Russell - looking at the git
> > > logs it seems the patch tracker is the normal way to merge things.
> 
> > Well, this stuff was invented by Linus, so its Linus' decision about
> > how to deal with the power control.
> 
> Linus already acked the patch, the question was more about how to get it
> merged.  Since most of the AMBA changes seem to go via your tree I've
> just submitted it to the patch system as 7366/1.

Does:

ARM PRIMECELL BUS SUPPORT
M:      Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
S:      Maintained
F:      drivers/amba/
F:      include/linux/amba/bus.h

not provide enough clues?  Should I delete all my entries in that file
because the only people who look in there are spammers when the file is
published on the web?

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
