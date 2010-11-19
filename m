From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 11/12] davinci: add tnetv107x evm backlight device
Date: Fri, 19 Nov 2010 19:44:00 +0300
Message-ID: <4CE6A950.8040704@mvista.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-12-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org,
	alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1290182156-20104-12-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello.

Cyril Chemparathy wrote:

> The tnetv107x evm board has a backlight device that is connected on one of the
> SSP ports.  This patch adds the board definitions necessary to plug the
> backlight driver to the GPIO corresponding to this SSP pin.

> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-davinci/board-tnetv107x-evm.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
> index e3863dd..ac62de2 100644
> --- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
> +++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
> @@ -44,6 +44,7 @@
>  #define EVM_MMC_WP_GPIO		21
>  #define EVM_MMC_CD_GPIO		24
>  #define EVM_SPI_CS_GPIO		54
> +#define EVM_BACKLIGHT_GPIO	(SSP_GPIO_START + 2)

    Why it's not aligned with others?

WBR, Sergei


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
