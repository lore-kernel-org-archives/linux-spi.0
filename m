From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller about protocol change
Date: Tue, 8 Sep 2015 18:29:10 +0200
Message-ID: <201509081829.10398.marex@denx.de>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com> <CAOiHx=m0FhuH5BR-EYp4yQyB83yGRzdCFAPVfqB0b0+BvRE-6Q@mail.gmail.com> <55EF0AB5.3070508@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"Brian Norris" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Bean Huo (beanhuo)" <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"MTD Maling List" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55EF0AB5.3070508-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, September 08, 2015 at 06:20:05 PM, Cyrille Pitchen wrote:
> Hi Jonas,
> 
> taking your comments into account I'm about to test a new series with
> additional patches to handle the Read ID command in multiple I/O protocols
> and relying on new members in the struct spi_nor:
> 
>  * @erase_proto:	the SPI protocol used by erase operations
>  * @read_proto:		the SPI protocol used by read operations
>  * @write_proto:	the SPI protocol used by write operations
>  * @reg_proto		the SPI protocol used by read_reg/write_reg operations
> 
> 	enum spi_protocol	erase_proto;
> 	enum spi_protocol	read_proto;
> 	enum spi_protocol	write_proto;
> 	enum spi_protocol	reg_proto;
> 
> This way, the read(), write(), erase(), read_reg() and write_reg() hooks
> can check the relevant protocol member so the spi-nor framework doesn't
> need to call spi_nor_set_protocol() before any command.
> 
> Also the op codes for read, page program and erase commands will be tuned
> depending on the memory manufacturer and the selected SPI protocol.
> 
> I'm likely to publish this new series tomorrow after my tests on a Micron
> memory.

Excellent, please keep me on Cc as I'm already warming up my Spansion part ;-)

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
