From: Angus Clark <angus.clark-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
Date: Wed, 4 Dec 2013 08:21:05 +0000
Message-ID: <529EE5F1.9080806@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com> <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com> <529E976E.4050104@freescale.com> <529ED29C.1030208@st.com> <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
	"broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Poddar, Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Angus CLARK <angus.clark-qxv4g6HH51o@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA51905-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Pekon,

On 12/04/2013 07:19 AM, Gupta, Pekon wrote:
> Unless a register is controlling a status of internal state-machine, or something
> It should be instantaneously writable.

Yes, that is my point.  Some register writes are instant, other are not,
particularly those that involve non-volatile status or configuration bits.

> Also polling should not be part of this particular *(write_reg), if a register
> needs to be polled then it should be part of *(write) or *(read) .. Like 
> WIP: Write-in-progress bit of flash
> generic_flash_write(...) {
> 	while ((read_reg(STATUS_REG) & WIP) || ~timeout) {
> 		timeout--;
> 	};

I am in two minds about where the WTR loop should live.  On the one hand, moving
it to the "generic_flash_write()" call offers H/W controllers the opportunity to
optimise the polling, if they support such a feature (I know of some that will
in the future).

However, requiring the H/W driver to perform the polling, including knowledge of
the STATUS CMD, and the WIP bit-field, just seems like moving too much
"intelligence" away from the spi-nor layer.  What concerns me is when we get on
to reading/clearing error flags (as now mandated on some Serial Flash devices,
e.g. n25p512 and n25q00a), this will also need to be part of the generic write.

> With this it just came to my mind, that you also need a 'timeout' field
> in 'struct spinor-cfg'. 

Yes, that is a good point.

I would propose that the spi-nor layer retains responsibility for determining
whether or not 'WTR' is required for a particular operation, and a suitable
timeout.  At some point, during initialisation, the H/W driver will need to
inform the spi-nor layer about its capabilities (e.g. support for DUAL or QUAD
mode, any warm-reset requirements, etc), and native support of WIP polling could
be part of this set.  The spi-nor layer could then decide whether to add the WTR
flag and timeout to the spinor-cfg transfer, or to take responsibility itself,
and execute its own polling loop.  This gives greatest flexibility, which seems
to be an important factor, while retaining the knowledge in the spi-nor layer.

Cheers,

Angus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
