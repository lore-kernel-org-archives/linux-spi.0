From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 5 Dec 2013 10:42:36 +0800
Message-ID: <529FE81C.4000608@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com> <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com> <529EE5F1.9080806@st.com> <201312041636.20875.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>, "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Poddar, Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201312041636.20875.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 23:36, Marek Vasut =E5=86=
=99=E9=81=93:
> I disagree we should bloat the API with features, that will be used b=
y "possible
> future controllers" or "possible single controller", right from the s=
tart. The
> real question here is, can the API be designed in such a way, that th=
e SR
> polling will happen in software NOW and only when a controller appear=
s that can
> do polling in HW will the API be extended to support it ?
ok. Let's add this feature in the future when a real case occurs.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
