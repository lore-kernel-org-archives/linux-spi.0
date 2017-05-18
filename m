From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Thu, 18 May 2017 16:59:18 +0300
Message-ID: <1495115958.26925.23.camel@nxp.com>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495113735-11891-1-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2017-05-18 at 10:22 -0300, Fabio Estevam wrote:
> This reverts commit 8d4a6cad7adb3ddac32cd52635f20e11de11a658.
> 
> Commit 8d4a6cad7adb ("spi: imx: dynamic burst length adjust for PIO mode")
> breaks the detection of the SPI NOR on a imx6q-sabresd board:
> 
> m25p80 spi0.0: unrecognized JEDEC id bytes: 10, 00, 00
> 
> # cat /proc/mtd 
> dev:    size   erasesize  name
> 
> After reverting this commit SPI works back to normal again:
> 
> m25p80 spi0.0: m25p32 (4096 Kbytes)
> 
> # cat /proc/mtd 
> dev:    size   erasesize  name
> mtd0: 00400000 00010000 "spi0.0"
> 
> It also causes kernel crashes on imx6dl-sabreauto and imx6sl-evk boards
> as reported by Leonard Crestez, so better revert it.

A fix was already posted: https://lkml.org/lkml/2017/5/18/264. Can you
check it in your scenario? I don't know if a revert or a fix is more
appropriate.

It seems to me the crash is triggered by the way spi-nor uses the SPI
API. It's strange that you get a wrong ID instead of a crash.

I checked that after the fix the flash block is detected and it can be
read from, but not that the transferred data is correct.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
