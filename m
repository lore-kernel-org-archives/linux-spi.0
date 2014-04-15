From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
Date: Tue, 15 Apr 2014 17:57:39 +0800
Message-ID: <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg@mail.gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com> <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com> <20140415092609.GJ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140415092609.GJ12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-04-15 17:26 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, Apr 15, 2014 at 09:43:24AM +0800, Barry Song wrote:
>
>> i felt strange too at the first look from internal gerrit. qipan told
>> me there is one:
>> drivers/spi/spidev.c
>
> OK, that needs fixing.  That code predates anyone doing DMA.

if it is out of specification, it seems fixing spidev.c is not enough
as spi transfer actually needs an precondition of tx!=rx now.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
