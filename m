From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [bug report] spi: Add ADI driver for Spreadtrum platform
Date: Wed, 25 Oct 2017 17:10:15 +0800
Message-ID: <CAMz4kuKeHdZ1Na6JquCX0=o1j_OMB6Y9t9FGF-RM8XvzUmbSJw@mail.gmail.com>
References: <20171025085723.4z7rmwhtt265nyi5@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171025085723.4z7rmwhtt265nyi5@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Dan,

On 25 October 2017 at 16:57, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> Hello Baolin Wang,
>
> The patch 7e2903cb91df: "spi: Add ADI driver for Spreadtrum platform"
> from Sep 15, 2017, leads to the following static checker warning:
>
>         drivers/spi/spi-sprd-adi.c:312 sprd_adi_hw_init()
>         warn: 'chn_id - 32' is negative one
>
> drivers/spi/spi-sprd-adi.c
>    293          chn_cnt = size / 8;
>    294          for (i = 0; i < chn_cnt; i++) {
>    295                  u32 value;
>    296                  u32 chn_id = be32_to_cpu(*list++);
>                             ^^^^^^
> Let's imagine chn_id == 31.
>
>
>    297                  u32 chn_config = be32_to_cpu(*list++);
>    298
>    299                  /* Channel 0 and 1 are software channels */
>    300                  if (chn_id < 2)
>    301                          continue;
>    302
>    303                  writel_relaxed(chn_config, sadi->base +
>    304                                 REG_ADI_CHN_ADDR(chn_id));
>    305
>    306                  if (chn_id < 31) {
>                             ^^^^^^^^^^^
> This is false.

Ah, you are correct. Sorry for my mistake, here the check should be
chn_id <= 31. I will send one patch to fix this issue. Thanks.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
