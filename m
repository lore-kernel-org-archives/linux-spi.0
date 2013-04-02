From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/5] spi/mxs: Fix chip select control bits in DMA mode
Date: Tue, 2 Apr 2013 02:02:43 +0200
Message-ID: <201304020202.43501.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
	<201304020130.51951.marex@denx.de>
	<CA+7tXij_V1iAdPuPoTQ6CK6U5Y-iJprCPsTj=_LHAV1-=CL7gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXij_V1iAdPuPoTQ6CK6U5Y-iJprCPsTj=_LHAV1-=CL7gA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Trent Piepho,

> On Mon, Apr 1, 2013 at 4:30 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> >> >> -static uint32_t mxs_spi_cs_to_reg(unsigned cs)
> >> >> +static u32 mxs_spi_cs_to_reg(unsigned cs)
> >> >> 
> >> >>  {
> >> >> 
> >> >> -     uint32_t select = 0;
> >> >> +     u32 select = 0;
> >> 
> >> I'll make it a separate patch.
> > 
> > This is completely irrelevant change, please just submit the relevant
> > patches.
> 
> Kernel code should use u16, u32, etc. instead of the uint16_t,
> uint32_t types.  The rest of the driver uses them.  Why should this
> one function use a different type than the rest?  It's ugly and
> inconsistent.

Is this documented somewhere please? I see only a mention about this in chapter 
5 of Documentation/CodingStyle , section (d) . Either way, separate such 
cosmetic change into another series so they're not in the way of relevant stuff.

> And really, it's just as relevant as insisting that multiline patches
> use some exact format, which checkpatch.pl doesn't complain about.

The checkpatch is not almighty tool, Documentation/CodingStyle describes how 
code should be written/annotated/documented.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
