From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] spi: lpspi: add multi SS support in PIO mode
Date: Tue, 23 Apr 2019 08:21:34 -0300
Message-ID: <CAOMZO5CQ04UiYPoVjT6L3MuK6cCLu01Ba=-uui_Lf7t58n1tqQ@mail.gmail.com>
References: <20190423104649.24483-1-xiaoning.wang@nxp.com> <20190423104649.24483-3-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423104649.24483-3-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 23, 2019 at 7:48 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Add "fsl,spi-num-chipselects" check to support multi SS function in PIO
> mode.

This custom property does not seem to be needed as the number of chip
selects can be parsed from the devicetree file directly.

We got rid of "fsl,spi-num-chipselects" property in the spi-imx driver
in this commit:

commit b36581df7e788b674a4efbb8da7fe4a00c207e8b
Author: Alexander Shiyan <shc_work@mail.ru>
Date:   Wed Jun 8 20:02:06 2016 +0300

    spi: imx: Using existing properties for chipselects

    Patch reuse existing "chip_select" and "cs_gpio(s)" fields from SPI core.

    Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
    Signed-off-by: Mark Brown <broonie@kernel.org>

and we should try to also avoid such property in spi-fsl-lpspi as well.
