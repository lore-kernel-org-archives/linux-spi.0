From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 5/5] ASoC: tegra: remove support of legacy DMA driver
 based access
Date: Fri, 14 Sep 2012 16:53:36 +0100
Message-ID: <20120914155335.GB4684@opensource.wolfsonmicro.com>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com>
 <1345126397-28864-6-git-send-email-ldewangan@nvidia.com>
 <50526DFE.5030709@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50526DFE.5030709-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 13, 2012 at 05:36:30PM -0600, Stephen Warren wrote:

> Please note that I've applied this to Tegra's for-3.7/dmaengine branch,
> even though it hasn't been ack'd by an ASoC maintainer.

Please don't apply this without review, we've got quite enough problems
with the dmaengine stuff as it is unfortunately so I want to keep a
handle on what's going on.  I didn't look at it since when it was
originally posted people found problems in testing so I was expecting a
respin of the series.
