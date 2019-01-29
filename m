From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info
Date: Tue, 29 Jan 2019 10:41:06 +0100
Message-ID: <20190129104106.4645346a@bbrezillon>
References: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548750550-23565-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 29 Jan 2019 08:31:19 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add MODULE_LICENSE info to fix below warning:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o
> 

You miss Fixes and Reported-by tags here.

> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 0327216ef7aa..90f3d2e4fe5d 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1103,3 +1103,4 @@ MODULE_AUTHOR("NXP Semiconductor");
>  MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
>  MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
>  MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
> +MODULE_LICENSE("GPL v2");
