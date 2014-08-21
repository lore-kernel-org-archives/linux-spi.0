From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] extcon: sm5502: EXTCON_SM5502 should depend on I2C
Date: Thu, 21 Aug 2014 09:10:50 +0200
Message-ID: <CAMuHMdVK67_d8OqSH10urTYi7EG=VaZnH9EZBiNDVACZkBRENw@mail.gmail.com>
References: <2048653519.580921408598869113.JavaMail.weblogic@epmlwas01c>
	<53F5878D.3030700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F5878D.3030700-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 21, 2014 at 7:45 AM, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 08/21/2014 02:27 PM, MyungJoo Ham wrote:
>>> Thanks for your report. I already sent a patch[1] to fix this build break
>>> and I'll send pull request to includec this patch in 3.17-rc2.
>>>
>>> [1] https://lkml.org/lkml/2014/8/13/761
>>>
>>> Best Regards,
>>> Chanwoo Choi
>>
>> I do not object to this patch or your patch[1].
>>
>> However, wouldn't it be better to add depends on I2C at REGMAP_I2C?
>> When you use REGMAP_I2C, you assume that I2C is already there, don't you?

REGMAP_I2C is meant to be "select"ed by its users. So these users
should depend on I2C, as "select" does not check dependencies.

> The previous REGMAP_I2C has not the dependency on I2C.
> So, Greert posted following patch[1] to fix it.
> [1] https://lkml.org/lkml/2014/8/17/27
>
> Also, if I2C is 'm' (module) and some driver has not dependency on I2C,
> build break happen.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
