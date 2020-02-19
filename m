From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v10 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Wed, 19 Feb 2020 09:28:09 +0100
Message-ID: <8b6c9a13-928a-9e9f-d5e2-e7320efc2a2f@denx.de>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200219022852.28065-1-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2/19/20 3:28 AM, Ramuthevar,Vadivel MuruganX wrote:
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
> 
> Thanks Mark and Vignesh for the review, suggestion to optimize the patch.
> Tested with mx25u12835f on LGM platform.

There is a typo in the subject -- it's quadspi , not quadpsi.
