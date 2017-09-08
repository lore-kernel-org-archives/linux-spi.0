From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Use ida to manage SPI bus number
Date: Fri, 8 Sep 2017 14:26:42 +0800
Message-ID: <CAMz4kuLjEepehA43C5kGKbLC=ExxYpV-26U8K7CNjQpR0HQG0w@mail.gmail.com>
References: <2a15b398a8f8d3f6f46f9fd6e8591242d29c44a2.1504697026.git.baolin.wang@linaro.org>
 <20170906132846.il4ycaxu75ezsyt4@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906132846.il4ycaxu75ezsyt4-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 6 September 2017 at 21:28, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Sep 06, 2017 at 07:26:51PM +0800, Baolin Wang wrote:
>> This patch adds one static ida variable to manage SPI bus number, moreover
>> we can get dynamic bus number from ida instead of one "dynamic" IDs, which
>> can be removed.
>
> Someone else actually addressed this TODO item just in the last
> development cycle, v4.14 should contain an equivalent patch.  Always
> best to check linux-next for the latest development state!

Yes, I saw that patch. Then ignore this patch, sorry.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
