From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Wed, 17 Oct 2007 19:13:09 +0530
Message-ID: <01af01c810c3$a86e09b0$6a8918ac@ent.ti.com>
References: <4714F4AC.4020402@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'Ned Forrester'" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <4714F4AC.4020402-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



>-----Original Message-----
>From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org]
>Sent: Tuesday, October 16, 2007 10:58 PM
>To: Girish
>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [spi-devel-general] Status of Linux SPI slave
>
anism for arbitrating access by
>multiple masters.) Therefore, one might presume that if the
>Linux system will operate in slave mode, then it will only
>operate that way, and thus it will not be restrictive to
>assign a single, dedicated pin (SSPSFRM, FRAME) as the chip
>select input from a single external master.
>

Thanks for this insight full information. This helped.

Regards,
girish

>Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
>http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
>http://www.whoi.edu/hpb/Site.do?id=1532
>http://www.whoi.edu/page.do?pid=10079
>
>



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
