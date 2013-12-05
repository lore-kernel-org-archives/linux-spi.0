From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 5 Dec 2013 15:33:49 +0800
Message-ID: <20131205073348.GB8936@shlinux2.ap.freescale.net>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
 <529EE5F1.9080806@st.com>
 <201312041636.20875.marex@denx.de>
 <529FE81C.4000608@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA51E1A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>,
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
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA51E1A-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 05, 2013 at 05:43:05AM +0000, Gupta, Pekon wrote:
> >From: Huang Shijie [mailto:b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org]
> >
> >>=E4=BA=8E 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 23:36, Marek Vasut =E5=
=86=99=E9=81=93:
> >> I disagree we should bloat the API with features, that will be use=
d by "possible
> >> future controllers" or "possible single controller", right from th=
e start. The
> >> real question here is, can the API be designed in such a way, that=
 the SR
> >> polling will happen in software NOW and only when a controller app=
ears that can
> >> do polling in HW will the API be extended to support it ?
> >ok. Let's add this feature in the future when a real case occurs.
> >
> Sorry got lost.. Can you please summarize following plans for your ne=
xt patch:
>=20
> (1) Polling of status registers should be=20
>   (a) done in S/W (generic driver)
>   (b) done controller driver, which can be optimized for specific har=
dware
>=20
=46or (b), we can implement the @wait_till_ready hook for the controlle=
r driver.

=46or (a), we use the default hook for @wait_till_ready.



> (2) How do you plan to have timeout value, (as serial flash can be pr=
etty slow
>    to access) ?
>   (a) independent for each access
>        - read timeouts per sector, which can be multiplied with read_=
len/sector_size
>        - write timeout per sector, which can be multiplied with write=
_len/sector_size
>        - erase timeout per block, which can be multiplied with erase_=
len/block_size
>   (b) Any other method, or leave it to controller driver ?
>=20

Since i have no idea about this kind of spi-nor controller, so I prefer=
 the (b).=20

> In my view, before proceeding to writing down a patch, I think
> we should come-up with a doc/Readme, which defines all API and interf=
ace
> structs (taking Angus' proposal as baseline). And then refine that sp=
ec first.
> Otherwise there may be too many revisions spent on patch RFC's ..=20
>=20
> Any thoughts ?
> And is there a space in kernel_docs for such specs ?

maybe the best solution is I send out the new version as soon as possib=
le.

thanks
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
