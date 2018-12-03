From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Date: Mon, 3 Dec 2018 10:19:37 +0100
Message-ID: <20181203101937.7b01a0ad@bbrezillon>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Mon, 3 Dec 2018 08:39:00 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer

Can you take those 2 patches in your tree for 4.21/5.0?

>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support

I'll queue these ones after 4.21-rc1/5.0-rc1 is out (which means
they'll appear in 4.22/5.1).

>   arm64: dts: lx2160a: update fspi node
