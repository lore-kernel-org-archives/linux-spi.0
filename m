From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver
	for	Cirrus EP93xx SPI controller
Date: Mon, 26 Apr 2010 13:09:30 +0300
Message-ID: <20100426100930.GH26418@gw.healthdatacare.com>
References: <20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9B7E66-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 25, 2010 at 03:25:16PM -0500, H Hartley Sweeten wrote:
> With a slow enough clock you can probably get to a point where SFRMOUT
> will stay deasserted during the entire 512 byte transfer.  But it would
> still de-assert during the switch to the next transfer in the message.
> 
> Regardless, I tend to agree with you.  Because of the chip design, it's
> impossible (or at least you can't guarantee) to keep the SFRMOUT low
> during a transfer.  Some devices can live with this others can't.  Oh well.

One more thing I forgot to mention. With DMA there are 2 buffers per channel which
means that the controller can continue right to the next transfer so SFRMOUT might
work better.

Regards,
MW

------------------------------------------------------------------------------
