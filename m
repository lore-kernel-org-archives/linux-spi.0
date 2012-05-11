From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: refactor spi-coldfire-qspi to use SPI queue
	framework.
Date: Fri, 11 May 2012 18:51:39 +0530
Message-ID: <CAM=Q2cvy+LSS81kDqOQXe4dxiEbhfDTP=jDYVi-PQBs9ugbPpQ@mail.gmail.com>
References: <201205100926.55444.sfking@fdwdc.com>
	<CAM=Q2cuxbUcXUz6iQFoYfU8xmFXvNtiVxrBAjPE9u34wNnrAbw@mail.gmail.com>
	<201205110333.22096.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201205110333.22096.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 11, 2012 at 4:03 PM, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org> wrote:
> On Friday 11 May 2012 1:33:25 am Shubhrajyoti Datta wrote:
>> Hi Steven,
>>
>> On Thu, May 10, 2012 at 9:56 PM, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org> wrote:
>> > Use the new SPI queue framework; remove use of workqueue, replace
>> > mcfqspi_transfer with mcfqspi_transfer_one_message, add
>> > mcfqspi_prepare_transfer_hw and mcfqspi_unprepare_transfer_hw, update
>> > power management routines.
>>
>> By update are you attempting to convert to runtime framework also?
>
> laying the ground work for it; right now its mostly just a big nop as
> currently on Coldfire there isnt any PM support.

OK , BTW my concern was partly clock apis and partly runtime.
Anyways dont have any strong opinions.

> =A0I suppose it would have
> been better to have that as a separate patch, i can resubmit with that br=
oken
> out if people would prefer.

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
