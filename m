From: Harini Katakam <harinikatakamlinux@gmail.com>
Subject: Re: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Thu, 10 Jul 2014 18:09:55 +0530
Message-ID: <CAFcVECJvvch9Li0WihqoWcGNMMDVXfrujLUq6wvca46FztYpzA@mail.gmail.com>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
	<1404982207-4707-2-git-send-email-harinik@xilinx.com>
	<CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
	<CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
	<CAMuHMdU2HyCwXBJTAyswyj7XqhzhHQ24MamGLLVgMwU4xi0kxQ@mail.gmail.com>
	<CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ@mail.gmail.com>
	<20140710120120.GD30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
	Pun
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140710120120.GD30458@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Thu, Jul 10, 2014 at 5:31 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 10, 2014 at 04:03:19PM +0530, Harini Katakam wrote:
>
>> OK. Correct me if I'm wrong but announcing this support in master->flags is
>> just to say the controller supports it - Like Punnaiah mentioned in the other
>
> No, it's broken to set this if there is no ability to use it.
>
>> mail, nothing specific needs to be done from the controller driver to enable
>> dual/quad support. This is at the SOC/IP level.
>
> How does the client driver select the width to use for a transfer?

This controller is meant to be used only with flash devices.
The flash devices' supported width will be reflected in a table in MTD layer.
When selecting, priority is given to quad over dual and single in the MTD and
it will send commands using the supported tx/rx bus width accordingly.
About the supported bus width on board, tx-bus-width and rx-bus-width
properties in dts will have the info; which I believe spi core uses.

Regards,
Harini
