From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 6/7] mtd: spinand: Use the spi-mem dirmap API
Date: Thu, 24 Jan 2019 09:49:44 +0100
Message-ID: <20190124094944.726dd4e0@bbrezillon>
References: <20181106160536.13415-1-boris.brezillon@bootlin.com>
 <20181106160536.13415-7-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Piotr Bugalski <bugalski.piotr@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Stefan Roese <sr@denx.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181106160536.13415-7-boris.brezillon@bootlin.com>
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

Hi Miquel,

On Tue,  6 Nov 2018 17:05:35 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Make use of the spi-mem direct mapping API to let advanced controllers
> optimize read/write operations when they support direct mapping.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Can we drop/revert this patch until we find out what's going on with
Stefan's setup. 

> +const struct spi_mem_op *
> +spinand_find_supported_op(struct spinand_device *spinand,
> +			  const struct spi_mem_op *ops,
> +			  unsigned int nops)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nops; i++) {
> +		if (spi_mem_supports_op(spinand->spimem, &ops[i]))
> +			return &ops[i];
> +	}
> +
> +	return NULL;
> +}
> +

Looks like this function is never used. Probably a leftover from
early versions of this patch :-/.

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
