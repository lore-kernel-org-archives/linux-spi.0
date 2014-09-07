From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Sun, 07 Sep 2014 08:50:19 +0800
Message-ID: <D031CA8D.21605%21cnbao@gmail.com>
References: <20140906135735.GE2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, swingboard <swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140906135735.GE2601-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 14-9-6 =CF=C2=CE=E79:57, "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

>On Fri, Sep 05, 2014 at 11:34:57AM +0800, swingboard wrote:
>> 2014-09-05 3:19 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>
>> > I'm not quite sure I understand the rationale here - as far as I c=
an
>> > tell this is making the GPIO request happen later not earlier so i=
t's
>> > not clear to me what the problem this is fixing in the existing co=
de.
>> > If the goal is to move the request around in the probe function wh=
y
>>not
>> > just move the existing code earlier in probe()?
>
>> As GPIO cs can be high or low validate and the used GPIO pin with
>> default value may high or low,
>> it is need do spi device's chipselect invalidation work in spi_setup=
,
>> the patch purpose for it.
>> master->cs_gpios only assigned after spi_bitbang_start and the
>> function call spi_setup,
>> if keep the existing code there will result gpio usage before gpio
>>request.
>> just move gpio request code in spi_sirfsoc_setup before gpio use.
>
>I'm still having a hard time understanding why pulling the code earlie=
r
>in probe isn't a better fix here.

Gpio is unknown before spi_bitbang_start(). Everything is done in the b=
ig
routine spi_bitbang_start(). It includes:
Get cs_gpios, extend spi devices, and setup cs to de-active.

-barry


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
