From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduces
	chipselect GPIO to simplify the common cases
Date: Thu, 11 Dec 2008 18:43:32 +0800
Message-ID: <f17812d70812110243t3bb461aajeb95c16ce794bdb8@mail.gmail.com>
References: <f17812d70811242317u706ff2bdq4410fd331975c463@mail.gmail.com>
	<f17812d70812041828x6ff01993tbaa2d664c24681e6@mail.gmail.com>
	<f17812d70812110209p1f51c64bw1957583d24314448@mail.gmail.com>
	<200812110236.22393.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812110236.22393.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 11, 2008 at 6:36 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Thursday 11 December 2008, Eric Miao wrote:
>> On Fri, Dec 5, 2008 at 10:28 AM, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > David,
>> >
>> > I have to ping you again on this patch due to the coming merge window.
>> >
>>
>> Well, one week passed and still no response, I'll push this
>> one through my tree anyway.
>
> I'm still catching up on stuff ... what's the rush?
>

Rush for your quick confirmation, I have several other
platform-specific patches depending on this one.

> It's probably OK -- it was almost OK before -- but I'd
> still rather send it with my next batch of SPI updates.
>

Good.

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
