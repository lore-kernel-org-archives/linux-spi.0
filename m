From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: sirf: add support for USP-based SPI
Date: Tue, 19 May 2015 22:41:09 +0800
Message-ID: <CAGsJ_4yTm_JE36iGNxw5sk4BaugfmwMLQQUFPX_kQrTamkX91Q@mail.gmail.com>
References: <1431602829-12428-1-git-send-email-21cnbao@gmail.com> <20150519112201.GH2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150519112201.GH2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-05-19 19:22 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, May 14, 2015 at 11:27:09AM +0000, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> USP is a general purpose serial port in SiRFSoC, which can work as SPI.
>> the most data flow of USP and pure SPI is same with main differences
>> in registers layout.
>
> This doesn't apply against current code, please check and resend.

sorry.
i made a big mis-operation. right now i sent a new version to fix it.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
