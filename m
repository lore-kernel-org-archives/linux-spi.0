From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
Date: Sun, 07 Sep 2014 08:55:53 +0800
Message-ID: <D031CD59.21619%21cnbao@gmail.com>
References: <20140906135550.GD2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140906135550.GD2601-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 14-9-6 =CF=C2=CE=E79:55, "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

>On Fri, Sep 05, 2014 at 04:14:17PM +0800, Barry Song wrote:
>
>> i have no strong technical reason for this as the benefit is not
>> always technical. you know....the commit log has provided the reason
>> for this patch.
>> the difficulty for me is maintaining the difference between mainline
>> and local codes, but if we have to maintain two copies,  we can.
>
>OK, well I think that's best though it would be better if we were able
>to understand what benefit your customers believe they are seeing here
>and hopefully address it in a better way.  Doing this sort of thing wi=
th
>Kconfig options is not great, especially when you start trying to buil=
d
>kernels that work with more than one board.

my goal is doubling-check this with customers, if there is no problem,
drop this one as it is not a valid technical solution.

-barry



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
