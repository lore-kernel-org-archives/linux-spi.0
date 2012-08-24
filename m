From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] mxs/spi: Fix misuse of init_completion
Date: Fri, 24 Aug 2012 04:54:40 +0200
Message-ID: <201208240454.40561.marex@denx.de>
References: <1345775624-9696-1-git-send-email-marex@denx.de>
	<87393dt3em.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87393dt3em.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Chris Ball,

> Hi Marek,
> 
> On Thu, Aug 23 2012, Marek Vasut wrote:
> > The init_completion() call does reinit not only the variable carrying
> > the flag that the completion finished, but also initialized the
> > waitqueue associated with the completion. On the contrary, the
> > INIT_WAITQUEUE() call only reinits the flag.

Darn, it's INIT_COMPLETION() of course.

> > In case there was anything still stuck in the waitqueue, subsequent call
> > to init_completion() would be able to create possible race condition.
> > This patch uses the proper function and moves init_completion() into
> > .probe() call of the driver, to be issued only once.
> > 
> > Note that such scenario is impossible, since two threads can never enter
> > the mxs_spi_txrx_dma(), since whole this section is protected by mutex
> > in SPI core. This by no means allows this issue to exit though.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> 
> Thanks for writing that up -- I appreciate seeing the explanation of the
> problems this could have caused.

You're very welcome, I was really lazy, sorry about that and thanks for pushing 
me ;-) I hope someone might eventually even find this explanation useful.

> - Chris.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
