From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
Date: Fri, 5 Sep 2014 16:14:17 +0800
Message-ID: <CAGsJ_4ysw0vy93N4evG_Aq2mMuymVXY6ig2U0EQBwQmz3uMyNA@mail.gmail.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-4-git-send-email-Barry.Song@csr.com> <20140904224132.GW29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140904224132.GW29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-09-05 6:41 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, Sep 02, 2014 at 05:02:37PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> some customers want a pure PIO transfer mode even though DMA mode is
>> supported. here we give them a Kconfig option, but still keep the DMA
>> enabled in default.
>
> This doesn't feel like something for the standard kernel - can you
> explain the benefit the customers think they're getting here?  It seems
> like either this is something we should have as a more general option,
> perhaps controllable at runtime or there's likely to be some bug or
> other problem that's being worked around here.

i have no strong technical reason for this as the benefit is not
always technical. you know....the commit log has provided the reason
for this patch.
the difficulty for me is maintaining the difference between mainline
and local codes, but if we have to maintain two copies,  we can.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
