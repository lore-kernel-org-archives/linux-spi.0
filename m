From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] spi/mxs: Remove bogus setting of ssp clk rate field
Date: Mon, 1 Apr 2013 16:32:25 -0700
Message-ID: <CA+7tXihhL2ETT+AgvX5KASZOOgi6bucModE88ztY9Q8U1gDbOQ@mail.gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
	<1364570381-17605-4-git-send-email-tpiepho@gmail.com>
	<201304020116.04781.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201304020116.04781.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 1, 2013 at 4:16 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> The ssp struct has a clock rate field, to provide the actual value, in Hz,
>> of the SSP output clock (the rate of SSP_SCK) after mxs_ssp_set_clk_rate()
>> is called.  It should be read-only, except for mxs_ssp_set_clk_rate().
>>
>> For some reason the spi-mxs driver decides to write to this field on init,
>> and sets it to the value of the SSP input clock (clk_sspN, from the MXS
>> clocking block) in kHz.  It shouldn't be setting the value, and certainly
>> shouldn't be setting it with the wrong clock in the wrong units.
>
> I suspect this patch should also fix drivers/clk/mxs/clk-ssp.c then?

Why do you say that?  I see no problem with clk-ssp.c, as setting the
clk_rate field in the ssp struct to the actual programmed rate makes
sense.  The code in spi-mxs.c just makes no sense.  I suspect it was
added by mistake when porting the driver.

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
