From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 0/3] OMAP: SPI: Driver updates
Date: Fri, 28 Oct 2011 17:19:52 +0530
Message-ID: <4EAA96E0.7060904@ti.com>
References: <1319802115-16499-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319802115-16499-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 28 October 2011 05:11 PM, Shubhrajyoti D wrote:
> The patch series does the following
> 1. Optimises the workqueue to have 1 workqueue per controller so
>   that one data of one queue doesnt interfere with other.
>   Earlier discussion thread
>
> http://sourceforge.net/mailarchive/forum.php?thread_name=1319210705-18677-1-git-send-email-shubhrajyoti%40ti.com&forum_name=spi-devel-general
>
> 2. Call pm_runtime_disable as it got missed out.
> 3. Error handling in the spi driver is corrected.
Apologies got sent twice please ignore
>
> Shubhrajyoti D (3):
>    OMAP: SPI: Use a workqueue per omap2_mcspi controller
>    OMAP: SPI: call pm_runtime_disable in error path and remove
>    OMAP: SPI: Correct the error path
>
>   drivers/spi/spi-omap2-mcspi.c |   51 +++++++++++++++++++++++++---------------
>   1 files changed, 32 insertions(+), 19 deletions(-)
>
