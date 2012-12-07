From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Remove SPI_BUFSIZ restriction on
	spi_write_then_read()
Date: Fri, 07 Dec 2012 14:04:34 +0000
Message-ID: <20121207140434.64B5D3E0B87@localhost>
References: <1354420465-29315-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20121206000026.A620D3E0E22@localhost>
	<20121206053732.GD10867@opensource.wolfsonmicro.com>
	<20121206140427.8E5673E089D@localhost>
	<20121207034140.GB26070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121207034140.GB26070-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 7 Dec 2012 12:41:41 +0900, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Thu, Dec 06, 2012 at 02:04:27PM +0000, Grant Likely wrote:
> 
> > Alright, applied. I've also merged in your spi-next tree. Let me know if
> > that causes problems because it needs to be rebased.
> 
> No problem - do you just want to take over the SPI tree again or should
> I carry on applying things?

Yes, please keep doing what you're doing! It's a huge help.

Whenever I sit down to do patch maintenance, I'll pull in your tree
first. As long as your tree doesn't get rebased then that should work
well. I also promise to not rebase my tree without talking to you first
so you can pull in mine before applying more patches on top.

It's a huge help to be reading through the mailing list and be able to
ignore any messages that I've seen you've already replied to or applied.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
