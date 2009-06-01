From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [spi-devel-general] [PATCH] ARM PL022 SSP/SPI driver v1
Date: Mon, 1 Jun 2009 13:44:52 +0200
Message-ID: <63386a3d0906010444v4dc5a782v741b65b85c3da95c@mail.gmail.com>
References: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
	<20090601041711.GE14148@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alessandro Rubini <rubini-list@gnudd.com>, sachin.verma@st.com,
	andrea.gallo@stericsson.com, STEricsson_nomadik_linux@list.st.com
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090601041711.GE14148@tarshish>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Thanks for your helpful review Baruch, I've fixed most things I think...

2009/6/1 Baruch Siach <baruch@tkos.co.il>:

>> +/**
>> + * struct chip_data - To maintain runtime state of SSP for each client chip
>> + * @cr0: Value of control register CR0 of SSP
>> + * @cr1: Value of control register CR1 of SSP
>> + * @dmacr: Value of DMA control Register of SSP
>> + * @cpsr: Value of Clock prescale register
>> + * @n_bytes: how many bytes(power of 2) reqd for a given data width of client
>> + * @enable_dma: Whether to enable DMA or not
>> + * @write: function ptr to be used to write when doing xfer for this chip
>> + * @read: function ptr to be used to read when doing xfer for this chip
>> + * @cs_control: chip select callback provided by chip
>> + * @xfer_type: polling/interrupt/DMA
>> + *
>> + * Runtime state of the SSP controller, maintained per chip,
>> + * This would be set according to the current message that would be served
>> + */
>> +struct chip_data {
>> +     u16 cr0;
>> +     u16 cr1;
>> +     u16 dmacr;
>> +     u16 cpsr;
>> +     u8 n_bytes;
>> +     u8 enable_dma:1;
>> +     enum ssp_reading read;
>> +     enum ssp_writing write;
>> +     void (*cs_control) (u32 command);
>
> Isn't there a way for the PL022 block itself to control the chip select?

Sadly no. Or rather, I think most SoC designers want to be free to
implement that themselves any way they choose.

> In
> case there isn't one, IMHO you should provide simple way to use the generic
> GPIO API for chip select. See for example drivers/spi/atmel_spi.c, and my
> DesignWare driver that you reviewed.

Yep I saw that, the problem is that the PL022 is synthesized in many many
designs, and the ways of doing chip select does not have to be GPIO pins
actually.

For this particular chip I have a dummy chip driver that does not connect
anywhere, it puts the chip into loopback mode so you can test the driver by
bombing it with a few transactions. It uses  a NULL CS function so nothing
really happens when the chip select callback is called on this chip.

I can think of a few other strange ways of activating chip selects too, like
writing I2C registers in some other off-mainchip subchip etc so I think
I'd better leave this open and each platform can decide for itself how
to implement it, generic GPIO being one way.

Linus Walleij

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
