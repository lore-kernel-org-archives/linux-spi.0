From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/8] spi: sirf: set default spi frequency if it is not set
Date: Fri, 5 Sep 2014 15:57:45 +0800
Message-ID: <CAGsJ_4xwsKwVJ4psBtf9pRaxFxw4k95fWLjbr+3zMck-6jfe8Q@mail.gmail.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-2-git-send-email-Barry.Song@csr.com> <20140904223913.GU29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140904223913.GU29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-09-05 6:39 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, Sep 02, 2014 at 05:02:35PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>

sorry, this patch actually has no effect now as it is outdated.

>> give spi a default frequence if it is not set and the value is 0.
>
> I think this is a good idea but I think we should do this in the SPI
> core rather than this driver since the same thing is going to apply to
> many drivers.  Can you do a patch for that?
>

this has been done by commit 052eb2d49,  sorry for making noise.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
