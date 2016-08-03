From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] spi: add driver for J-Core SPI controller
Date: Wed, 3 Aug 2016 08:16:43 -0500
Message-ID: <CAL_JsqJEYtrVxZT=j97XXY2w1u1QgtpfjYSOB_H-R4y6SAb7UQ@mail.gmail.com>
References: <cover.1470187592.git.dalias@libc.org> <a452a1588abbfb1f69390a6b882ea27a449b2391.1470187592.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <a452a1588abbfb1f69390a6b882ea27a449b2391.1470187592.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 3, 2016 at 12:12 AM, Rich Felker <dalias@libc.org> wrote:

The date on your patch emails is way off.

> The J-Core "spi2" device is a PIO-based SPI master controller. It
> differs from "bitbang" devices in that that it's clocked in hardware
> rather than via soft clock modulation over gpio, and performs
> byte-at-a-time transfers between the cpu and SPI controller.
>
> This driver will be extended to support future versions of the J-Core
> SPI controller with DMA transfers when they become available.
>
> Signed-off-by: Rich Felker <dalias@libc.org>
