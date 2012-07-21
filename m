From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix the below warning
Date: Sat, 21 Jul 2012 20:40:42 +0530
Message-ID: <CAM=Q2cs5G5g2LzHbC+dU4GSUrjG49Sc50xpHWNNVkfxPi9Ki2g@mail.gmail.com>
References: <1342720012-3709-1-git-send-email-shubhrajyoti@ti.com>
	<20120720100959.GS4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120720100959.GS4495@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 20, 2012 at 3:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jul 19, 2012 at 11:16:52PM +0530, Shubhrajyoti D wrote:
>> The dma_map and dma_unmap should have same parameter
>> passed otherwise we get the below warn.
>
> Applied, thanks.
thanks,
