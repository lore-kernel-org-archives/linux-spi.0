From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSP DMA Corruption
Date: Thu, 13 Nov 2008 13:54:48 -0500
Message-ID: <491C77F8.2020305@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>	<47B0D9A4.6080104@whoi.edu>	<20081107184819.54baa679.merrij3@rpi.edu>	<491B6249.7070407@whoi.edu>	<20081112213403.402948b9.merrij3@rpi.edu>	<491B9CD5.3030908@whoi.edu>
	<20081113120134.70d533c8.merrij3@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081113120134.70d533c8.merrij3-IL7dBOYR4Vg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

J. Scott Merritt wrote:
> On Wed, 12 Nov 2008 22:19:49 -0500
> Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> 
>> It says "peripheral clock frequency" without ever defining that phrase
>> (at least in the 1/2006 version of the developer's manual).  Oddly on
>> PXA255 this frequency appears to be runclock/4 = 99.5MHz for a 400MHz
>> machine.  I bet it is not as high as 312MHz, but you can measure it by
>> setting very long times, forcing the timeout (no tx data in pio mode, I
>> think), and perhaps using GPIO probes to trigger a scope.  I did
>> something like that on my system.  It would sure be nice to know the
>> answer to that, as no one using PXA270 has ever answered the question.
>>
>>> Table 8-4 in my PXA manual is titled "TFT and RFT values with possible
>>> DMA Burst Sizes" ... for 8 bit data, it says ... for TFT > 7
>>> "Do not use DMA" ...  Am I misinterpreting this ?  I -think- that means
>>> that 8/8 is not a good choice ...
> 
> My manual seemed to define "peripheral clock" in multiple places with
> multiple (conflicting) frequencies (or options) ;)

That sounds about like what I found.

> I regret that I am probably not able to attempt the clock measurement
> effort at this time - too many other pressures .... If you are really
> anxious to resolve this, I might be able to loan you a PXA270 system
> for a couple of weeks.  Alternatively, I might be able to find time
> for a couple of Kernel builds/loads if you wanted to build all of the
> test programs and patches ...

Excessive busyness affects all of us.  I must decline.

>> The table you refer to lists the values loaded into the TFT and RFT bit
>> fields, which are the desired threshold-1.  The values passed to
>> pxa2xx_spi are the desired thresholds, so TFT>7 is the same as threshold>8.
> 
> You are correct ... of course ... :)
> 
>>>> With respect to the pxa2xx_spi patch, please proceed - I will certainly
>>> not attempt to generate one myself.
>> I'll get something out in the next couple of days.
> 
> Any chance we could get it accepted as a repair into 2.6.27 ?

Yes, I plan to submit the patch to the stable tree, also.  It usually
takes a few weeks to propagate.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
