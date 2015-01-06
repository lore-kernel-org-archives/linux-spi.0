From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: drop redundant sirf,marco-spi compatible string
Date: Tue, 6 Jan 2015 10:29:25 +0800
Message-ID: <CAGsJ_4yDjcJ6rnCDNo1uKEC+jHxrdrVoztPd2npzbKMrNkY+Eg@mail.gmail.com>
References: <1420275884-10942-1-git-send-email-21cnbao@gmail.com> <20150105212750.GS2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150105212750.GS2634-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-01-06 5:27 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Sat, Jan 03, 2015 at 05:04:44PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>>
>> "sirf,marco-spi" is redundant as all SPI controllers in CSR SiRFSoC are
>> compatible with prima2-spi.
>> at the same time, the whole marco project was dropped and its replacement
>> atlas7 is also compatible with prima2 in SPI.
>
> I don't see any pressing reason to do this (the cost is basically zero)
> and the compatible string seems to be used in a DTSI file, though
> perhaps that's going away?

its value is zero but it is necessary.
this should be clear as marco has been dropped in dtsi and machine level.
and there is no any reference for this string even in current codes.

i think i have been wrong from this commit:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-sirf.c?id=f3b8a8ecc5922d9dff303ae2fadc1eae608a6f7c

>
> I'd also say that the binding document update is missing but it seems
> this binding is undocumented.  :/

yes. i realized i missed to include the DT doc when i sent the spi
patch at the first time even though it always exists in my local tree.
i will add the missed one.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
