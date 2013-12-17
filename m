From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 17 Dec 2013 05:45:38 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA56B8A@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
 <20131217040209.GA27091@shlinux2.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
 <20131217045752.GA15761@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org" <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"angus.clark-qxv4g6HH51o@public.gmane.org" <angus.clark-qxv4g6HH51o@public.gmane.org>,
	"lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
	"Poddar, Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131217045752.GA15761-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>From: Huang Shijie [mailto:b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org]
>>From: Pekon Gupta [mailto:pekon-l0cyMroinI0@public.gmane.org]
[...]
>> (1) Add sign-offs of main authors of m25p80, so that original contributors
>>  still remains in path of submission [1].
>Do you mean add the sign-offs in end of the patch 3's commit message?:
>	Signed-off-by: Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
>
I think Mike's  email ID is no-more valid. So you can either find out his
current email-Id from other sources. OR
add David's or someone else's ID which has equivalent number of
contributions in m25p80.c (that you can figure out from either commit
logs or git blame).


>>
>> (2) Also, please remove following from spi-nor.c
>>   However, you can keep this in fsl-quadspi.c.
>>   +MODULE_AUTHOR("Freescale Semiconductor Inc.");
>>   I'm sure this was _not_ present in original m25p80.c
>>  (m25p80.c was started as ST's driver as per MODULE_DESCRIPTION)
>okay.
>
Thanks much.
You can put your name instead, I don't mind that bcoz you have worked
to get this framework assembled by joining different pieces.

However, please use a email-id which is valid for long-term (preferably
your personal ID), so that even if your association with your company ends,
still there is some way to track you and keep you in loop of future patches
for this framework.

>>
>> (3)     +MODULE_LICENSE("GPL");
>> Also, I assume the license version should be "GPLv2" ?
>
>yes. it should be v2.
>

with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
