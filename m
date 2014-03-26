From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Enable driver compilation with COMPILE_TEST
Date: Wed, 26 Mar 2014 16:53:10 +0800
Message-ID: <CAFRkauDK3nsSf+kYbbk0piFSzak3rkC_7X_VxyrFSQKoYdrdvA@mail.gmail.com>
References: <1395822170.7555.0.camel@phoenix>
	<1395822666.112180924@f305.i.mail.ru>
	<CAFRkauAS-q0+z1YKvbU=j==faK48WHgWdDmSnjjtcEnJWG8syA@mail.gmail.com>
	<1395822990.6485242@f305.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395822990.6485242-lVoEP/phaDtsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-03-26 16:36 GMT+08:00 Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>:
> Wed, 26 Mar 2014 16:34:50 +0800 =CF=D4 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>=
:
>> >
>> > MFD_SYSCON is selected by ARCH_CLPS711X and this symbol is
>> > not needed for COMPILE_TEST, so I am do not agree with this patch.
>>
>> COMPILE_TEST is purely for build test.
>> I have no problem to build this driver for x86 and some arm configs
>> with this patch.
>
> Yes. but driver can be compiled without MFD_SYSCON in such cases.

Ok. v2 is no the way.

Thanks,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
