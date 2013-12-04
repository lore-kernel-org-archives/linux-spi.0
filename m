From: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Wed, 4 Dec 2013 06:58:36 +0000
Message-ID: <529ED29C.1030208@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com> <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com> <529E976E.4050104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529E976E.4050104-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/04/2013 02:46 AM, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B411=E6=9C=8829=E6=97=A5 22:52, Angus Clark =E5=86=
=99=E9=81=93:
>>     int (*write_reg)(struct spi_nor_info *info,
>>              uint8_t cmd, uint8_t *reg, int len,
>>              int wren, int wtr);
> I guess you add the 'wren' for the issuing write-enable before issuin=
g
> the 'cmd'.
>=20
> but what's 'wtr' for? i do not know what's the meaning of the 'wtr'.
>=20

'wtr' is for "Wait 'til Ready".  Some register writes are instant, whil=
e others
require polling of the "Write In Progress" bit.

Cheers,

Angus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
