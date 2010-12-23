From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 2/2] spi_imx.c: TRIVIAL mx25 & mx35 SPI_VER is 0.7
Date: Thu, 23 Dec 2010 15:38:04 +0100
Message-ID: <AANLkTik_DBHe0fGGuzwtDP7XFqcmuVuADmL3b+5no0Bm@mail.gmail.com>
References: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com>
 <1293102730-32528-2-git-send-email-richard.genoud@gmail.com> <20101223142934.GU14221@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101223142934.GU14221@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/12/23 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Thu, Dec 23, 2010 at 12:12:10PM +0100, Richard Genoud wrote:
>> The check on cpu_is_mx25 and cpu_is_mx35 was made twice.
>> This is obviously wrong.
> obviously wrong but no wrong behaviour. =C2=A0Your patch only makes t=
he code
> consistent, but IMHO it doesn't qualify as a bugfix.
yes, that's what I said, this patch doesn't change the behaviour, it's
only janitoring (I could have CC the list by the way).

If the whole SPI_IMX_VER_AUTODETECT system is going to be trashed,
sure, my patch is useless...

>
>> Anyway, this patch won't change the previous behaviour which is
>> SPI_IMX_VER_0_7 for mx25 and mx35.
> This conflicts with
> http://mid.gmane.org/1290589546-21662-1-git-send-email-u.kleine-koeni=
g@pengutronix.de
>
> which I prefer. =C2=A0The platform IDs have it correct (i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx25-cspi -> 0.7
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx31-cspi -> 0.4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx35-cspi -> 0.7
>
> )
>
> Best regards
> Uwe
>
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>> =C2=A0drivers/spi/spi_imx.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
>> index 793ae99..96be9d1 100644
>> --- a/drivers/spi/spi_imx.c
>> +++ b/drivers/spi/spi_imx.c
>> @@ -806,7 +806,7 @@ static int __devinit spi_imx_probe(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_mx25() |=
| cpu_is_mx35())
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spi_imx->devtype_data =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_imx_devtype_data[SPI_IMX_VER_0_=
7];
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_mx25() |=
| cpu_is_mx31() || cpu_is_mx35())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_mx31())
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 spi_imx->devtype_data =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_imx_devtype_data[SPI_IMX_VER_0_=
4];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_mx2=
7() || cpu_is_mx21())
>> --
>> 1.7.1
>>

Richard.
