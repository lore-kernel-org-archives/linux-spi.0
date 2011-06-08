From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: Re: [PATCH/RESEND v4 1/2] spi_topcliff_pch: support new device ML7213
 IOH
Date: Wed, 08 Jun 2011 17:35:19 +0900
Message-ID: <4DEF3447.6050209@dsn.okisemi.com>
References: <1307425811-5030-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307425811-5030-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Why don't you give us your comment/opinion at all for our v4 patch ??
We have been long waiting since 27-April.

(2011/06/07 14:50), Tomoya MORINAGA wrote:
> ***Modify Grant's comments.
>     - Delete unrelated whitespace
>     - Prevent device driver from accessing platform data
>     - Add __devinit and __devexit
>     - Save pdev->dev to pd_dev->dev.parent
>     - Have own suspend/resume processing in platform_driver.
>     - Care returned value in pch_spi_init
>     - Change unregister order
> 
> Support ML7213 device of OKI SEMICONDUCTOR.
> ML7213 is companion chip of Intel Atom E6xx series for IVI(In-Vehicle Infotainment).
> ML7213 is compatible for Intel EG20T PCH.
> 
> Signed-off-by: Tomoya MORINAGA<tomoya-linux@dsn.okisemi.com>
> ---
>   drivers/spi/Kconfig            |    5 +-
>   drivers/spi/spi_topcliff_pch.c |  599 +++++++++++++++++++++-------------------
>   2 files changed, 317 insertions(+), 287 deletions(-)
> 
-- 
tomoya
OKI SEMICONDUCTOR CO., LTD.
