From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
Date: Wed, 1 Oct 2014 21:24:44 +0200
Message-ID: <CACna6ry0TWgjfjDbAxVndrJFUu3HJe-U_HtayPruqDF6b51UGg@mail.gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
	<20141001182003.GB17974@sirena.org.uk>
	<20141001184303.GX1193@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>,
	David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141001184303.GX1193@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 1 October 2014 20:43, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> On Wed, Oct 01, 2014 at 07:20:03PM +0100, Mark Brown wrote:
>> On Mon, Sep 29, 2014 at 11:47:53AM +0200, Rafa=C5=82 Mi=C5=82ecki wr=
ote:
>> > This simplifies the way we use spi_nor framework and will allow us=
 to
>> > drop spi_nor_match_id.
>>
>> Please don't CC linux-spi on spi-nor patches that don't have SPI lev=
el
>> changes, it just clogs up patchwork.
>
> +1 from me. I appreciate the converse, as I don't need unrelated nois=
e
> on linux-mtd.
>
> (I feel sorry for people over at linux-arm-kernel and devicetree, sin=
ce
> they get CC'd on a large variety of unrelated things, it seems. I'm s=
ure
> the firehose gets to be almost as bad as LKML sometimes.)

Sorry, I usually don't. AFAIR this time I copied receivers list from
the original Ben patch / discussion about auto loading.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
