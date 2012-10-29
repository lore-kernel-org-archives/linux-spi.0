From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for SLINK controller
Date: Mon, 29 Oct 2012 09:17:54 -0600
Message-ID: <508E9E22.6030201@wwwdotorg.org>
References: <1350557233-31234-1-git-send-email-ldewangan@nvidia.com>
	<5085A667.2000100@wwwdotorg.org> <508ADB1C.6040602@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <508ADB1C.6040602-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 10/26/2012 12:49 PM, Laxman Dewangan wrote:
> Thanks Stephen for review.
> I have taken care of almost all feedback. Some of having my below comments.
> 
> On Tuesday 23 October 2012 01:32 AM, Stephen Warren wrote:
>> On 10/18/2012 04:47 AM, Laxman Dewangan wrote:
>>> Tegra20/Tegra30 supports the spi interface through its SLINK
>>> controller. Add spi driver for SLINK controller.

>>> +     val_write = SLINK_RDY;
>>> +     val_write |= (val&  SLINK_FIFO_ERROR);
>> Why not just always set SLINK_FIFO_ERROR; does it have to be set in the
>> write only if the status was previously asserted? If that is true, how
>> do you avoid a race condition where the bit gets set in SLINK_STATUS
>> after you read it but before you write to clear it?
>
> Status gets updated together. There is no steps of updating status.

Sorry, I don't understand this answer.

>>> +     spin_lock_irqsave(&tspi->lock, flags);
>>> +     if (err) {
>>> +             dev_err(tspi->dev,
>>> +                     "DmaXfer: ERROR bit set 0x%x\n",
>>> tspi->status_reg);
>>> +             dev_err(tspi->dev,
>>> +                     "DmaXfer 0x%08x:0x%08x:0x%08x\n",
>>> tspi->command_reg,
>>> +                             tspi->command2_reg,
>>> tspi->dma_control_reg);
>>> +             tegra_periph_reset_assert(tspi->clk);
>>> +             udelay(2);
>>> +             tegra_periph_reset_deassert(tspi->clk);
>> Do we /have/ to reset the SPI block; can't we just disable it in the
>> control register, clear all status, and re-program it from scratch?
>>
>> If at all possible, I would like to avoid introducing any new use of
>> tegra_periph_reset_{,de}assert, since that API has no standard subsystem
>> equivalent (or if it does, isn't hooked into the standard subsystem
>> yet), and hence means this driver relies on a header file currently in
>> arch/arm/mach-tegra/include/mach, and we need to move or delete all such
>> headers in order to support single zImage.
> 
> Is there a way to support the reset of controller. We will need this
> functionality.

Why do we need to reset the controller at all; can't we simply program
all the (few) configuration registers? Are there HW bugs that hang the
controller and require a reset or something?

------------------------------------------------------------------------------
The Windows 8 Center - In partnership with Sourceforge
Your idea - your app - 30 days.
Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
