From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [STLinux Kernel] [PATCH v3 0/4] spi: st: New driver for ST's
 SPI Controller
Date: Mon, 8 Dec 2014 14:53:39 +0100
Message-ID: <5485AD63.6090308@st.com>
References: <1418043214-14324-1-git-send-email-lee.jones@linaro.org> <11694915.sCOqLZA7N1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11694915.sCOqLZA7N1@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 12/08/2014 02:22 PM, Arnd Bergmann wrote:
> On Monday 08 December 2014 12:53:30 Lee Jones wrote:
>> This is a new driver which controls the SPI component of ST's
>> Synchronous Serial Controller (SSC).
>>
> How does this related to the i2c driver for drivers/i2c/busses/i2c-st.c?
> Could you have the same piece of hardware do one or the other mode
> depending on pin configuration, or is each instance hardwired to
> a particular mode?
This is the same IP, that can be configured either in SPI or I2C.

>
> Is there any code worth sharing between the two drivers?
No, except a couple of registers, they are managed in a ways.

The way it is used, a single SSC instance can only be used either in SPI 
or I2C mode on a board,
so I think it wouldn't make sense to create a MFD driver to manage it.

Kr,
Maxime
>
> 	Arnd
>
> _______________________________________________
> Kernel mailing list
> Kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
> http://www.stlinux.com/mailman/listinfo/kernel

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
