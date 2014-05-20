From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: send more words at the TX initial phase
Date: Wed, 21 May 2014 07:26:41 +0800
Message-ID: <CAGsJ_4x=+CMWub37Rxk+H+9r0rmO2wpc02cW1nmwzE4cYiakyw@mail.gmail.com>
References: <1400566068-2781-1-git-send-email-21cnbao@gmail.com> <20140520222615.GM12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140520222615.GM12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-05-21 6:26 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, May 20, 2014 at 02:07:48PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> The old codes use the below flow to do TX: send one word at first, after
>> this word is finished and TX empty interrupt is generated, send more
>> words. This causes redundant interrupt overhead at least for the 1st
>> word.
>
> This looks very like the patch I just applied before I looked at this
> one...  is there any difference between the two other than the
> changelog?

nothing different except commit log.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
