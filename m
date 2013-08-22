From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/2]spi: DUAL and QUAD support
Date: Thu, 22 Aug 2013 19:53:11 +0530
Message-ID: <52161ECF.2060700@ti.com>
References: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
	<5216057F.4010900@ti.com> <20130822132122.GK26118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, pekon-l0cyMroinI0@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130822132122.GK26118-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 22 August 2013 06:51 PM, Mark Brown wrote:
> On Thu, Aug 22, 2013 at 06:05:11PM +0530, Sourav Poddar wrote:
>> On Sunday 11 August 2013 03:45 PM, wangyuhang wrote:
>>> +		/* check transfer tx/rx_nbits:
>>> +		 * 1. keep the value is not out of single, dual and quad
>>> +		 * 2. keep tx/rx_nbits is contained by mode in spi_device
>>> +		 * 3. if SPI_3WIRE, tx/rx_nbits should be in single
>>> +		 */
>> Sorry for pitchin in a bit late on this.
>> I was trying to use this for my use case today. I realise this check
>> should be under...
> Can you send a patch for this please?
Yes, I will send it.

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
