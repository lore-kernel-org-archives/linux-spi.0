From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Applied "spi: sunxi: fix transfer timeout" to the spi tree
Date: Fri, 21 Aug 2015 10:07:15 +0200
Message-ID: <CAOMqctQWH8Aku=m0t1q4R3WaYaE-H2AtYoDSUc-XJsPdSgL+fw@mail.gmail.com>
References: <E1ZSX2x-0001y5-Q5@finisterre> <20150820232023.GY12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150820232023.GY12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21 August 2015 at 01:20, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Aug 20, 2015 at 02:06:51PM -0700, Mark Brown wrote:
>> The patch
>>
>>    spi: sunxi: fix transfer timeout
>>
>> has been applied to the spi tree at
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> ...and reverted since it broke the build.

It depends on the patch spi: sunxi: check that transfer speed is non-zero

Got the patch order wrong, sorry.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
