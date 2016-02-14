From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH RFT] spi: bcm2835: Remove unnecessary workaround to call gpio_set_value
Date: Sun, 14 Feb 2016 12:28:06 +0100
Message-ID: <6AB90673-0726-4E18-BA19-146ED6988813@martin.sperl.org>
References: <1455380347.25581.1.camel@ingics.com> <67B70D1B-7FA5-48A6-8719-490FA484BFF6@martin.sperl.org> <CAFRkauCaq+4Rs_MaApZmqdZ=SiBG2GViZkm1VnjY9j-ftFsXZg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauCaq+4Rs_MaApZmqdZ=SiBG2GViZkm1VnjY9j-ftFsXZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 14.02.2016, at 04:41, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> 2016-02-14 1:08 GMT+08:00 Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>:
>>=20
>>> On 13.02.2016, at 17:19, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
>>>=20
>>> This should be fixed by commit 4c02cba18cc9
>>> ("pinctrl: bcm2835: Fix initial value for direction_output")
>>>=20
>>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>>=20
>> Actually this also solves the situation when the DT is configured
>> badly - and it is likely that old DTs are configured badly,
>> because it did not matter before (it was always wrong anyway).
>>=20
>> This change would break those old DTs in this respect and can
>> result in unexpected behavior and undetected devices.
>=20
> Hi Martin,
> I don't understand why this patch breaks old DTs.
>=20
> Before 4c02cba18cc9:
> gpio_direction_output(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1=
);
> gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
>=20
> is equivalent to
>=20
> After 4c02cba18cc9: (Already in Linus' tree)
> gpio_direction_output(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1=
);

Looking thru the bigger context now.

I thought it also impacted the GPIO-cs case, where
  cs-gpios =3D <&gpio x 1>, <&gpio y 1>;
would just define the GPIOs - as the 3rd value was always ignored
and resulted in a =E2=80=9Clow=E2=80=9D level on the GPIO via pinctrl i=
nitially -=20
at least there was a time when this has happened.
A change here would have had an impact on =E2=80=9Cold=E2=80=9D DT.

Now I see that this only impacts the native-cs case
and that should be fine.

Acked-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
