From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCHv3 2/3] drivers: mtd: devices: Add quad read support.
Date: Fri, 11 Oct 2013 07:10:41 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA21134@DBDE04.ent.ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
	<1381332284-21822-3-git-send-email-sourav.poddar@ti.com>
	<CAD6G_RShZMkSpVzvXWEE0+sDX=pcnf7ndChndgDG5_T4EVL2vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAD6G_RShZMkSpVzvXWEE0+sDX=pcnf7ndChndgDG5_T4EVL2vQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Hi,

> From: Jagan Teki
> > Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> > Some flash also support quad read mode.
> > Adding support for adding quad mode in m25p80
> > for spansion and macronix flash.
> 
> I am some how not happy with this approach, adding a flags on flash
> param table for supporting
> quad operation in specific flash is may be a better idea.
> 
> But reading SFDP, is a good idea to get the details of flash - quad
> support is one of them.
> and we can assign quad read or fast read based on that.
> 
> Any comments.
> 
Currently SFDP is mostly supported only on Micron devices, that
too the newer ones. So we don't know whether SFDP would be
accepted by other major SPI NOR manufactures like:
Spansion, Nymonix, Micronix, Toshiba, Samsung..

Thus, it might end-up like CFI (common flash interface) where some
vendors support it while others did not. So unless there are more
devices on SFDP from different vendors, I would prefer defer its
implementation in generic driver.

with regards, pekon

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
