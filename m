From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 2/9] spi: imx: initialize usedma earlier
Date: Tue, 23 Feb 2016 11:15:59 +0100
Message-ID: <20160223111559.3c2cb641@ipc1.ka-ro>
References: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
	<1456219438-21205-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456219438-21205-3-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, 23 Feb 2016 10:23:51 +0100 Sascha Hauer wrote:
> So that the SoC specific config function can know if we will do
> DMA or not. Will be needed in following patches.
>=20
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
The first sentence of the commit log sounds silly unless you read it in
conjunction with the subject header. I made this remark already in
<20160219090846.3004de9d-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>

Is there any reason why this commit log is written as a continuation of
the subject line (whithout making that obvious) while all the other
commit logs in your patch set are self-contained?


Lothar Wa=C3=9Fmann
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
