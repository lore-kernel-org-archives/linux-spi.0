From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: tegra: config: enable dmaengine based APB DMA
 driver
Date: Thu, 16 Aug 2012 11:53:58 -0600
Message-ID: <502D33B6.7070103@wwwdotorg.org>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com> <1345126397-28864-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345126397-28864-2-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/16/2012 08:13 AM, Laxman Dewangan wrote:
> Enable config for dmaengine based Tegra APB DMA driver and
> disable the legacy APB DMA driver (SYSTEM_DMA).

Laxman, if I apply this series to next-20120816 (plus a few patches in
my local work branch plus the CPU hotplug patches from Joseph, although
I suspect none of that matters), then audio playback on Tegra20 is
broken; the pitch is far too high. Audio playback on Tegra30 works as
expected.
