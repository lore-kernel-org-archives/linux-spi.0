From: Girish KS <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 0/5] Add polling support for 64xx spi controller
Date: Mon, 25 Mar 2013 08:57:56 +0530
Message-ID: <CAKrE-Kfgw+ofmkN+aMVNeeLm=+4owJ0U=qAmj2o0oARm6BSCQQ@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363157014-9615-1-git-send-email-ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello grant,

any comments on this patch series?


On Wed, Mar 13, 2013 at 12:13 PM, Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> [PATCH 1/5]: fixes the error handling in the interrupt handler
> [PATCH 2/5]: The existing driver support partial polling mode.
>              This patch modifies the current driver to support
>              only polling mode.
> [PATCH 3/5]: provision to support SoC's with dedicated i/o pins
> [PATCH 4/5]: provision to support dedicated cs pin
> [PATCH 5/5]: support exynos5440 SoC in polling mode
>
> Tested this patch on exynos5250 in dma mode, and exynos5440 in
> polling mode.
>
> changes in v3:
>             Rebase it to the linus's master branch. After rebase
> there was a logical code change due to the merge of generic dma
> patch. resolved the merge conflicts and tested for the functionality
>
> Girish K S (5):
>   spi: s3c64xx: modified error interrupt handling and init
>   spi: s3c64xx: added support for polling mode
>   spi: s3c64xx: Added provision for non-gpio i/o's
>   spi: s3c64xx: Added provision for dedicated cs pin
>   spi: s3c64xx: Added support for exynos5440 spi
>
>  drivers/spi/spi-s3c64xx.c                 | 204 +++++++++++++++++++++---------
>  include/linux/platform_data/spi-s3c64xx.h |   3 +
>  2 files changed, 148 insertions(+), 59 deletions(-)
>
> --
> 1.8.0
>

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
