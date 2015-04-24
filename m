From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Re-do correctly function name and 'ret' return
 value
Date: Fri, 24 Apr 2015 16:34:07 +0900
Message-ID: <5539F1EF.5020103@jinso.co.jp>
References: <1429857656-8348-1-git-send-email-cm-hiep@jinso.co.jp>	<1429857656-8348-2-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdWm2i-48mOUFCcFuXEAyFimkW+Yw7wdzgOa8rOgpfbMWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWm2i-48mOUFCcFuXEAyFimkW+Yw7wdzgOa8rOgpfbMWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert-san

Thanks for your comments,

On 2015=E5=B9=B404=E6=9C=8824=E6=97=A5 16:25, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Fri, Apr 24, 2015 at 8:40 AM, Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> =
wrote:
>> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>>
>> qspi_trigger_transfer_out_int function should be qspi_trigger_transf=
er_out_in
>> without "t". "ret" value in rspi_dma_check_then_transfer should be r=
eturned
>> insteeds of returning zero. It just returns qspi_trigger_transfer_ou=
t_in() value
>> in qspi_transfer_out_in().
> Thanks for your patch!
>
> I guess Mark will want you to split this in 3 separate patches, as it=
 does 3
> different things...
Thanks, I will split this patch in 3 separate patches.
>> Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>> ---
>>   drivers/spi/spi-rspi.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index 186924a..9304a6d 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -670,7 +670,7 @@ static int rspi_dma_check_then_transfer(struct r=
spi_data *rspi,
>>                  int ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg,
>>                                          xfer->rx_buf ? &xfer->rx_sg=
 : NULL);
>>                  if (ret !=3D -EAGAIN)
>> -                       return 0;
>> +                       return ret;
>>          }
>>
>>          return -EAGAIN;
> Upon closer look, you can just drop the "if" check, and return "ret"
> unconditionally. Or better, drop "ret", and just use
>
>          return rspi_dma_transfer(...);
Thanks, I will do it as you pointed out.


Hiep.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
