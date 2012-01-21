From: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/s3c64xx: Log error interrupts
Date: Sat, 21 Jan 2012 17:42:30 +0100
Message-ID: <4F1AEAF6.3000004@gmail.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
	<1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F1AD954.9030303@gmail.com>
	<20120121152947.GD10751@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120121152947.GD10751-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/21/2012 04:29 PM, Mark Brown wrote:
> On Sat, Jan 21, 2012 at 04:27:16PM +0100, Sylwester Nawrocki wrote:
>> On 01/21/2012 02:24 PM, Mark Brown wrote:
> 
>>> -	int ret;
>>> +	int ret, irq;
>>> +	char clk_name[16];
> 
>> clk_name seems to be unused, otherwise looks good.
> 
> That's git cherry-pick being too clever for me when I pulled this out of
> my -next branch for Grant.  clk_name is used in -next by some updates
> which I guess Kukjin is carrying, I hadn't noticed they weren't in the
> SPI tree.  I don't know if it's better to just leave things as they are
> for now given that it'll all come out in the merge window?

Indeed, the orphaned variable is already sitting in -next. I guess it
can be handled during merge.

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
