From: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: [PATCH] Add Dallas DS1390 RTC chip
Date: Fri, 17 Oct 2008 19:57:29 +0100
Message-ID: <48F8E019.20600@mimc.co.uk>
References: <48F452BE.2030901@mimc.co.uk>
	<20081014101703.1ded0259@i1501.lan.towertech.it>
	<48F8467C.5010902@mimc.co.uk>
	<200810170829.06699.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200810170829.06699.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> On Friday 17 October 2008, Mark Jackson wrote:
>>>> +    /* Can tx_buf and rx_buf be equal? The doc in spi.h is not sure... */
>>>> +    xfer.tx_buf = chip->tx_buf;
>>>> +    xfer.rx_buf = chip->rx_buf;
>>>  you use the same buffer a few functions below. either
>>>  one way or the other. please investigate with the spi subsystem maintainer.
>> David,
>>
>> Just to double check (as per Alessandro's suggestion), is this okay use of the 
>> spi buffers ?
> 
> Yes.  That comment deserves to be updated.
> 
> SPI does bi-directional I/O, and the underlying controller
> should be able to just replace the contents of a buffer
> with a spi_transfer that uses the same rx and tx buffers.

Excellent.  Thanks for the confirmation.

Regards
Mark

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
