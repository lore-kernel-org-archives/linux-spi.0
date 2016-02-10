From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug in in spi-bcm53xx (rcu_sched) exposed by 0461a41 ("spi: Pump
 transfers inside calling context for spi_sync()")
Date: Wed, 10 Feb 2016 14:04:21 +0100
Message-ID: <CACna6rzL-++_k68-VFQ4A9+gKHBJwhB5PJgU7wDwLQwi0vCCQQ@mail.gmail.com>
References: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q@mail.gmail.com>
	<20160210124828.GX13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160210124828.GX13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10 February 2016 at 13:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Feb 10, 2016 at 01:21:04PM +0100, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>
>> Unfortunately the bug in spi-bcm53xx isn't obvious for me. I kept
>> looking at its code for a bit but couldn't find anything.
>
>> Knowing the commit that exposed this bug, does it give you any hint
>> what may be wrong with spi-bcm53xx?
>
> It's most likely just hammering the CPU for a very long time without
> scheduling due to doing a long PIO transfers.  That change just remov=
es
> some needless context switching.

The fact is it happens only after flashing firmware, when flash is
formatted for the first time. After flashing some changes from ramfs
are likely flushed to the falsh. I guess it matches your theory of
long time CPU hammering.

Any idea how to handle this?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
