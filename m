From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 05/12] davinci: add spi devices on tnetv107x evm
Date: Fri, 19 Nov 2010 19:25:58 +0300
Message-ID: <4CE6A516.402@mvista.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-6-git-send-email-cyril@ti.com>
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
In-Reply-To: <1290182156-20104-6-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
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

> This patch adds definitions for spi devices on the tnetv107x evm platform.

> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-davinci/board-tnetv107x-evm.c |   43 +++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
> index ef526b1..1a656e8 100644
> --- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
> +++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
[...]
> @@ -202,9 +204,45 @@ static struct matrix_keypad_platform_data keypad_config = {
>  	.no_autorepeat	= 0,
>  };
>  
> +static void spi_select_device(int cs)
> +{
> +	static int gpio;
> +
> +	if (!gpio) {
> +		int ret;
> +		ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");

    Why not just:

		int ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");

    Also, and empty line after declaration wouldn't hurt.

> +		if (ret < 0) {
> +			pr_err("cannot open spi chipsel gpio\n");
> +			gpio = -ENOSYS;
> +			return;
> +		} else {
> +			gpio = EVM_SPI_CS_GPIO;
> +			gpio_direction_output(gpio, 0);
> +		}
> +	}
> +
> +	if (gpio < 0)
> +		return;
> +
> +	return gpio_set_value(gpio, cs ? 1 : 0);

    Why not do it right with gpio_direction_output() call?

WBR, Sergei


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
