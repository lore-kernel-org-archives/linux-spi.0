From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] spi: lpspi: add NULL check when probe device
Date: Tue, 23 Apr 2019 08:14:35 -0300
Message-ID: <CAOMZO5CQW5MvrTVGsoByUUcOWmSVowMUKcMzBhybAx2noHakbQ@mail.gmail.com>
References: <20190423104649.24483-1-xiaoning.wang@nxp.com> <20190423104649.24483-2-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423104649.24483-2-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Clark,

On Tue, Apr 23, 2019 at 7:47 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Add a NULL check for device node and lpspi_platform_info when lpspi
> device probe.

Please explain why you are adding such check.
