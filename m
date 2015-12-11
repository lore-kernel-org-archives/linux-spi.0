From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] gpio: Add driver for SPI serializers
Date: Fri, 11 Dec 2015 22:43:35 +0100
Message-ID: <CACRpkdaWRYeg_A5xWuSMX=J7-VFMh+kjKVADO_wuhZ1n2Joskg@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1449863184-29668-1-git-send-email-afd@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 11, 2015 at 8:46 PM, Andrew F. Davis <afd@ti.com> wrote:

> This series adds a GPI(General Purpose Input) driver for generic
> parallel-in/serial-out shift registers, such as the SN65HVS882
> that this driver was tested on. This should also work for the rest
> of the SN65HVS88x series as well as other 74x165 style devices.

Pretty interesting, I'd like you to CC SPI maintainer Mark Brown
on this patch series, and the SPI mailing list.

Looking closer at the code.

Yours,
Linus Walleij
