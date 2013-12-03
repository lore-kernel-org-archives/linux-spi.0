From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 3 Dec 2013 18:36:50 +0800
Message-ID: <529DB442.90206@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com> <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com> <201312030132.10410.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201312030132.10410.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8803=E6=97=A5 08:32, Marek Vasut =E5=86=
=99=E9=81=93:
> Finally, the erase_sector() call would probably need to be extended. =
I would
> rename it to simple erase(), since we can erase from sub-sectors (4K)=
 to whole
> chip.
yes. this is what i am coding now. I rename it to erase().

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
