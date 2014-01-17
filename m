From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Fri, 17 Jan 2014 22:36:49 +0530
Message-ID: <CAD6G_RT1m+7BWZyYqU7Pb2+bhki-Wqs6f96=GhMyF1nHyy2wuw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
	<CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
	<52D7A237.8@freescale.com>
	<CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
	<20140117020226.GB27652@shlinux2.ap.freescale.net>
	<CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
	<20140117065401.GA6140@shlinux2.ap.freescale.net>
	<CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Woodhouse <dwmw2@infradead.org>, angus.clark@st.com,
	Shawn Guo <shawn.guo@linaro.org>, b44548@freescale.com,
	Mark Brown <broonie@linaro.org>, linux-doc@vger.kernel.org,
	b18965@freescale.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	"Gupta, Pekon" <pekon@ti.com>,
	Sourav Poddar <sourav.poddar@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Huang Shijie <b32955@freescale.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 17, 2014 at 2:09 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Fri, Jan 17, 2014 at 12:24 PM, Huang Shijie <b32955@freescale.com> wrote:
>> On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
>>> >> My basic question is like I have a qspi spi controller in my SOC and I
>>> >> designed two boards B1 and B2
>>> >
>>> > okay.
>>> >
>>> >> B1 with quad spi controller connected with non-flash as a slave and B2
>>> >> with quad spi controller connected
>>> >> with quad flash as a slave.
>>> > You can use the framework for B2. But for B1, you should not use the framework,
>>> > since this framework is just for the SPI-NOR. If you do not connected with
>>> > a NOR, i think it's better to code another driver for your controller.
>>>
>>> Means we have two separate controller drivers for same controller one
>>> with spi-nor and
>>> another with spi is it?
>> Take drivers/spi/spi-imx.c for example, if you connect a NOR to it, you only
>> need to add a NOR device node in the device tree. In the probe, it will call
>> the m25p80.c to probe the NOR device.
>>
>> But if we connect other device to it. you should set another device node for it.
>>
>> I am not sure if your controller driver can works as the spi-imx.c
>
> My question here was - this new framework suggest to write a two
> different controller
> drivers one is for non spi-nor and spi-nor models? do you agree that?
>
> And also one important note from your design was spi-nor mode is
> completely bypassing
> Linux spi core is that the good idea?

I feel these are good points to discuss all.
1. With new framework seems like we need two separate controller drivers
    one for non spi-nor and one for spi-nor with single controller hw
2. With spi-nor implementation though the hw is spi complaint but the sw is
   completely ignoring the Linux SPI core interaction.

I feel above two points are technically wrong - Please correct me if am wrong
but need all developers will join..thanks!

-- 
Jagan.
