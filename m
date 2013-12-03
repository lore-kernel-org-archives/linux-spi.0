From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 3 Dec 2013 14:20:40 +0800
Message-ID: <529D7838.6030606@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com> <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com> <529C5BBF.6000604@freescale.com> <529C6CBB.4000008@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529C6CBB.4000008-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8802=E6=97=A5 19:19, Angus Clark =E5=86=
=99=E9=81=93:
> To be honest, I am just glad that someone is taking a look at this ar=
ea.
> However, whether or not is it possible to come up with something that=
 solves all
> our problems remains to be seen.  It might turn out that the various =
H/W
> Controllers are just too different to fit into a single unified frame=
work.
>
Hi Angus & Pekon:
thanks for the explanations.

I am not sure that after we add more hooks, if it will meet Jones's new=
=20
driver.

i will wait for Jones' comment for several days, and send out the next=20
version if he does not reply this thread.


thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
