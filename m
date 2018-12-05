From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Date: Wed, 5 Dec 2018 13:46:18 +0100
Message-ID: <20181205134618.56223758@bbrezillon>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
To: Vignesh R <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 5 Dec 2018 17:25:12 +0530
Vignesh R <vigneshr@ti.com> wrote:

> >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba  
> 
> Could you consider merging these two patches alone for v4.21?
> These can be applied independent of other patches in the series and
> would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.

Yep, I'll queue them to spi-nor/next.

> >>   spi: nxp-fspi: add octal mode flag bit for octal support  

Mark, I think you can pick this one too.
