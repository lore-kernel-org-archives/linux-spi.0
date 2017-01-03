From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: dw: Make debugfs name unique between instances
Date: Wed, 4 Jan 2017 01:05:31 +0200
Message-ID: <CAHp75VfeX+9b2bEt9VdNrOX9+jbqfvXx8rk=K2FJsoghRoxQJA@mail.gmail.com>
References: <1483419249-88956-1-git-send-email-preid@electromag.com.au> <CAHp75Vc=h1eepd3DYEiSxP_vG1CS+FyKijmEYtw8Td7dj_VZOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vc=h1eepd3DYEiSxP_vG1CS+FyKijmEYtw8Td7dj_VZOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 4, 2017 at 1:02 AM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jan 3, 2017 at 6:54 AM, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org> wrote:
>> Some system have multiple dw devices. Currently the driver uses a
>> fixed name for the debugfs dir. Append bus_num to the debugfs dir
>> name to make it unique.
>>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Ah, hold on.
dws->name is exactly what you are trying to re-invent here. Just use
it directly.


>
>> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
>> ---
>>
>> Notes:
>>     Changes from v1:
>>     - Reduce buffer size to 32.
>>     - Use bus_num instead of device name.
>>
>>  drivers/spi/spi-dw.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index 27960e4..77439ac 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -107,7 +107,10 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
>>
>>  static int dw_spi_debugfs_init(struct dw_spi *dws)
>>  {
>> -       dws->debugfs = debugfs_create_dir("dw_spi", NULL);
>> +       char name[32];
>> +
>> +       snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
>> +       dws->debugfs = debugfs_create_dir(name, NULL);
>>         if (!dws->debugfs)
>>                 return -ENOMEM;
>>
>> --
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
