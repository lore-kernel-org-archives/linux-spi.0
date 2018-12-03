From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Date: Mon, 3 Dec 2018 09:04:44 +0100
Message-ID: <20181203090444.0c37efa7@bbrezillon>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
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
In-Reply-To: <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Yogesh,

On Thu, 22 Nov 2018 05:14:31 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add flags for Octo mode I/O data transfer
> Required for the SPI controller which can do the data transfer (TX/RX)
> on 8 data lines e.g. NXP FlexSPI controller.
>  SPI_TX_OCTO: transmit with 8 wires
>  SPI_RX_OCTO: receive with 8 wires
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes for v4:
> - Rebase on top of v4.20-rc2
> Changes for v3:
> - Modified string 'octal' with 'octo'.

When I listed the differences between your version and mine, I
mentioned the OCTO vs OCTAL name, but I didn't say my decision was the
correct one :-). Looks like OCTAL is the term employed almost
everywhere, and it's also consistent with DUAL. Would you mind
sending a new version reverting the name to OCTAL.

Sorry for the unclear statement in my previous review.

Regards,

Boris
