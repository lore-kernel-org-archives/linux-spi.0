From: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Thu, 16 Jan 2014 15:09:13 +0530
Message-ID: <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
	<CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
	<52D7A237.8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, angus.clark-qxv4g6HH51o@public.gmane.org,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D7A237.8-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Huang Shijie,

Thanks for your response, please see below.

On Thu, Jan 16, 2014 at 2:41 PM, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wr=
ote:
> =D3=DA 2014=C4=EA01=D4=C216=C8=D5 03:15, Jagan Teki =D0=B4=B5=C0:
>
>> Hi,
>>
>> On Wed, Dec 25, 2013 at 11:20 AM, Huang Shijie<b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> wrote:
>>>
>>> 1.) Why add a new framework for SPI NOR?
>>>    The SPI-NOR controller such as Freescale's Quadspi controller is
>>> working
>>>    in a different way from the SPI bus. It should knows the NOR com=
mands
>>> to
>>>    find the right LUT sequence. Unfortunately, the current code can=
 not
>>> meet
>>>    this requirement.
>>>
>>> 2.) How does this patch set do?
>>>     This patch set adds a new spi-nor layer.
>>>     Before this patch, the layer is like:
>>>
>>>                     MTD
>>>           ------------------------
>>>                    m25p80
>>>           ------------------------
>>>                 spi bus driver
>>>           ------------------------
>>>                  SPI NOR chip
>>>
>>>     After this patch, the layer is like:
>>>                     MTD
>>>           ------------------------
>>>                    spi-nor
>>>           ------------------------
>>>                    m25p80
>>>           ------------------------
>>>                 spi bus driver
>>>           ------------------------
>>>                 SPI NOR chip

Just for looking on your new framework, is that above link correct.
I guess it should be MTD -- m25p80 -- spi-nor -- spi bus driver -- SPI =
NOR chip

Because m25p80 will register to mtd core on top and will call spi core
data transfer.

Correct me if am wrong.

>>>
>>>    With the spi-nor controller driver(Freescale Quadspi), it looks =
like:
>>>                     MTD
>>>           ------------------------
>>>                    spi-nor
>>>           ------------------------
>>>                  fsl-quadspi
>>>           ------------------------
>>>                 SPI NOR chip
>>
>> I'm new to this thread, may be I'll ask basic questions.
>> 1) what does m25p80 contains with your new framework - will excludes
>> quad stuff if they add
>
> sorry, i do not understand your meaning.
>
> do you think the m25p80 can not support the quad read after this patc=
h set?
>
>
>
>> 2) I didn't understand why the controller driver fsl-quadspi will be
>> in mtd becuase as it's (q)spi driver
>> may does flash or non-flash functionalities if ie, the case should b=
e
>> part of drivers/spi/*
>
> Please read this thread, Mark though it should be spi nor driver:
>
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D137782885415953&w=3D2
>
>> 3) Can you explain your framework precisely take an example of like
>> spi_controller_A with spi_flash_A
>> and qspi_controller_B and qspi_flash_B - how will this new framework
>> operates.
>>
> The framework is just cloned from the m25p80.c, and extract the commo=
n code,
> and provides more
> hooks such as
>
> @prepare/unpreare: used to do some work before or after the
>              read/write/erase/lock/unlock.
>     @read_xfer/write_xfer: We can use these two hooks to code all
>              the following hooks if the driver tries to implement the=
m
>              by itself.
>     @read_reg: used to read the registers, such as read status regist=
er,
>              read configure register.
>     @write_reg: used to write the registers, such as write enable,
>              erase sector.
>     @read_id: read out the ID info.
>     @wait_till_ready: wait till the NOR becomes ready.
>     @read: read out the data from the NOR.
>     @write: write data to the NOR.
>     @erase: erase a sector of the NOR.
>

My basic question is like I have a qspi spi controller in my SOC and I
designed two boards B1 and B2
B1 with quad spi controller connected with non-flash as a slave and B2
with quad spi controller connected
with quad flash as a slave.

Now please tell me how your framework works in this case? how many
drivers do I need to right
and call traces.

--=20
Thanks,
Jagan.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
