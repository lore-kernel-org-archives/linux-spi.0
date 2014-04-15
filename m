From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
Date: Tue, 15 Apr 2014 09:43:24 +0800
Message-ID: <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
	<1397457001-5266-6-git-send-email-21cnbao@gmail.com>
	<20140414200628.GX25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140414200628.GX25182-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-04-15 4:06 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Mon, Apr 14, 2014 at 02:30:01PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> sometimes t->tx can be equal with t->rx. for example, spidev will make
>> tx and rx point to spidev->buffer at the same time. currently, for this
>> case, we map the buffer BIDIRECTION to fix the cache consistency.
>
> I've applied this but such usage is out of spec - do we have any drivers
> doing this in mainline?

i felt strange too at the first look from internal gerrit. qipan told
me there is one:
drivers/spi/spidev.c

static int spidev_message(struct spidev_data *spidev,
                struct spi_ioc_transfer *u_xfers, unsigned n_xfers)
{
buf = spidev->buffer;
..
k_tmp->rx_buf = buf;
...
k_tmp->tx_buf = buf;
...
spi_message_add_tail(k_tmp, &msg);

spidev_sync(spidev, &msg);
}

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
