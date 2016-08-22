From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Date: Mon, 22 Aug 2016 10:46:24 +0200
Message-ID: <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org> <20160819191750.GV361@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>,
        Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
        linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160819191750.GV361-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Stephen,

On Fri, Aug 19, 2016 at 9:17 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On 08/18, Geert Uytterhoeven wrote:
>> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
>> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
>> --- a/arch/mips/txx9/generic/setup.c
>> +++ b/arch/mips/txx9/generic/setup.c
>> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
>>       txx9_board_vec->time_init();
>>  }
>>
>> +static void txx9_clk_init(void)
>> +{
>> +     struct clk *clk;
>> +     int error;
>> +
>> +     clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
>
> Can we use the clk_hw_*() based variants instead please?

Yes we can.

BTW, is it intentional that clk_hw_register_clkdev() doesn't detect errors
from a previous registration call, like clk_register_clkdev() does?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
