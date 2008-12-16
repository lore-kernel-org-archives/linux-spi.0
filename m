From: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
Subject: Re: "concurrent" transfers list corruption
	(spi_async) with	atmel_spi
Date: Tue, 16 Dec 2008 11:27:05 +0100
Message-ID: <20081216102705.GO1924@domen-work>
References: <20081216094221.GN1924@domen-work>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081216094221.GN1924@domen-work>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Uh, nm, sorry for the noise, it was my code that used the same message
and transfer struct. (Maybe if I posted before I'd find it sooner? ;-) )


	Domen

On 16/12/08 10:42 +0100, Domen Puncer wrote:
> Hello!
> 
> At least I think this is the reason.
> 
> I'm doing spi_async transfers, and in the middle, I get an interrupt
> which triggers another spi_async (presumably in the middle of spi
> callback) , to read status register.
> 
> The resulting backtrace is:
<snip>

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
