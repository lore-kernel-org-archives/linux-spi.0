From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ep93xx: added chip
	revision	reading function
Date: Thu, 25 Mar 2010 12:20:38 -0500
Message-ID: <0D753D10438DA54287A00B02708426976368F66FD1@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976368AC725D@AUSP01VMBX24.collaborationhost.net>
	<20100325090638.GA20512@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100325090638.GA20512-WfG2TfFPcQ9S6P4I59wummXnswh1EIUO@public.gmane.org>
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

On Thursday, March 25, 2010 2:07 AM, Mika Westerberg wrote:
> On Thu, Mar 18, 2010 at 12:27:15PM -0500, H Hartley Sweeten wrote:
>> On Thursday, March 18, 2010 10:00 AM, Mika Westerberg wrote:
>>> Added a new function: ep93xx_chip_revision() which reads chip revision from the
>>> sysconfig register.
>>> 
>>> Signed-off-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
>> 
>> Hello Mika,
>> 
>> I'm ok with this part of your patch series.
>> 
>> Acked-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
>
> Hello,
>
> Any comments on the v2 series of the driver? If it is OK could it be considered for .35?

Hello Mika,

This part (2/3) I am fine with.

If you want, you can add this as a separated patch to Russell's patch tracker
with my Acked-by above.


For parts 1 and 3.

I tried testing them in my setup with the mmc_spi.c and sst25l.c drivers.  Both
did not work.  For some reason the data read is always either 0x00 or 0xff.

I will try to get some time this week/weekend to look into this.

Regards,
Hartley
------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
