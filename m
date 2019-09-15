From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller
Date: Sun, 15 Sep 2019 14:00:33 +0300
Message-ID: <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com> <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 13, 2019 at 3:14 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
>
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> additional registers for software CS control and DMA. This patch does not
> address the changes required for DMA support, it simply adds the compatible
> string. The CS registers are not needed as Linux can use gpios for the CS
> signals.

> +       { .compatible = "renesas,rzn1-spi", },

Can't you simple use in DT something like
  compatible = "renesas,rzn1-spi", "snps,dw-apb-ssi"
?

-- 
With Best Regards,
Andy Shevchenko
