From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 3 Dec 2013 08:23:43 +0000
Message-ID: <20131203082343.GK31626@lee--X1>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com>
 <529C5BBF.6000604@freescale.com>
 <529C6CBB.4000008@st.com>
 <529D7838.6030606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, marex-ynQEQJNshbs@public.gmane.org,
	broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529D7838.6030606-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> >To be honest, I am just glad that someone is taking a look at this a=
rea.
> >However, whether or not is it possible to come up with something tha=
t solves all
> >our problems remains to be seen.  It might turn out that the various=
 H/W
> >Controllers are just too different to fit into a single unified fram=
ework.
> >
> Hi Angus & Pekon:
> thanks for the explanations.
>=20
> I am not sure that after we add more hooks, if it will meet Jones's
> new driver.

Angus is the author of "Lee's" driver and knows more about it that I
ever will, so whatever he says goes in that regard.

I would like to make a suggestion to Brian though. Even if the new
framework is written within the next couple of months and the
semantics do suit the FSM Controller driver, I'd still like the
implementation that's currently on the list to be applied. That way
we'd have a known good version of the driver which is almost identical
to how ST's internal driver does now. The one that is present out in
the wild (i.e. _real_ products).

I will subsequently volunteer to provide my utmost best efforts to
port the driver over to the new framework as a new task once it has
landed.

> i will wait for Jones' comment for several days, and send out the
> next version if he does not reply this thread.

/me waves \o/

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
