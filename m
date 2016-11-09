From: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Wed, 9 Nov 2016 11:37:08 -0700
Message-ID: <5828eb84-ab29-49e2-34f0-3cd7e527ca66@airwebreathe.org.uk>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de>
 <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
 <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
 <CAAtXAHe_pz=oUpeP+t-Fy0z88LMmTeSffkD2Cbun3r+uTnmGYw@mail.gmail.com>
 <feae0954-7e85-3946-defe-ce252869786d@airwebreathe.org.uk>
 <f7917987-a4cb-2840-8128-07eebd242c17@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alan Tull <atull@opensource.altera.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Clifford Wolf <clifford@clifford.at>
To: Marek Vasut <marex@denx.de>,
        Moritz Fischer <moritz.fischer@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7917987-a4cb-2840-8128-07eebd242c17@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/11/16 05:01, Marek Vasut wrote:
> On 11/08/2016 06:30 PM, Joel Holdsworth wrote:
>>>>> On the whole, I don't think the zero-length transfers are too
>>>>> egregiously bad, and all the alternatives seem worse to me.
>>>>
>>>> So why not turn the CS line into GPIO and just toggle the GPIO?
>>>
>>> Does that work with *all* SPI controllers?
>>>
>>
>> It does not - no. See my other email.
>
> And is that line an actual CS of that lattice chip or a generic input
> which almost works like CS?
>

I mean a generic output vs. a special CS output built into the SPI 
master of the application processor. Take a look at how spi_set_cs(..) 
works:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?id=refs/tags/v4.9-rc4#n695

static void spi_set_cs(struct spi_device *spi, bool enable)
{
	if (spi->mode & SPI_CS_HIGH)
		enable = !enable;

	if (gpio_is_valid(spi->cs_gpio))
		gpio_set_value(spi->cs_gpio, !enable);
	else if (spi->master->set_cs)
		spi->master->set_cs(spi, !enable);
}

So on some SPI masters, spi->master->set_cs is handled separately from 
normal GPIOs. Hence why I want to use this machinery, rather than doing 
it with a GPIO.

Joel
