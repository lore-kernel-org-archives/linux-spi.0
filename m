From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Thu, 10 Jul 2014 11:42:01 +0200
Message-ID: <CAMuHMdU2HyCwXBJTAyswyj7XqhzhHQ24MamGLLVgMwU4xi0kxQ@mail.gmail.com>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
	<1404982207-4707-2-git-send-email-harinik@xilinx.com>
	<CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
	<CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Sourav Poddar <sourav.poddar@ti.com>,
	"michals@xilinx.com" <michals@xilinx.com>,
	Punnaiah Chou
To: Harini Katakam <harinikatakamlinux@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Harini,

On Thu, Jul 10, 2014 at 11:31 AM, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
>>> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
>>> +                           SPI_TX_DUAL | SPI_TX_QUAD;
>>
>> Your driver advertises Dual/Quad SPI Transfer capabilities, but it doesn't
>> check spi_transfer.[tr]x_nbits? How can it determine when to enable Dual/Quad?
>
> Here the driver is just giving information that the controller support it.
> The MTD layer enables dual/quad based on what the flash supports; quad
> being the first priority
> I understand that the spi core reads rx, tx-bus-width property and
> master support flags and
> performs the necessary checks.

That's correct: as long as the rx, tx-bus-width  properties do not indicate a
Dual or Quad wiring, it won't be used.

However, based on schematics, someone may set the rx, tx-bus-width properties
to 4, which is correct, as DT describes the hardware. But this will fail to
work.
So I think it's safer not to announce Dual/Quad support in the driver until
the actual driver support is there.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
