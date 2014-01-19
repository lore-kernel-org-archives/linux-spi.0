From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Sun, 19 Jan 2014 10:28:52 +0800
Message-ID: <52DB3864.2040606@gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com> <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com> <52D7A237.8@freescale.com> <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com> <20140117020226.GB27652@shlinux2.ap.freescale.net> <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com> <20140117065401.GA6140@shlinux2.ap.freescale.net> <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: angus.clark@st.com, Brian Norris <computersforpeace@gmail.com>,
	b44548@freescale.com, linux-doc@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Mark Brown <broonie@linaro.org>, b18965@freescale.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org, "Gupta, Pekon" <pekon@ti.com>,
	Sourav Poddar <sourav.poddar@ti.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Jagan Teki <jagannadh.teki@gmail.com>,
	Huang Shijie <b32955@freescale.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


=E4=BA=8E 2014=E5=B9=B401=E6=9C=8817=E6=97=A5 16:39, Jagan Teki =E5=86=99=
=E9=81=93:
> On Fri, Jan 17, 2014 at 12:24 PM, Huang Shijie <b32955@freescale.com>=
 wrote:
>> On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
>>>>> My basic question is like I have a qspi spi controller in my SOC =
and I
>>>>> designed two boards B1 and B2
>>>> okay.
>>>>
>>>>> B1 with quad spi controller connected with non-flash as a slave a=
nd B2
>>>>> with quad spi controller connected
>>>>> with quad flash as a slave.
>>>> You can use the framework for B2. But for B1, you should not use t=
he framework,
>>>> since this framework is just for the SPI-NOR. If you do not connec=
ted with
>>>> a NOR, i think it's better to code another driver for your control=
ler.
>>> Means we have two separate controller drivers for same controller o=
ne
>>> with spi-nor and
>>> another with spi is it?
>> Take drivers/spi/spi-imx.c for example, if you connect a NOR to it, =
you only
>> need to add a NOR device node in the device tree. In the probe, it w=
ill call
>> the m25p80.c to probe the NOR device.
>>
>> But if we connect other device to it. you should set another device =
node for it.
>>
>> I am not sure if your controller driver can works as the spi-imx.c
> My question here was - this new framework suggest to write a two
> different controller
> drivers one is for non spi-nor and spi-nor models? do you agree that?


If your controller can either connects to a NOR, or can connects to=20
other devices, it means your controller is a _BUS_.
You just need to write the bus driver for your controller, such as the=20
spi-imx.c and drivers/bus/imx-weim.c do.

Since you have connect a device to your controller. you also need to=20
write a driver for your device, such as the m25p80.c is
for your spi nor device.

Just think about that how do you code your driver for SPI NOR _without_=
=20
this framework:
do your driver need to call the m25p80.c? if you do call the m25p80.c,=20
you actually write your so-called "two drivers" :)


This framework does not change any logic for the current kernel, except=
=20
adding a layer. With the new layer, we can code the
driver for the controllers which is a SPI-NOR controller, not a SPI bus=
=20
controller.


>
> And also one important note from your design was spi-nor mode is
> completely bypassing
> Linux spi core is that the good idea?
>
yes. I think it's a good idea.

As Mark even pointed, the freescale's Quadspi controller is not a SPI=20
controller, it is a SPI-NOR controller, it does _not_ need the
LINUX SPI core.


thanks
Huang Shijie
