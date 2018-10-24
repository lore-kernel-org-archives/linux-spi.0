From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
Date: Wed, 24 Oct 2018 07:56:47 -0300
Message-ID: <CAOMZO5DFgd2RsjRojWaDBOc2XxD47aQ1fkhxXYX-7BCAJnnVdA@mail.gmail.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com> <20181024075617.19548-4-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
To: xiaoning.wang@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024075617.19548-4-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Clark,

On Wed, Oct 24, 2018 at 5:01 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Enable the runtime pm for lpspi module
>
> BuildInfo:
>         - U-Boot 2018.03-imx_4.14.y

This buildinfo piece is not very helpful in upstream. Please drop it.

> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

Also, it would be nice if your From field (Clark Wang) could match
your Signed-off-by (Xiaoning Wang).

As Mark mentioned in case this patch comes from Han Xu, then his name
should go into the From field instead.
