From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for SLINK controller
Date: Mon, 29 Oct 2012 12:55:29 -0600
Message-ID: <508ED121.1050702@wwwdotorg.org>
References: <1350557233-31234-1-git-send-email-ldewangan@nvidia.com> <5085A667.2000100@wwwdotorg.org> <508ADB1C.6040602@nvidia.com> <508E9E22.6030201@wwwdotorg.org> <508EAC61.4020400@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <508EAC61.4020400@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/29/2012 10:18 AM, Laxman Dewangan wrote:
> On Monday 29 October 2012 08:47 PM, Stephen Warren wrote:
>> On 10/26/2012 12:49 PM, Laxman Dewangan wrote:
>>>>
>>>> Why not just always set SLINK_FIFO_ERROR; does it have to be set in the
>>>> write only if the status was previously asserted? If that is true, how
>>>> do you avoid a race condition where the bit gets set in SLINK_STATUS
>>>> after you read it but before you write to clear it?
>>> Status gets updated together. There is no steps of updating status.
>> Sorry, I don't understand this answer.
> 
> The status should be updated once by HW and so there is no race condition.
> HW behavior is that if the tx or Rx error occurs, it updates the status,
> generates interrupt and still continue transfer and later on, it
> generates the ready.
> In first isr, we read status, error status found and so in isr thread,
> we reset controller to stop the transfer.
> 
> So in good state, only ready bit will be set and hence writing 1 to
> clear it.
> In error state, clearing error first in ISR and in isr thread resetting
> the controller to stop the controller engine.

OK, I see why there's no race. It still seems simply to me if
tegra_slink_clear_status() just always writes all the status bits, but I
suppose it isn't a correctness issue.

>>> Is there a way to support the reset of controller. We will need this
>>> functionality.
>>
>> Why do we need to reset the controller at all; can't we simply program
>> all the (few) configuration registers? Are there HW bugs that hang the
>> controller and require a reset or something?
> 
> HW generates error,  then interrupt and still continue transfer and
> later point of time it generates the transfer done.
> We want to stop the transfer once error get detected. For this we need
> to reset controller.
> I did disabling rx and tx but still controller shows as busy.

Oh dear. Well, I guess it'll have to be OK then; we'll just have to find
a way of decoupling this API from the mach-tegra directory later:-(
