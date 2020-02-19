From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] spi: meson-axg: add few enhanced features
Date: Wed, 19 Feb 2020 09:17:14 +0100
Message-ID: <cb4a7228-b75c-7b54-8228-14dbb370b19f@baylibre.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
        Jianxin Pan <jianxin.pan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        Xingyu Chen <xingyu.chen-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1544690354-16409-1-git-send-email-sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sunny,

On 13/12/2018 09:39, Sunny Luo wrote:
> add a few enhanced features for the SPICC controller of Meson-AXG SoC.
> 
> These patches are actually quite independent from each other, I send them
> together in case to avoid the file conflicts.
> 
> Changes since v1 at [1]
> - Add OF and COMMON_CLK dependence for SPICC in Kconfig to avoid compiling
>   error.
> 
> [1] https://lore.kernel.org/lkml/20180503213645.20694-1-yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org
> 
> Sunny Luo (3):
>   spi: meson-axg: support MAX 80M clock
>   spi: meson-axg: enhance output enable feature
>   spi: meson-axg: add a linear clock divider support
> 
>  drivers/spi/Kconfig           |   2 +-
>  drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 223 insertions(+), 49 deletions(-)
> 

Is there still a plan to push an updated version for AXG and G12A ?

Neil
