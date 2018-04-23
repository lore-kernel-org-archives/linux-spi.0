From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/9] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Tue, 24 Apr 2018 00:53:22 +0300
Message-ID: <CAHp75VfNzxGoSk==sdnOzp7LhuHVuanWAHOQk0eQC_g3Y3miQA@mail.gmail.com>
References: <20180422183522.11118-1-boris.brezillon@bootlin.com>
 <20180422183522.11118-4-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-spi <linux-spi@vger.kernel.org>, Peter Pan <peterpansjtu@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180422183522.11118-4-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 22, 2018 at 9:35 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Some controllers are exposing high-level interfaces to access various
> kind of SPI memories. Unfortunately they do not fit in the current
> spi_controller model and usually have drivers placed in
> drivers/mtd/spi-nor which are only supporting SPI NORs and not SPI
> memories in general.
>
> This is an attempt at defining a SPI memory interface which works for
> all kinds of SPI memories (NORs, NANDs, SRAMs).

> +config SPI_MEM
> +       bool "SPI memory extension"

> +#if IS_ENABLED(CONFIG_SPI_MEM)

IS_BUILTIN().
You defined it as boolean, IS_ENABLE() is superfluous.


> +#else
> +#endif /* CONFIG_SPI_MEM */

-- 
With Best Regards,
Andy Shevchenko

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
