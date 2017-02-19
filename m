From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [spi:topic/lantiq-ssc 11/12] drivers/spi/spi-lantiq-ssc.c:38:0:
 warning: "SPI_STAT" redefined
Date: Sun, 19 Feb 2017 23:56:51 +0100
Message-ID: <78872df1-ddbb-79cf-7fc3-da07d900bc47@hauke-m.de>
References: <201702200120.GUUW1HrG%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201702200120.GUUW1HrG%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/19/2017 06:42 PM, kbuild test robot wrote:
> Hi Hauke,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git topic/lantiq-ssc
> head:   30fb27239f987c53429f24297f5d46e28d0e16ed
> commit: 582c97f6868cf70720a17d2421d317333f3ad597 [11/12] spi: lantiq-ssc: activate under COMPILE_TEST
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 582c97f6868cf70720a17d2421d317333f3ad597
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin 
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/spi/spi-lantiq-ssc.c:38:0: warning: "SPI_STAT" redefined
>     #define SPI_STAT  0x14
>     
>    In file included from arch/blackfin/mach-bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:15,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from drivers/spi/spi-lantiq-ssc.c:10:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:74:0: note: this is the location of the previous definition
>     #define SPI_STAT                0xFFC00508 /* SPI Status register */
>     
> 
> vim +/SPI_STAT +38 drivers/spi/spi-lantiq-ssc.c

I think the blackfin.h should change and not export such generic names.
Or should I prefix the defines with LTQ_ or something else in the
spi-lantiq-ssc.c driver?

I do not think this SPI SIP block was or will ever be used with the
blackfin arch.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
