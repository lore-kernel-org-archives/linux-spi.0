From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Date: Wed, 5 Dec 2018 17:25:12 +0530
Message-ID: <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203101937.7b01a0ad@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

On 03/12/18 2:49 PM, Boris Brezillon wrote:
> Hi Mark,
> 
> On Mon, 3 Dec 2018 08:39:00 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>>
>> Yogesh Gaur (7):
>>   spi: add support for octal mode I/O data transfer
>>   spi: spi-mem: add support for octal mode I/O data transfer
> 
> Can you take those 2 patches in your tree for 4.21/5.0?
> 

>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba

Could you consider merging these two patches alone for v4.21?
These can be applied independent of other patches in the series and
would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.

>>   mtd: m25p80: add support of octal mode I/O transfer
>>   spi: nxp-fspi: add octal mode flag bit for octal support
> 
> I'll queue these ones after 4.21-rc1/5.0-rc1 is out (which means
> they'll appear in 4.22/5.1).
> 
>>   arm64: dts: lx2160a: update fspi node

-- 
Regards
Vignesh
