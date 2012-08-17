From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: tegra: config: enable dmaengine based APB DMA
 driver
Date: Fri, 17 Aug 2012 12:08:54 +0530
Message-ID: <502DE6FE.8040200@nvidia.com>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com> <1345126397-28864-2-git-send-email-ldewangan@nvidia.com> <502D33B6.7070103@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"lrg-l0cyMroinI0@public.gmane.org" <lrg-l0cyMroinI0@public.gmane.org>,
	"broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <502D33B6.7070103-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 16 August 2012 11:23 PM, Stephen Warren wrote:
> On 08/16/2012 08:13 AM, Laxman Dewangan wrote:
>> Enable config for dmaengine based Tegra APB DMA driver and
>> disable the legacy APB DMA driver (SYSTEM_DMA).
> Laxman, if I apply this series to next-20120816 (plus a few patches in
> my local work branch plus the CPU hotplug patches from Joseph, although
> I suspect none of that matters), then audio playback on Tegra20 is
> broken; the pitch is far too high. Audio playback on Tegra30 works as
> expected.
I run the test again on ventana and did not see any issue.
I play one song and saw similar behavior with/without this series.

With this series:
--------------------

ubuntu@tegra-ubuntu:/home$ aplay "1-04 Hungry Like The Wolf.wav"
Playing WAVE '1-04 Hungry Like The Wolf.wav' : Signed 16 bit Little 
Endian, Rate
  44100 Hz, Stereo
underrun!!! (at least 5039.388 ms long)
underrun!!! (at least 60.601 ms long)
underrun!!! (at least 3027.668 ms long)
underrun!!! (at least 2063.667 ms long)
underrun!!! (at least 1062.503 ms long)
underrun!!! (at least 5073.551 ms long)
underrun!!! (at least 6.461 ms long)
underrun!!! (at least 4075.519 ms long)
underrun!!! (at least 78.731 ms long)
underrun!!! (at least 4042.804 ms long)
underrun!!! (at least 28.395 ms long)
underrun!!! (at least 5076.706 ms long)
underrun!!! (at least 6043.105 ms long)
underrun!!! (at least 24.857 ms long)
underrun!!! (at least 5023.783 ms long)
ubuntu@tegra-ubuntu:/home$

And on tot:
--------------
ubuntu@tegra-ubuntu:/home$ aplay "1-04 Hungry Like The Wolf.wav"
Playing WAVE '1-04 Hungry Like The Wolf.wav' : Signed 16 bit Little 
Endian, Rate
  44100 Hz, Stereo
underrun!!! (at least 17098.259 ms long)
underrun!!! (at least 5042.101 ms long)
underrun!!! (at least 87.446 ms long)
underrun!!! (at least 4084.481 ms long)
underrun!!! (at least 4035.531 ms long)
underrun!!! (at least 1026.132 ms long)
underrun!!! (at least 3096.078 ms long)
underrun!!! (at least 1007.028 ms long)
underrun!!! (at least 1034.265 ms long)
underrun!!! (at least 2092.453 ms long)
underrun!!! (at least 1029.957 ms long)
underrun!!! (at least 3076.209 ms long)
underrun!!! (at least 52.042 ms long)
underrun!!! (at least 1001.812 ms long)
underrun!!! (at least 3083.294 ms long)
ubuntu@tegra-ubuntu:/home$
