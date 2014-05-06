From: Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: sirf: decrease the interrupt count and
 latency of PIO mode
Date: Tue, 6 May 2014 09:10:32 +0800
Message-ID: <CAGsJ_4zN6mpa1_auXAiV5RsEPkgB7924MDZvfvh5AqGgZAizgw@mail.gmail.com>
References: <1399185156-521-1-git-send-email-swingboard@gmail.com> <20140505192344.GL22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Qipan Li <swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140505192344.GL22111-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-05-06 3:23 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Sun, May 04, 2014 at 02:32:36PM +0800, Qipan Li wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> current PIO tranfer method be described as follows:
>
> I'm missing patch 1 here.

this is a follow of "[PATCH 2/2] spi: sirf: decrease the interrupt
count and latency of PIO mode", as you have applied 1/2 - [PATCH 1/2]
spi: sirf: refactor spi transfer functions, so there is no patch 1/2
here.
qipan made a typo , this should be directly a patch but not a 2/2. so
pls take it as a separate patch.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
