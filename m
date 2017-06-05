From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] spi: davinci: Fix compilation warning.
Date: Mon, 5 Jun 2017 18:59:15 +0530
Message-ID: <211a274a-e7c2-6f74-7ab0-e122240dc8f7@gmail.com>
References: <b6b0d421633c6ea51cdaf3e582f8bebd2034251c.1496664791.git.arvind.yadav.cs@gmail.com>
 <CAMuHMdU-o1zw5ETY3d7tV4kQ7K5wf4KuPBhZL3akQwiKj3+cHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Murali Karicheri <m-karicheri2@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU-o1zw5ETY3d7tV4kQ7K5wf4KuPBhZL3akQwiKj3+cHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
  yes, You are right. we are getting this warning.
drivers/spi/spi-davinci.c: In function ‘davinci_spi_probe’:
drivers/spi/spi-davinci.c:919:7: warning: assignment makes integer from 
pointer without a cast [enabled by default]
    ret = spi_davinci_get_pdata(pdev, dspi);

We should return 'int' in both the case.

  Thanks
  ~arvind

On Monday 05 June 2017 06:37 PM, Geert Uytterhoeven wrote:
> Hi Arvind,
>
> On Mon, Jun 5, 2017 at 2:14 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> If CONFIG_OF is disable, it'll through compilation warning.
>>
>> drivers/spi/spi-davinci.c: In function ‘spi_davinci_get_pdata’:
>> drivers/spi/spi-davinci.c:880:2: warning: return makes pointer from integer without a cast [enabled by default]
>>    return -ENODEV;
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/spi/spi-davinci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index 2b0805d..93a4009 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -877,7 +877,7 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
>>          *spi_davinci_get_pdata(struct platform_device *pdev,
>>                  struct davinci_spi *dspi)
>>   {
>> -       return -ENODEV;
>> +       return ERR_PTR(-ENODEV);
>>   }
>>   #endif
> And you don't get a warning for spi_davinci_probe() doing
>
>      int ret;
>
>      ret = spi_davinci_get_pdata(pdev, dspi);
>
> ?
>
> spi_davinci_get_pdata() returns int if CONFIG_OF, else a pointer.
> I guess it always should return int instead.
>
> It's been like this since the function was introduced, in commit
> aae7147dfc522062 ("spi/davinci: add OF support for the spi controller").
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
