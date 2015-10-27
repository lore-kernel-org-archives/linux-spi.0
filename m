From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] spi: Setup the master controller driver before setting
 the chipselect
Date: Tue, 27 Oct 2015 07:22:51 -0500
Message-ID: <562F6C9B.6010607@ti.com>
References: <1445009343-28307-1-git-send-email-fcooper@ti.com>
 <CAHp75VdexZWSEEM8xjYEx9WU4dbrNrXeczvBpyKcRKn-qMN=-g@mail.gmail.com>
 <56211C0F.4090102@ti.com>
 <CAHp75VchYayRsvsjPoM9YphcjMajfvYuDrLcLrTiADVn8LU=8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, <m-karicheri2-l0cyMroinI0@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VchYayRsvsjPoM9YphcjMajfvYuDrLcLrTiADVn8LU=8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 10/16/2015 10:55 AM, Andy Shevchenko wrote:
> On Fri, Oct 16, 2015 at 6:47 PM, Franklin S Cooper Jr. <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>>
>> On 10/16/2015 10:45 AM, Andy Shevchenko wrote:
>>> On Fri, Oct 16, 2015 at 6:29 PM, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>>>> SPI controllers may need to be properly setup before chip selects
>>>> can be used. Therefore, wait until the spi controller has a chance
>>>> to perform their setup procedure before trying to use the chip
>>>> select.
>>>>
>>>> This also insures that the chip selects pins are in a good
>>>> state before asseting them which otherwise may cause confusion.
>>>>
>>>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>> Does it mean I have to test it again?
>> Oops sorry. No the patch hasn't changed. I can shoot a v3 with your tested by included.
> Whatever Mark prefers.
Hi Mark,
I don't see that you pulled this patch into your topic/core branch just yet. Would you prefer
for me to shoot a v3 with Andy's tested by or will you just add it when your ready to
pull it in?

Without this patch several of our boards don't boot in linux-next so if there is anything you
need for me to do please let me know.
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
